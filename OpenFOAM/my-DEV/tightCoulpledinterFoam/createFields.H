Info<< "Reading field p_rgh\n" << endl;
volScalarField p_rgh   //创建参考压力标量场
(
    IOobject
    (
        "p_rgh",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

Info<< "Reading field U\n" << endl;
volVectorField U   //创建速度矢量场
(
    IOobject
    (
        "U",
        runTime.timeName(),
        mesh,
        IOobject::MUST_READ,
        IOobject::AUTO_WRITE
    ),
    mesh
);

#include "createPhi.H"    //创建界面流率场


Info<< "Reading transportProperties\n" << endl;
immiscibleIncompressibleTwoPhaseMixture mixture(U, phi);

volScalarField& alpha1(mixture.alpha1());   //引用alpha1
volScalarField& alpha2(mixture.alpha2());    //引用alpha2

const dimensionedScalar& rho1 = mixture.rho1();    //引用rho1
const dimensionedScalar& rho2 = mixture.rho2();     //引用rho2


// Need to store rho for ddt(rho, U)
volScalarField rho   //创建密度场
(
    IOobject
    (
        "rho",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT
    ),
    alpha1*rho1 + alpha2*rho2,   //加权rho=alpha1*rho1 + alpha2*rho2
    alpha1.boundaryField().types()
);
rho.oldTime();   //储存旧rho


// Mass flux
surfaceScalarField rhoPhi    //创建质量通量场
(
    IOobject
    (
        "rhoPhi",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::NO_WRITE
    ),
    fvc::interpolate(rho)*phi
);


// Construct incompressible turbulence model
autoPtr<incompressible::turbulenceModel> turbulence   //构建不可压湍流模型
(
    incompressible::turbulenceModel::New(U, phi, mixture)
);


#include "readGravitationalAcceleration.H"   //构建重力场
#include "readhRef.H"     //读取参考压力  参考网格
#include "gh.H"


volScalarField p   //构建压力场
(
    IOobject
    (
        "p",
        runTime.timeName(),
        mesh,
        IOobject::NO_READ,
        IOobject::AUTO_WRITE
    ),
    p_rgh + rho*gh
);

label pRefCell = 0;   //初始化参考网格
scalar pRefValue = 0.0;   //初始化参考压力
setRefCell              //设置参考网格及参考压力
(
    p,
    p_rgh,
    pimple.dict(),
    pRefCell,
    pRefValue
);

if (p_rgh.needReference())     //根据参考水平面，计算压力p及参考压力p_rgh
{
    p += dimensionedScalar
    (
        "p",
        p.dimensions(),
        pRefValue - getRefCellValue(p, pRefCell)
    );
    p_rgh = p - rho*gh;
}

mesh.setFluxRequired(p_rgh.name());
mesh.setFluxRequired(alpha1.name());

// MULES flux from previous time-step
surfaceScalarField alphaPhi         //创建alphaPhi场
(
    IOobject
    (
        "alphaPhi",
        runTime.timeName(),
        mesh,
        IOobject::READ_IF_PRESENT,
        IOobject::AUTO_WRITE
    ),
    phi*fvc::interpolate(alpha1)
);

// MULES Correction
tmp<surfaceScalarField> talphaPhiCorr0;
