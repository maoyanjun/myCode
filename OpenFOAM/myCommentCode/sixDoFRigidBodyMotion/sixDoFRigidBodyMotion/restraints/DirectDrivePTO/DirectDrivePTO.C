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

#include "DirectDrivePTO.H"
#include "addToRunTimeSelectionTable.H"
#include "sixDoFRigidBodyMotion.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
namespace sixDoFRigidBodyMotionRestraints
{
    defineTypeNameAndDebug(DirectDrivePTO, 0);

    addToRunTimeSelectionTable
    (
        sixDoFRigidBodyMotionRestraint,
        DirectDrivePTO,
        dictionary
    );
}
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO::DirectDrivePTO
(
    const word& name,
    const dictionary& sDoFRBMRDict
)
:
    sixDoFRigidBodyMotionRestraint(name, sDoFRBMRDict),
    R_g(), 
    V_g(),
    R_c(), 
    V_c(),
    R_load(),
    V_load(),
    
    anchor_(),
    refAttachmentPt_(),
    topStrokeLength_(),
    topSpringK_(),
    topSpringLength_(),
    bottomStrokeLength_(),
    bottomSpringK_(),
    bottomSpringLength_(),    
    topSpringFullyCompressedLength_(),
    bottomSpringFullyCompressedLength_()

    
{
    read(sDoFRBMRDict);
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO::~DirectDrivePTO()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO::restrain
(
    const sixDoFRigidBodyMotion& motion,
    vector& restraintPosition,
    vector& restraintForce,
    vector& restraintMoment
) const
{ 
    vector i = refAttachmentPt_-anchor_;
    scalar magI = mag(i);
    restraintPosition = motion.transform(refAttachmentPt_);
    vector r = restraintPosition - anchor_;
    scalar magR = mag(r);
    r /=(magR+VSMALL);
    //
    scalar a = pos(magR-magI-topStrokeLength_+topSpringLength_);
    scalar b = pos(magR-magI-topStrokeLength_+topSpringFullyCompressedLength_);
    scalar c = neg(magR-magI+bottomStrokeLength_-bottomSpringLength_);
		scalar d = neg(magR-magI+bottomStrokeLength_-bottomSpringFullyCompressedLength_);

    scalar coeff_=3*(1/R_g*sqr((V_g/(motion.v().y()+VSMALL)))+1/R_c*sqr((V_c/(motion.v().y()+VSMALL)))+3/R_load*sqr((V_load/(motion.v().y()+VSMALL))));
    restraintForce = -coeff_*motion.v()-(a*topSpringK_*(magR-magI-topStrokeLength_+topSpringLength_)+b*100*topSpringK_*(magR-magI-topStrokeLength_+topSpringFullyCompressedLength_)+c*bottomSpringK_*(magR-magI+bottomStrokeLength_-bottomSpringLength_)+d*100*bottomSpringK_*(magR-magI+bottomStrokeLength_-bottomSpringFullyCompressedLength_))*r;
    restraintMoment = vector::zero;   
    
   if (motion.report())
    {
        Info<< " force " << restraintForce
        		<< "coeff" << coeff_
        		<<" attachmentPt - anchor " << r*magR
            << endl;
    }
}


bool Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO::read
(
    const dictionary& sDoFRBMRDict
)
{
    sixDoFRigidBodyMotionRestraint::read(sDoFRBMRDict);
    	
    sDoFRBMRCoeffs_.lookup("R_g") >> R_g;
    sDoFRBMRCoeffs_.lookup("V_g") >> V_g;
    sDoFRBMRCoeffs_.lookup("R_c") >> R_c;
    sDoFRBMRCoeffs_.lookup("V_c") >> V_c;
    sDoFRBMRCoeffs_.lookup("R_load") >> R_load;
    sDoFRBMRCoeffs_.lookup("V_load") >> V_load;
    //读入ending system 的相关系数
    sDoFRBMRCoeffs_.lookup("anchor") >> anchor_;
    sDoFRBMRCoeffs_.lookup("refAttachmentPt") >> refAttachmentPt_;
    sDoFRBMRCoeffs_.lookup("topStrokeLength") >> topStrokeLength_;
    sDoFRBMRCoeffs_.lookup("topSpringK") >> topSpringK_;
    sDoFRBMRCoeffs_.lookup("topSpringLength") >> topSpringLength_;
    sDoFRBMRCoeffs_.lookup("bottomStrokeLength") >> bottomStrokeLength_;
    sDoFRBMRCoeffs_.lookup("bottomSpringK") >> bottomSpringK_;
    sDoFRBMRCoeffs_.lookup("bottomSpringLength") >> bottomSpringLength_;
    sDoFRBMRCoeffs_.lookup("topSpringFullyCompressedLength") >> topSpringFullyCompressedLength_;
    sDoFRBMRCoeffs_.lookup("bottomSpringFullyCompressedLength") >> bottomSpringFullyCompressedLength_;


    return true;
}


void Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO::write
(
    Ostream& os
) const
{
    os.writeKeyword("R_g")         <<R_g << token::END_STATEMENT << nl;

    os.writeKeyword("V_g")         <<V_g << token::END_STATEMENT << nl;

    os.writeKeyword("R_c")         <<R_c << token::END_STATEMENT << nl;

    os.writeKeyword("V_c")         <<V_c << token::END_STATEMENT << nl;

    os.writeKeyword("R_load")         <<R_load<< token::END_STATEMENT << nl;

    os.writeKeyword("V_load")         <<V_load << token::END_STATEMENT << nl;
    	
    	
    os.writeKeyword("anchor")         <<anchor_<< token::END_STATEMENT << nl;
    	
    os.writeKeyword("refAttachmentPt")         <<refAttachmentPt_ << token::END_STATEMENT << nl;

    os.writeKeyword("topStrokeLength")         <<topStrokeLength_ << token::END_STATEMENT << nl;
    	
    os.writeKeyword("topSpringK")         <<topSpringK_ << token::END_STATEMENT << nl;
    	
    os.writeKeyword("topSpringLength")         <<topSpringLength_ << token::END_STATEMENT << nl;
    	
    os.writeKeyword("bottomStrokeLength")         <<bottomStrokeLength_ << token::END_STATEMENT << nl;
    	
    os.writeKeyword("bottomSpringK")         <<bottomSpringK_ << token::END_STATEMENT << nl;
    	    	
    os.writeKeyword("bottomSpringLength")         <<bottomSpringLength_ << token::END_STATEMENT << nl;
    	    	
    os.writeKeyword("topSpringFullyCompressedLength")         <<topSpringFullyCompressedLength_ << token::END_STATEMENT << nl;
    	
    os.writeKeyword("bottomSpringFullyCompressedLength")         <<bottomSpringFullyCompressedLength_ << token::END_STATEMENT << nl;
    	
}


// ************************************************************************* //
