    MRF.correctBoundaryVelocity(U);  //对速度边界进行修正

    fvVectorMatrix UEqn    //采用上一时刻的P  离散动量方程  求解预测速度
    (
        fvm::ddt(rho, U) + fvm::div(rhoPhi, U)
      + MRF.DDt(rho, U)    //旋转坐标
      + turbulence->divDevRhoReff(rho, U)     //http://www.cfd-online.com/Forums/openfoam-solving/58214-calculating-divdevreff-2.html
     ==
        fvOptions(rho, U)
    );

    UEqn.relax();  //松弛以保证求解的稳定性

    fvOptions.constrain(UEqn);  

    if (pimple.momentumPredictor())  //开启动量预测，求解动量方程
    {
        solve
        (
            UEqn
         ==
            fvc::reconstruct
            (
                (
                    mixture.surfaceTensionForce()  //==fvc::interpolate(interface.sigmaK())*fvc::snGrad(alpha1)
                  - ghf*fvc::snGrad(rho)
                  - fvc::snGrad(p_rgh)
                ) * mesh.magSf()
            )
        );

        fvOptions.correct(U);   //进行源项的修正
    }
