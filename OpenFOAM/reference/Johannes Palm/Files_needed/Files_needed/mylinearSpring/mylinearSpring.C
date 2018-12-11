/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2010-2011 OpenCFD Ltd.
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

#include "mylinearSpring.H"
#include "addToRunTimeSelectionTable.H"
#include "sixDoFRigidBodyMotion.H"
#include "myFirstMatlabPipe.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
namespace sixDoFRigidBodyMotionRestraints
{
    defineTypeNameAndDebug(mylinearSpring, 0);

    addToRunTimeSelectionTable
    (
        sixDoFRigidBodyMotionRestraint,
        mylinearSpring,
        dictionary
    );
}
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::mylinearSpring::mylinearSpring
(
    const dictionary& sDoFRBMRDict
)
:
    sixDoFRigidBodyMotionRestraint(sDoFRBMRDict),
    anchor_(),
    refAttachmentPt_(),
    stiffness_(),
    damping_(),
    restLength_()
{
    read(sDoFRBMRDict);
}
    

// * * * * * * * * * * * * * * * * Destructors * * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::mylinearSpring::~mylinearSpring()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotionRestraints::mylinearSpring::restrain
(
    const sixDoFRigidBodyMotion& motion,
    vector& restraintPosition,
    vector& restraintForce,
    vector& restraintMoment
) const
{
    restraintPosition = motion.currentPosition(refAttachmentPt_);
  
    vector r = restraintPosition - anchor_;
    
    scalar magR = mag(r);

    // r is now the r unit vector
    r /= (magR + VSMALL);

    vector v = motion.currentVelocity(restraintPosition);
    double extension = magR-restLength_;
	
// This impies that mooringScript.m is available in the case directory 
// and that the matlab variables inputFromCpp and outputToCpp are used within it.
	const char *mScriptFilename = "mooringScript;";
    double effExtension=mlObj.matlabCallScript(mScriptFilename,extension); 
    restraintForce = -stiffness_*effExtension*r - damping_*(r & v)*r;

    restraintMoment = vector::zero;
    if (motion.report())
    {
        Info<< " attachmentPt - anchor " << r*magR
            << " spring length " << magR
            << " force " << restraintForce
            << " moment " << restraintMoment
            << endl;
		const char *mScriptFilename = "saveInfoScript;"; // implying saveInfoScript.m
		// Extract the heave position and send it to MATLAB for storage//	
		vector printCoM = motion.centreOfMass();
    	mlObj.matlabCallScript(mScriptFilename,printCoM[2]);
    }

}

bool Foam::sixDoFRigidBodyMotionRestraints::mylinearSpring::read
(
    const dictionary& sDoFRBMRDict
)
{
    sixDoFRigidBodyMotionRestraint::read(sDoFRBMRDict);

    sDoFRBMRCoeffs_.lookup("anchor") >> anchor_;

    sDoFRBMRCoeffs_.lookup("refAttachmentPt") >> refAttachmentPt_;

    sDoFRBMRCoeffs_.lookup("stiffness") >> stiffness_;

    sDoFRBMRCoeffs_.lookup("damping") >> damping_;

    sDoFRBMRCoeffs_.lookup("restLength") >> restLength_;

    return true;
}


void Foam::sixDoFRigidBodyMotionRestraints::mylinearSpring::write
(
    Ostream& os
) const
{
    os.writeKeyword("anchor")
        << anchor_ << token::END_STATEMENT << nl;

    os.writeKeyword("refAttachmentPt")
        << refAttachmentPt_ << token::END_STATEMENT << nl;

    os.writeKeyword("stiffness")
        << stiffness_ << token::END_STATEMENT << nl;

    os.writeKeyword("damping")
        << damping_ << token::END_STATEMENT << nl;

    os.writeKeyword("restLength")
        << restLength_ << token::END_STATEMENT << nl;
}

// ************************************************************************* //
