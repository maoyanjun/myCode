

=====================================
    ENVIRONMENTAL VARIABLES
=====================================
EXTBRANCH=0
FOAMEXTENDPROJECT=0
OFPLUSBRANCH=0
WAVES_APPBIN=/home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/bin
WAVES_DIR=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam
WAVES_GSL_INCLUDE=/usr/include
WAVES_GSL_LIB=/usr/lib64
WAVES_LIBBIN=/home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/lib
WAVES_POST=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/utilities/postProcessing
WAVES_PRE=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/utilities/preProcessing
WAVES_SOL=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/solvers/solvers17060
WAVES_SRC=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src
WAVES_TUT=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/tutorials
WAVES_UTIL=/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/utilities
WAVES_XVERSION=0
WM_PROJECT_VERSION_NUMBER=17060

=====================================
    COMPILE LAPACK-3.3.1
=====================================

lapack-3.3.1 has already been compiled

=====================================
    COMPILE SPARSKIT2
=====================================

SPARSKIT2 has already been compiled

=====================================
    COMPILE OCEANWAVE3D
=====================================

Pull changes from the OceanWave3D git repository ...

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'shzx@T630.(none)')
Cannot save the current index state
No stash found.

OceanWave3D has already been compiled

/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/ThirdParty
=====================================
    COMPILE FENTON4FOAM
=====================================

fenton4Foam has already been compiled

=====================================
    COMPILE LIBRARY
=====================================

wmake libso (waves2Foam)
wmake libso (waves2FoamProcessing)
g++ -std=c++11 -m64 -DOPENFOAM_PLUS=1706 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=64 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -O3  -DNoRepository -ftemplate-depth-100 -DOFVERSION=17060 -DEXTBRANCH=0 -DXVERSION=0 -DOFPLUSBRANCH=0 -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/meshTools/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/sampling/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/lagrangian/basic/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/fileFormats/lnInclude -I/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src/waves2Foam/lnInclude -I/usr/include -IlnInclude -I. -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OSspecific/POSIX/lnInclude   -fPIC -c postProcessing/postProcessingWaves/postProcessingWaves.C -o Make/linux64GccDPInt64Opt/postProcessing/postProcessingWaves/postProcessingWaves.o
postProcessing/postProcessingWaves/postProcessingWaves.C: In member function ‘Foam::word Foam::postProcessingWaves::dataType()’:
postProcessing/postProcessingWaves/postProcessingWaves.C:303:21: error: ‘class Foam::IOobject’ has no member named ‘headerOk’
     if (!fileHeader.headerOk())
                     ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/wmake/rules/General/transform:28: recipe for target 'Make/linux64GccDPInt64Opt/postProcessing/postProcessingWaves/postProcessingWaves.o' failed
make: *** [Make/linux64GccDPInt64Opt/postProcessing/postProcessingWaves/postProcessingWaves.o] Error 1
wmake libso (waves2FoamPorosity)

=====================================
    COMPILE SOLVERS
=====================================
Making dependency list for source file waveFoam.C
g++ -std=c++11 -m64 -DOPENFOAM_PLUS=1706 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=64 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -O3  -DNoRepository -ftemplate-depth-100 -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/transportModels/twoPhaseMixture/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/transportModels -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/transportModels/incompressible/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/transportModels/interfaceProperties/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/TurbulenceModels/turbulenceModels/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/TurbulenceModels/incompressible/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/transportModels/immiscibleIncompressibleTwoPhaseMixture/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/fvOptions/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/meshTools/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/sampling/lnInclude -DOFVERSION=300 -DEXTBRANCH=0 -DOFPLUSBRANCH=0 -DXVERSION=0 -I/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src/waves2Foam/lnInclude -I/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src/waves2FoamSampling/lnInclude -I/usr/include -IlnInclude -I. -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OSspecific/POSIX/lnInclude   -fPIC -c waveFoam.C -o Make/linux64GccDPInt64Opt/waveFoam.o
In file included from waveFoam.C:78:0:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/createFvOptions.H: In function ‘int main(int, char**)’:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/createFvOptions.H:1:1: error: ‘options’ is not a member of ‘Foam::fv’
 fv::options& fvOptions(fv::options::New(mesh));
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/createFvOptions.H:1:28: error: ‘Foam::fv::options’ has not been declared
 fv::options& fvOptions(fv::options::New(mesh));
                            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/createFvOptions.H:1:46: error: ‘fvOptions’ was not declared in this scope
 fv::options& fvOptions(fv::options::New(mesh));
                                              ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:2:39: error: binding ‘const Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>’ to reference of type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’ discards qualifiers
     volScalarField& rDeltaT = trDeltaT();
                                       ^
setRDeltaT.H:59:13: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
     rDeltaT.dimensionedInternalField() = max
             ^
setRDeltaT.H:62:40: error: ‘const class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>’ has no member named ‘dimensionedInternalField’
         fvc::surfaceSum(mag(rhoPhi))().dimensionedInternalField()
                                        ^
setRDeltaT.H:63:33: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
        /((2*maxCo)*mesh.V()*rho.dimensionedInternalField())
                                 ^
setRDeltaT.H:73:17: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
         rDeltaT.dimensionedInternalField() = max
                 ^
setRDeltaT.H:75:21: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
             rDeltaT.dimensionedInternalField(),
                     ^
setRDeltaT.H:76:27: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
             pos(alpha1Bar.dimensionedInternalField() - alphaSpreadMin)
                           ^
setRDeltaT.H:77:44: error: ‘Foam::volScalarField {aka class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>}’ has no member named ‘dimensionedInternalField’
            *pos(alphaSpreadMax - alpha1Bar.dimensionedInternalField())
                                            ^
setRDeltaT.H:78:41: error: ‘const class Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>’ has no member named ‘dimensionedInternalField’
            *fvc::surfaceSum(mag(phi))().dimensionedInternalField()
                                         ^
setRDeltaT.H:87:42: error: no matching function for call to ‘gMin(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:87:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:87:42: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << gMin(1/rDeltaT.internalField())
                                          ^
setRDeltaT.H:87:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:87:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:87:42: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << gMin(1/rDeltaT.internalField())
                                          ^
setRDeltaT.H:87:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
setRDeltaT.H:88:50: error: no matching function for call to ‘gMax(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:88:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:88:50: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
setRDeltaT.H:88:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:88:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:88:50: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
setRDeltaT.H:88:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
setRDeltaT.H:114:42: error: no matching function for call to ‘gMin(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:114:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:114:42: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << gMin(1/rDeltaT.internalField())
                                          ^
setRDeltaT.H:114:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:114:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
         << gMin(1/rDeltaT.internalField())
                                          ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:114:42: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << gMin(1/rDeltaT.internalField())
                                          ^
setRDeltaT.H:114:42: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
setRDeltaT.H:115:50: error: no matching function for call to ‘gMax(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:115:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:115:50: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
setRDeltaT.H:115:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:115:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:115:50: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
         << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                  ^
setRDeltaT.H:115:50: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
setRDeltaT.H:133:46: error: no matching function for call to ‘gMin(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
             << gMin(1/rDeltaT.internalField())
                                              ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:133:46: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
             << gMin(1/rDeltaT.internalField())
                                              ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note: candidate: template<class Type> Type Foam::gMin(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:542:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:133:46: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
             << gMin(1/rDeltaT.internalField())
                                              ^
setRDeltaT.H:133:46: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:133:46: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
             << gMin(1/rDeltaT.internalField())
                                              ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMin(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMin, min, min)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:558:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMin, min, min)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:133:46: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
             << gMin(1/rDeltaT.internalField())
                                              ^
setRDeltaT.H:133:46: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
setRDeltaT.H:134:54: error: no matching function for call to ‘gMax(Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >)’
             << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                      ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::UList<T>&, Foam::label)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:533:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 ReturnType gFunc(const UList<Type>& f, const label comm)                       \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:134:54: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::UList<T>’
             << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                      ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.C:876:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Field.H:408,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/scalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionSet.H:46,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedType.H:40,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/dimensionedScalar.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/TimeState.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Time.H:47,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:6,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note: candidate: template<class Type> Type Foam::gMax(const Foam::tmp<Foam::Field<Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:303:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 ReturnType Func(const tmp<Field<Type>>& tf1)                                   \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFunctions.C:541:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:134:54: note:   mismatched types ‘Foam::Field<Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
             << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                      ^
setRDeltaT.H:134:54: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::Field<Type> >’
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::FieldField<Field, Type>&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:549:12: note: in definition of macro ‘G_UNARY_FUNCTION’
 returnType gFunc(const FieldField<Field, Type>& f)                             \
            ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:134:54: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::FieldField<Field, Type>’
             << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                      ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.C:390:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldField.H:198,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricField.H:45,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricScalarField.H:38,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/GeometricFields.H:34,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/volFields.H:37,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.C:27,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolationScheme.H:307,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/surfaceInterpolate.H:41,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvc.H:39,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:8,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note: candidate: template<template<class> class Field, class Type> Type Foam::gMax(const Foam::tmp<Foam::FieldField<Field, Type> >&)
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:24: note:   template argument deduction/substitution failed:
 G_UNARY_FUNCTION(Type, gMax, max, max)
                        ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:400:12: note: in definition of macro ‘TMP_UNARY_FUNCTION’
 returnType func(const tmp<FieldField<Field, Type>>& tf1)                       \
            ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/FieldFieldFunctions.C:557:1: note: in expansion of macro ‘G_UNARY_FUNCTION’
 G_UNARY_FUNCTION(Type, gMax, max, max)
 ^
In file included from waveFoam.C:98:0:
setRDeltaT.H:134:54: note:   mismatched types ‘Foam::FieldField<Field, Type>’ and ‘Foam::DimensionedField<double, Foam::volMesh>’
             << ", " << gMax(1/rDeltaT.internalField()) << endl;
                                                      ^
setRDeltaT.H:134:54: note:   ‘Foam::tmp<Foam::DimensionedField<double, Foam::volMesh> >’ is not derived from ‘const Foam::tmp<Foam::FieldField<Field, Type> >’
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:60:65: error: binding ‘const Foam::fvsPatchField<double>’ to reference of type ‘Foam::fvsPatchScalarField& {aka Foam::fvsPatchField<double>&}’ discards qualifiers
         fvsPatchScalarField& phicp = phic.boundaryField()[patchi];
                                                                 ^
alphaEqn.H:107:68: error: no matching function for call to ‘correct(Foam::volScalarField&, Foam::surfaceScalarField&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, int, int)’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                                    ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note: candidate: template<class RdeltaTType, class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RdeltaTType&, const RhoType&, Foam::volScalarField&, const surfaceScalarField&, const surfaceScalarField&, const SpType&, const SuType&)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:107:60: note:   cannot convert ‘talphaPhiCorr0.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                            ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note: candidate: template<class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RhoType&, Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, const SpType&, const SuType&, Foam::scalar, Foam::scalar)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:107:68: note:   cannot convert ‘alphaPhi’ (type ‘Foam::surfaceScalarField {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>}’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                                    ^
In file included from waveFoam.C:41:0:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note: candidate: void Foam::MULES::correct(Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, Foam::scalar, Foam::scalar) <near match>
 void correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note:   conversion of argument 3 would be ill-formed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:107:60: error: binding ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’ to reference of type ‘Foam::surfaceScalarField& {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&}’ discards qualifiers
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                            ^
alphaEqn.H:153:72: error: no matching function for call to ‘correct(Foam::volScalarField&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, int, int)’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                        ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note: candidate: template<class RdeltaTType, class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RdeltaTType&, const RhoType&, Foam::volScalarField&, const surfaceScalarField&, const surfaceScalarField&, const SpType&, const SuType&)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:153:64: note:   cannot convert ‘talphaPhiCorr.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note: candidate: template<class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RhoType&, Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, const SpType&, const SuType&, Foam::scalar, Foam::scalar)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:153:47: note:   cannot convert ‘talphaPhiUn.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                               ^
In file included from waveFoam.C:41:0:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note: candidate: void Foam::MULES::correct(Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, Foam::scalar, Foam::scalar) <near match>
 void correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note:   conversion of argument 3 would be ill-formed:
In file included from alphaEqnSubCycle.H:30:0,
                 from waveFoam.C:117:
alphaEqn.H:153:64: error: binding ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’ to reference of type ‘Foam::surfaceScalarField& {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&}’ discards qualifiers
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                ^
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:60:65: error: binding ‘const Foam::fvsPatchField<double>’ to reference of type ‘Foam::fvsPatchScalarField& {aka Foam::fvsPatchField<double>&}’ discards qualifiers
         fvsPatchScalarField& phicp = phic.boundaryField()[patchi];
                                                                 ^
alphaEqn.H:107:68: error: no matching function for call to ‘correct(Foam::volScalarField&, Foam::surfaceScalarField&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, int, int)’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                                    ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note: candidate: template<class RdeltaTType, class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RdeltaTType&, const RhoType&, Foam::volScalarField&, const surfaceScalarField&, const surfaceScalarField&, const SpType&, const SuType&)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:107:60: note:   cannot convert ‘talphaPhiCorr0.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                            ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note: candidate: template<class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RhoType&, Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, const SpType&, const SuType&, Foam::scalar, Foam::scalar)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:107:68: note:   cannot convert ‘alphaPhi’ (type ‘Foam::surfaceScalarField {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>}’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                                    ^
In file included from waveFoam.C:41:0:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note: candidate: void Foam::MULES::correct(Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, Foam::scalar, Foam::scalar) <near match>
 void correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note:   conversion of argument 3 would be ill-formed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:107:60: error: binding ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’ to reference of type ‘Foam::surfaceScalarField& {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&}’ discards qualifiers
             MULES::correct(alpha1, alphaPhi, talphaPhiCorr0(), 1, 0);
                                                            ^
alphaEqn.H:153:72: error: no matching function for call to ‘correct(Foam::volScalarField&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&, int, int)’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                        ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note: candidate: template<class RdeltaTType, class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RdeltaTType&, const RhoType&, Foam::volScalarField&, const surfaceScalarField&, const surfaceScalarField&, const SpType&, const SuType&)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:36:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:153:64: note:   cannot convert ‘talphaPhiCorr.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:135:0,
                 from waveFoam.C:41:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note: candidate: template<class RhoType, class SpType, class SuType> void Foam::MULES::correct(const RhoType&, Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, const SpType&, const SuType&, Foam::scalar, Foam::scalar)
 void Foam::MULES::correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULESTemplates.C:78:6: note:   template argument deduction/substitution failed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:153:47: note:   cannot convert ‘talphaPhiUn.Foam::tmp<T>::operator()<Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh> >()’ (type ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’) to type ‘Foam::volScalarField& {aka Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>&}’
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                               ^
In file included from waveFoam.C:41:0:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note: candidate: void Foam::MULES::correct(Foam::volScalarField&, const surfaceScalarField&, Foam::surfaceScalarField&, Foam::scalar, Foam::scalar) <near match>
 void correct
      ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/CMULES.H:88:6: note:   conversion of argument 3 would be ill-formed:
In file included from alphaEqnSubCycle.H:38:0,
                 from waveFoam.C:117:
alphaEqn.H:153:64: error: binding ‘const Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>’ to reference of type ‘Foam::surfaceScalarField& {aka Foam::GeometricField<double, Foam::fvsPatchField, Foam::surfaceMesh>&}’ discards qualifiers
             MULES::correct(alpha1, talphaPhiUn(), talphaPhiCorr(), 1, 0);
                                                                ^
In file included from waveFoam.C:128:0:
pEqn.H:35:5: error: no matching function for call to ‘setSnGrad(const Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary&, Foam::tmp<Foam::FieldField<Foam::fvsPatchField, double> >)’
     );
     ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:17:0,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fixedFluxPressureFvPatchScalarField.H:168:17: note: candidate: template<class GradBC> void Foam::setSnGrad(Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary&, const Foam::FieldField<Foam::fvsPatchField, double>&)
     inline void setSnGrad
                 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fixedFluxPressureFvPatchScalarField.H:168:17: note:   template argument deduction/substitution failed:
In file included from waveFoam.C:128:0:
pEqn.H:30:28: note:   cannot convert ‘p_rgh.Foam::GeometricField<Type, PatchField, GeoMesh>::boundaryField<double, Foam::fvPatchField, Foam::volMesh>()’ (type ‘const Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary’) to type ‘Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary&’
         p_rgh.boundaryField(),
                            ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:17:0,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fixedFluxPressureFvPatchScalarField.H:184:17: note: candidate: template<class GradBC> void Foam::setSnGrad(Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary&, const Foam::tmp<Foam::FieldField<Foam::fvsPatchField, double> >&)
     inline void setSnGrad
                 ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fixedFluxPressureFvPatchScalarField.H:184:17: note:   template argument deduction/substitution failed:
In file included from waveFoam.C:128:0:
pEqn.H:30:28: note:   cannot convert ‘p_rgh.Foam::GeometricField<Type, PatchField, GeoMesh>::boundaryField<double, Foam::fvPatchField, Foam::volMesh>()’ (type ‘const Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary’) to type ‘Foam::GeometricField<double, Foam::fvPatchField, Foam::volMesh>::Boundary&’
         p_rgh.boundaryField(),
                            ^
In file included from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/token.H:46:0,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/UListIO.C:28,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/UList.C:310,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/UList.H:467,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/List.H:43,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/labelList.H:48,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/UPstream.H:42,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/Pstream.H:42,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/parRun.H:35,
                 from /home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude/fvCFD.H:4,
                 from waveFoam.C:40:
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/typeInfo.H: In instantiation of ‘To& Foam::refCast(From&) [with To = Foam::fv::CrankNicolsonDdtScheme<double>; From = const Foam::fv::ddtScheme<double>]’:
alphaEqn.H:35:68:   required from here
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/typeInfo.H:110:35: error: cannot dynamic_cast ‘r’ (of type ‘const class Foam::fv::ddtScheme<double>’) to type ‘class Foam::fv::CrankNicolsonDdtScheme<double>&’ (conversion casts away constness)
         return dynamic_cast<To&>(r);
                                   ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude/typeInfo.H:119:35: error: cannot dynamic_cast ‘r’ (of type ‘const class Foam::fv::ddtScheme<double>’) to type ‘class Foam::fv::CrankNicolsonDdtScheme<double>&’ (conversion casts away constness)
         return dynamic_cast<To&>(r);
                                   ^
/home/shzx/OpenFOAM/OpenFOAM-v1706/wmake/rules/General/transform:28: recipe for target 'Make/linux64GccDPInt64Opt/waveFoam.o' failed
make: *** [Make/linux64GccDPInt64Opt/waveFoam.o] Error 1

=====================================
    COMPILE PRE-PROCESSING
=====================================
wmake faceSetToSTL
make[1]: Entering directory '/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/utilities/preProcessing/faceSetToSTL'
g++ -std=c++11 -m64 -DOPENFOAM_PLUS=1706 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=64 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -O3  -DNoRepository -ftemplate-depth-100 -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/triSurface/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude -DOFVERSION=17060 -DEXTBRANCH=0 -IlnInclude -I. -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OSspecific/POSIX/lnInclude   -fPIC -c faceSetToSTL.C -o Make/linux64GccDPInt64Opt/faceSetToSTL.o
faceSetToSTL.C:62:31: fatal error: faceTriangulation.H: No such file or directory
compilation terminated.
/home/shzx/OpenFOAM/OpenFOAM-v1706/wmake/rules/General/transform:28: recipe for target 'Make/linux64GccDPInt64Opt/faceSetToSTL.o' failed
make[1]: *** [Make/linux64GccDPInt64Opt/faceSetToSTL.o] Error 1
make[1]: Leaving directory '/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/applications/utilities/preProcessing/faceSetToSTL'
/home/shzx/OpenFOAM/OpenFOAM-v1706/wmake/makefiles/apps:39: recipe for target 'faceSetToSTL' failed
make: *** [faceSetToSTL] Error 2

=====================================
    COMPILE POST-PROCESSING
=====================================
g++ -std=c++11 -m64 -DOPENFOAM_PLUS=1706 -Dlinux64 -DWM_ARCH_OPTION=64 -DWM_DP -DWM_LABEL_SIZE=64 -Wall -Wextra -Wold-style-cast -Wnon-virtual-dtor -Wno-unused-parameter -Wno-invalid-offsetof -O3  -DNoRepository -ftemplate-depth-100 -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/meshTools/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/finiteVolume/lnInclude -I/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src/waves2Foam/src/lnInclude -I/home/shzx/OpenFOAM/shzx-v1706/applications/utilities/waves2Foam/src/waves2FoamProcessing/lnInclude -I/usr/include -DOFVERSION=17060 -DEXTBRANCH=0 -IlnInclude -I. -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OpenFOAM/lnInclude -I/home/shzx/OpenFOAM/OpenFOAM-v1706/src/OSspecific/POSIX/lnInclude   -fPIC -Xlinker --add-needed -Xlinker --no-as-needed Make/linux64GccDPInt64Opt/postProcessWaves2Foam.o -L/home/shzx/OpenFOAM/OpenFOAM-v1706/platforms/linux64GccDPInt64Opt/lib \
    -lOpenFOAM -lfiniteVolume -L/home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/lib -lwaves2Foam -lwaves2FoamProcessing -L/usr/lib64 -lgsl -lgslcblas -lOpenFOAM -ldl  \
     -lm -o /home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/bin/postProcessWaves2Foam
/usr/bin/ld: cannot find -lwaves2FoamProcessing
collect2: error: ld returned 1 exit status
/home/shzx/OpenFOAM/OpenFOAM-v1706/wmake/makefiles/general:140: recipe for target '/home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/bin/postProcessWaves2Foam' failed
make: *** [/home/shzx/OpenFOAM/shzx-v1706/platforms/linux64GccDPInt64Opt/bin/postProcessWaves2Foam] Error 1

=====================================
    COMPILE BREEDER
=====================================

Nothing available for compilation in the breeder
directory.


=====================================
    COMPILATION DONE
=====================================

