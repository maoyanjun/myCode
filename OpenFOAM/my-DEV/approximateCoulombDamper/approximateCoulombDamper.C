/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2013-2015 OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "approximateCoulombDamper.H"
#include "addToRunTimeSelectionTable.H"
#include "sixDoFRigidBodyMotion.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
namespace sixDoFRigidBodyMotionRestraints
{
    defineTypeNameAndDebug(approximateCoulombDamper, 0);

    addToRunTimeSelectionTable
    (
        sixDoFRigidBodyMotionRestraint,
        approximateCoulombDamper,
        dictionary
    );
}
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::approximateCoulombDamper::approximateCoulombDamper
(
    const word& name,
    const dictionary& sDoFRBMRDict
)
:
    sixDoFRigidBodyMotionRestraint(name, sDoFRBMRDict),
    coeff_()
{
    read(sDoFRBMRDict);
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::approximateCoulombDamper::~approximateCoulombDamper()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotionRestraints::approximateCoulombDamper::restrain
(
    const sixDoFRigidBodyMotion& motion,
    vector& restraintPosition,
    vector& restraintForce,
    vector& restraintMoment
) const
{  /* if(mag(motion.v().y())<0.005)
    {
     scalar coeff2=coeff_/0.005;
     scalar mao1=-coeff2*motion.v().y()*sign(motion.v().y());
     restraintForce=vector(0, mao1 ,0);
     restraintMoment = vector::zero;
    }
   else
    {
    scalar mao=-coeff_*sign( motion.v().y());
    restraintForce=vector(0, mao ,0);
    restraintMoment = vector::zero;
    }*/
    scalar Gpto=2000000;
    if(Gpto*mag(motion.v().z())>coeff_)
    {
    scalar mao=-coeff_*sign( motion.v().z());
    restraintForce=vector(0, 0,mao);
    restraintMoment = vector::zero;   
  }
  else 
  {
  	scalar mao=-Gpto*mag(motion.v().z())*sign( motion.v().z());
  	restraintForce=vector(0, 0, mao);
    restraintMoment = vector::zero;   
  }
   if (motion.report())
    {
        Info<< " force " << restraintForce
            << endl;
    }
}


bool Foam::sixDoFRigidBodyMotionRestraints::approximateCoulombDamper::read
(
    const dictionary& sDoFRBMRDict
)
{
    sixDoFRigidBodyMotionRestraint::read(sDoFRBMRDict);

    sDoFRBMRCoeffs_.lookup("coeff") >> coeff_;

    return true;
}


void Foam::sixDoFRigidBodyMotionRestraints::approximateCoulombDamper::write
(
    Ostream& os
) const
{
    os.writeKeyword("coeff")
        << coeff_ << token::END_STATEMENT << nl;
}


// ************************************************************************* //
