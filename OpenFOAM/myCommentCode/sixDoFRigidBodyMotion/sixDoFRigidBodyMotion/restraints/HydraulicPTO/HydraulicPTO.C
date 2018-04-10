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

#include "HydraulicPTO.H"
#include "addToRunTimeSelectionTable.H"
#include "sixDoFRigidBodyMotion.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
namespace sixDoFRigidBodyMotionRestraints
{
    defineTypeNameAndDebug(HydraulicPTO, 0);

    addToRunTimeSelectionTable
    (
        sixDoFRigidBodyMotionRestraint,
        HydraulicPTO,
        dictionary
    );
}
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::HydraulicPTO
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

Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::~HydraulicPTO()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::restrain
(
    const sixDoFRigidBodyMotion& motion,
    vector& restraintPosition,
    vector& restraintForce,
    vector& restraintMoment
) const
{  
    		//Noncompressible Fluid piston
    if(motion.v().y()*TopA >0)
    scalar volFlow =motion.v().y()*TopA;
    else 
    scalar volFlow =motion.v().y()*BotA;
    
    //Rectigying Valve
    scalar volFlowHigh =abs(volFlow);
    scalar volFlowLow =-abs(volFlow);
    
    scalar highPressure0 =highPressure();
    scalar lowPressure0 =lowPressure();
    scalar angVelPre =angVel();
    scalar volHighPre = volHigh();
    scalar volLowPre = volLow();
    
    scalar delPress = highPressure0-lowPressure0;
    
    if (delPress<=15e6 && delPress>=4e6)
       scalar alphaD = 2.67e-11*delPress-8.52e-5;
    else
        alphaD = 2e-5;
    
    scalar motorVol= alphaD; 
    
    scalar genTorque = 1/(1.05*desireSpeed)*delPress*motorVol*angVel;
    
    scalar angAccel = 1/MotorJ*(alphaD*delPress-genTorque-MotorFric*genTorque);
    
    angVel() =angVelPre+angAccel*deltT;
    
    volFlowMH = -alphaD*angVel;
    volFlowML =  alphaD*angVel;
    
    //High pressure Accumulator
    volHigh() =volHighPre+(volFlowHigh+volFlowMH)*deltT;
    highPressure() = HighAccumuPIprecharge/(pow((1-volHigh/(HighAccumuVI0+VSMALL)),1.4)+VSMALL);
    
    //Low pressure Accumulator
    volLow() =volLowPre+(volFlowLow+volFlowML)*deltT;
    lowPressure() = HighAccumuPIprecharge/(pow((1-volLow/(LowAccumuVI0+VSMALL)),1.4)+VSMALL);
    
    //PTO force
    if (highPressure()*BotA-lowPressure()*TopA>0)
    	PTOforce =-(highPressure()*BotA-lowPressure()*TopA)*sign(vel);
    else 
    	PTOforce =-(highPressure()*TopA-lowPressure()*BotA)*sign(vel);
    	
    restraintForce=vector(0, PTOforce ,0);
    restraintMoment = vector::zero;   
    
   if (motion.report())
    {
        Info<< " force " << restraintForce
            << endl;
    }
}

void Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::forcePTO
(
    const sixDoFRigidBodyMotion& motion,
    vector& restraintPosition,
    vector& restraintForce,
    vector& restraintMoment
) const
{  
	
	
}
bool Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::read
(
    const dictionary& sDoFRBMRDict
)
{
    sixDoFRigidBodyMotionRestraint::read(sDoFRBMRDict);

    sDoFRBMRCoeffs_.lookup("coeff") >> coeff_;

    return true;
}


void Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO::write
(
    Ostream& os
) const
{
    os.writeKeyword("coeff")
        << coeff_ << token::END_STATEMENT << nl;
}


// ************************************************************************* //
