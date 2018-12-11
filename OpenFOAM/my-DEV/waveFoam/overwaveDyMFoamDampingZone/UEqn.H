    MRF.correctBoundaryVelocity(U);
    dimensionedScalar theta0
    (
      "theta0",
      dimensionSet(0,0,-1,0,0,0,0),
      0
    );
    
    IOdictionary relaxation
    (
      IOobject
      (
       "relaxation",
       runTime.constant(),
       mesh,
       IOobject::MUST_READ,
       IOobject::NO_WRITE 
      )
    );
    dimensionedScalar theta1
    (
      relaxation.lookup("dampCoeff")
    );
    
    dimensionedScalar x1=max(mesh.Cf().component(vector::X))-min(mesh.Cf().component(vector::X));
    dimensionedScalar x0
    (
     relaxation.lookup("dampZoneStartPoint")
    );
    volScalarField thetaField
    (
      "thetaField",
      min(max(theta1*(mesh.C().component(vector::X)-x0)/(x1-x0),theta0),theta1)
    );
    
    fvVectorMatrix UEqn
    (
        fvm::ddt(rho, U) + fvm::div(rhoPhi, U)
      - fvm::Sp(fvc::ddt(rho) + fvc::div(rhoPhi), U)
      + MRF.DDt(rho, U)
      + turbulence->divDevRhoReff(rho, U)+U*rho*thetaField
     ==
        fvOptions(rho, U)
    );

    UEqn.relax();

    fvOptions.constrain(UEqn);

    if (pimple.momentumPredictor())
    {
        solve
        (
            UEqn
         ==
            cellMask*fvc::reconstruct
            (
                (
                    mixture.surfaceTensionForce()
                  - ghf*fvc::snGrad(rho)
                  - fvc::snGrad(p_rgh)
                ) * mesh.magSf()
            )
        );

        fvOptions.correct(U);
    }
