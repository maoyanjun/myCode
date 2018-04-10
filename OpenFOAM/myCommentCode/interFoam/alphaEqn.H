//// ********************************************   2.2.0 版本    *******************************************////

    word alphaScheme("div(phi,alpha)");
    word alpharScheme("div(phirb,alpha)");
    surfaceScalarField phic(mag(phi/mesh.magSf()));    // 定义表面速度绝对值  phic 即 丨U丨
    phic = min(interface.cAlpha()*phic, max(phic));    //丨U丨=min (cAlpha*丨U丨，max(丨U丨))
    surfaceScalarField phir(phic*interface.nHatf());   // Ur = 丨U丨* n *Sf   其中，nHatf()为自由表面的单位法向量*Sf
                                                       //   surfaceVectorField nHatfv(gradAlphaf/(mag(gradAlphaf) + deltaN_));
    for (int aCorr=0; aCorr<nAlphaCorr; aCorr++)       //   deltaN_= 1e-8/pow(average(alpha1.mesh().V()), 1.0/3.0)   非常小的值 保证分母不为0        
                                                       //   nHatf_ = nHatfv & Sf; 
    {                                                  
        surfaceScalarField phiAlpha
        (
            fvc::flux                                                    // phi*alpha1 （U*alpha1）
            (
                phi,
                alpha1,
                alphaScheme
            )
          + fvc::flux                                                  // Ur*(1-alpha1)*alpha1
            (
                -fvc::flux(-phir, scalar(1) - alpha1, alpharScheme),   //  Ur*(1-alpha1)
                alpha1,                                                // *alpha1
                alpharScheme
            )
        );

        MULES::explicitSolve(alpha1, phi, phiAlpha, 1, 0);  // 求解alpha1  其值 范围是0~1  

        rhoPhi = phiAlpha*(rho1 - rho2) + phi*rho2;   // rhoPhi = alpha1*(rho1-rho2)+(alpha1+alpha2)*U*rho2  ==  alpha1*U*rho1+alpha2*U*rho2
    }

    Info<< "Phase-1 volume fraction = "
        << alpha1.weightedAverage(mesh.Vsc()).value()
        << "  Min(alpha1) = " << min(alpha1).value()
        << "  Max(alpha1) = " << max(alpha1).value()
        << endl;
}



//// ********************************************   3.0.1 版本    *******************************************////

{
    word alphaScheme("div(phi,alpha)");
    word alpharScheme("div(phirb,alpha)");

    tmp<fv::ddtScheme<scalar> > ddtAlpha   //创建tmp类模板  求解alpha的时间导数
    (
        fv::ddtScheme<scalar>::New
        (
            mesh,
            mesh.ddtScheme("ddt(alpha)")
        )
    );

    // Set the off-centering coefficient according to ddt scheme
    scalar ocCoeff = 0;     //设置ddt格式的偏心系数
    if                      //如果是Euler或者localEuler时间离散格式  ocCoeff = 0
    (
        isType<fv::EulerDdtScheme<scalar> >(ddtAlpha())
     || isType<fv::localEulerDdtScheme<scalar> >(ddtAlpha())
    )
    {
        ocCoeff = 0;
    }
    else if (isType<fv::CrankNicolsonDdtScheme<scalar> >(ddtAlpha()))
    {
        if (nAlphaSubCycles > 1)
        {
            FatalErrorIn(args.executable())
                << "Sub-cycling is not supported "
                   "with the CrankNicolson ddt scheme"
                << exit(FatalError);
        }

        ocCoeff =
            refCast<fv::CrankNicolsonDdtScheme<scalar> >(ddtAlpha()).ocCoeff();
    }
    else
    {
        FatalErrorIn(args.executable())
            << "Only Euler and CrankNicolson ddt schemes are supported"
            << exit(FatalError);
    }

    scalar cnCoeff = 1.0/(1.0 + ocCoeff);   //设置C-N格式的系数 

    // Standard face-flux compression coefficient  //设置标准的表面流率压缩系数 
    surfaceScalarField phic(mixture.cAlpha()*mag(phi/mesh.magSf()));  //Uc=cAlpha*丨U丨      mesh.magSf()=丨A丨     phi = linearInterpolate(U) & mesh.Sf()

    // Add the optional isotropic compression contribution   //根据各向同性压缩因子icAlpha  添加同向压缩贡献
    if (icAlpha > 0)   // 默认 icAlpha = 0 (一般不考虑此项)
    {
        phic *= (1.0 - icAlpha);                                      //Uc=cAlpha*丨U丨*(1-icAlpha)
        phic += (mixture.cAlpha()*icAlpha)*fvc::interpolate(mag(U));  // Uc=cAlpha*丨U丨*(1-icAlpha)+ cAlpha*icAlpha*丨U丨= cAlpha*丨U丨
    }

    // Do not compress interface at non-coupled boundary faces  //在不耦合的边界面不添加压缩项
    // (inlets, outlets etc.)
    forAll(phic.boundaryField(), patchi)   
    {
        fvsPatchScalarField& phicp = phic.boundaryField()[patchi];

        if (!phicp.coupled())
        {
            phicp == 0;
        }
    }

    tmp<surfaceScalarField> phiCN(phi); //定义phiCN=phi

    // Calculate the Crank-Nicolson off-centred volumetric flux
    if (ocCoeff > 0)
    {
        phiCN = cnCoeff*phi + (1.0 - cnCoeff)*phi.oldTime();    //求解CN格式下的加权phiCN
    }

    if (MULESCorr)    //采用MULES修正方法求解相方程
    {
        fvScalarMatrix alpha1Eqn   //不带压缩项的相方程 （散度项）  
        (
            (
                LTS
              ? fv::localEulerDdtScheme<scalar>(mesh).fvmDdt(alpha1)
              : fv::EulerDdtScheme<scalar>(mesh).fvmDdt(alpha1)    //相方程第一项
            )
          + fv::gaussConvectionScheme<scalar>         
            (
                mesh,
                phiCN,
                upwind<scalar>(mesh, phiCN)
            ).fvmDiv(phiCN, alpha1)       //相方程第二项
        );

        alpha1Eqn.solve();    //  求解相方程

        Info<< "Phase-1 volume fraction = "      //输出alpha值
            << alpha1.weightedAverage(mesh.Vsc()).value()
            << "  Min(" << alpha1.name() << ") = " << min(alpha1).value()
            << "  Max(" << alpha1.name() << ") = " << max(alpha1).value()
            << endl;

        tmp<surfaceScalarField> talphaPhiUD(alpha1Eqn.flux());   // talphaPhiUD = fvmDiv(phiCN, alpha1)  =  U * alpha1
        alphaPhi = talphaPhiUD();                                //alphaPhi =  talphaPhiUD = fvmDiv(phiCN, alpha1)=  U * alpha1

        if (alphaApplyPrevCorr && talphaPhiCorr0.valid())  // talphaPhiCorr 默认为关闭
                                                           // Apply the compression correction from the previous iteration
                                                           // Improves efficiency for steady-simulations but can only be applied                                                         	
                                                           // once the alpha field is reasonably steady, i.e. fully developed
        {
            Info<< "Applying the previous iteration compression flux" << endl;  //应用上一迭代步的压缩通量
            MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);  //采用MULES对相方程进行修正

            alphaPhi += talphaPhiCorr0();
        }

        // Cache the upwind-flux
        talphaPhiCorr0 = talphaPhiUD;    //存储迎风格式下的 talphaPhiUD 

        alpha2 = 1.0 - alpha1;    //分别求得alpha1、alpha2

        mixture.correct();    //修正平均运动粘度 和 界面曲率
    }


    for (int aCorr=0; aCorr<nAlphaCorr; aCorr++)    // 进入alpha方程循环，即多次求解相方程进行修正
    {                                            
    	                                 //   surfaceVectorField nHatfv(gradAlphaf/(mag(gradAlphaf) + deltaN_)); 
    	                                 //   deltaN_= 1e-8/pow(average(alpha1.mesh().V()), 1.0/3.0)   非常小的值 保证分母不为0 
    	                                 //   nHatf_ = nHatfv & Sf;
    	                                 //   http://www.cfd-online.com/Forums/openfoam-solving/58149-about-gammaeqn-interfoam.html
    	                                 
        surfaceScalarField phir(phic*mixture.nHatf());  // phir -> Ur = Uc*n*Sf   其中，nHatf()为自由表面的单位法向量*Sf
                                                      

        tmp<surfaceScalarField> talphaPhiUn            //带压缩项的相方程 （散度项）
        (
            fvc::flux                                 // phi*alpha1 （U*alpha1）
            (
                phi,
                alpha1,
                alphaScheme
            )
          + fvc::flux      //压缩项                 // Ur*(1-alpha1)*alpha1
            (
               -fvc::flux(-phir, alpha2, alpharScheme),    //  Ur*(1-alpha1)
                alpha1,                                    //*alpha1
                alpharScheme
            )
        );

        // Calculate the Crank-Nicolson off-centred alpha flux
        if (ocCoeff > 0)
        {
            talphaPhiUn =
                cnCoeff*talphaPhiUn + (1.0 - cnCoeff)*alphaPhi.oldTime();      //加权的talphaPhi定义为talphaPhiUn
        }

        if (MULESCorr)    //进行MULES修正
        {
            tmp<surfaceScalarField> talphaPhiCorr(talphaPhiUn() - alphaPhi);  //修正值： talphaPhiCorr = talphaPhiUn() - alphaPhi
            volScalarField alpha10("alpha10", alpha1);                        //alpha10=alpha1

            MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);  //带压缩项的相方程

            // Under-relax the correction for all but the 1st corrector
            if (aCorr == 0)   //第一次循环
            {
                alphaPhi += talphaPhiCorr();           //第一次循环时带入 alphaPhi = talphaPhiUn()
            }
            else
            {
                alpha1 = 0.5*alpha1 + 0.5*alpha10;    // 加权修正 alpha1
                alphaPhi += 0.5*talphaPhiCorr();      // alphaPhi= alphaPhi + 0.5*talphaPhiCorr()   
            }
        }
        else
        {
            alphaPhi = talphaPhiUn;                  //不进行MULES修正时，直接带入talphaPhiUn ，再次求解相方程 

            MULES::explicitSolve(alpha1, phiCN, alphaPhi, 1, 0);
        }

        alpha2 = 1.0 - alpha1;

        mixture.correct();      //修正平均运动粘度 和 界面曲率
    }

    if (alphaApplyPrevCorr && MULESCorr)    
    {		
        talphaPhiCorr0 = alphaPhi - talphaPhiCorr0;
    }

    if
    (
        word(mesh.ddtScheme("ddt(rho,U)"))
     == fv::EulerDdtScheme<vector>::typeName
    )
    {
        rhoPhi = alphaPhi*(rho1 - rho2) + phiCN*rho2;     // alpha1*U*(rho1-rho2)+(alpha1+alpha2)*U*rho2  ==  alpha1*U*rho1+alpha2*U*rho2
    }
    else                                                  //如果是CN离散格式，更新CN加权rhoPhi
    {
        if (ocCoeff > 0)
        {
            // Calculate the end-of-time-step alpha flux
            alphaPhi = (alphaPhi - (1.0 - cnCoeff)*alphaPhi.oldTime())/cnCoeff;    //求解alphaPhi
        }

        // Calculate the end-of-time-step mass flux
        rhoPhi = alphaPhi*(rho1 - rho2) + phi*rho2;    //求解rhoPhi = U*(alpha1*rho1+alpha2*rho2）
    }

    Info<< "Phase-1 volume fraction = "
        << alpha1.weightedAverage(mesh.Vsc()).value()
        << "  Min(" << alpha1.name() << ") = " << min(alpha1).value()
        << "  Max(" << alpha1.name() << ") = " << max(alpha1).value()
        << endl;
}

