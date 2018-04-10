{
    volScalarField rAU("rAU", 1.0/UEqn.A()); // 定义体积场rAU  根据预测的速度值求解系数矩阵对角元素的倒数
    surfaceScalarField rAUf("rAUf", fvc::interpolate(rAU));	//将体积场转化为表面场rAUf

    volVectorField HbyA("HbyA", U);
    HbyA = rAU*UEqn.H();      //定义HbyA

    surfaceScalarField phiHbyA   //定义phiHbyA
    (
        "phiHbyA",
        (fvc::interpolate(HbyA) & mesh.Sf())
      + fvc::interpolate(rho*rAU)*fvc::ddtCorr(U, phi)
            //此项考虑差值速度场计算的流率和实际流率的差别
    );
    MRF.makeRelative(phiHbyA);
    adjustPhi(phiHbyA, U, p_rgh);   //调整边值以满足连续性条件

    surfaceScalarField phig
    (
        (
            mixture.surfaceTensionForce()
                //==fvc::interpolate(interface.sigmaK())*fvc::snGrad(alpha1)
          - ghf*fvc::snGrad(rho)
        )*rAUf*mesh.magSf()
    );

    phiHbyA += phig; //公式25的 第4、5项

    // Update the fixedFluxPressure BCs to ensure flux consistency
    setSnGrad<fixedFluxPressureFvPatchScalarField>
    (
        p_rgh.boundaryField(),
        (
            phiHbyA.boundaryField()
          - MRF.relative(mesh.Sf().boundaryField() & U.boundaryField())
        )/(mesh.magSf().boundaryField()*rAUf.boundaryField())
    );

    while (pimple.correctNonOrthogonal())   //进行非正交性循环修正
    {
        fvScalarMatrix p_rghEqn    //构建p_rgh压力方程
        (
            fvm::laplacian(rAUf, p_rgh) == fvc::div(phiHbyA)
        );

        p_rghEqn.setReference(pRefCell, getRefCellValue(p_rgh, pRefCell));    //设定压力参考值

        p_rghEqn.solve(mesh.solver(p_rgh.select(pimple.finalInnerIter())));   //求解压力方程,求得p_rgh

        if (pimple.finalNonOrthogonalIter())//最后一次正交修正
        {
            phi = phiHbyA - p_rghEqn.flux();  //更新表面流率phi      http://www.cfd-online.com/Forums/openfoam/114933-description-flux-method.html

            p_rgh.relax();   //松弛以提高稳定性

            U = HbyA + rAU*fvc::reconstruct((phig - p_rghEqn.flux())/rAUf);//通过求解的压力，修正速度
            U.correctBoundaryConditions();//对速度场边界进行修正
            fvOptions.correct(U); //修正源项
        }
    }

    #include "continuityErrs.H"  //计算连续性误差

    p == p_rgh + rho*gh;    //更新压力P

    if (p_rgh.needReference())   //通过参考压力p_rgh更新压力p
    {
        p += dimensionedScalar
        (
            "p",
            p.dimensions(),
            pRefValue - getRefCellValue(p, pRefCell)
        );
        p_rgh = p - rho*gh;
    }
}
