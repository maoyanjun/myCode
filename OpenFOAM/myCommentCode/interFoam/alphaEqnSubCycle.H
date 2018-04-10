if (nAlphaSubCycles > 1)   //nAlphaSubCycles代表分割的时间步个数
{
    dimensionedScalar totalDeltaT = runTime.deltaT();   //总时间步长=deltaT
    surfaceScalarField rhoPhiSum      //定义rhoPhiSum
    (
        IOobject
        (
            "rhoPhiSum",
            runTime.timeName(),
            mesh
        ),
        mesh,
        dimensionedScalar("0", rhoPhi.dimensions(), 0)
    );

    tmp<volScalarField> trSubDeltaT;

    if (LTS)
    {
        trSubDeltaT =
            fv::localEulerDdt::localRSubDeltaT(mesh, nAlphaSubCycles);
    }

    for
    (
        subCycle<volScalarField> alphaSubCycle(alpha1, nAlphaSubCycles);  //多次循环计算相方程
        !(++alphaSubCycle).end();
    )
    {
        #include "alphaEqn.H"
        rhoPhiSum += (runTime.deltaT()/totalDeltaT)*rhoPhi;   //加和计算整个所有子时间步的rhoPhi
    }

    rhoPhi = rhoPhiSum;
}
else  //nAlphaSubCycles=1时 不分割时间步
{
    #include "alphaEqn.H"   //求解rhoPhi ,alpha，更新曲率k
}

rho == alpha1*rho1 + alpha2*rho2;  //	求解加权的 rho
