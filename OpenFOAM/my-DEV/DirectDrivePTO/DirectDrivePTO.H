/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | Copyright (C) 2011-2013 OpenFOAM Foundation
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

Class
    Foam::sixDoFRigidBodyMotionRestraints::DirectDrivePTO

Description
    sixDoFRigidBodyMotionRestraints model.  coulomb spring.

SourceFiles
    DirectDrivePTO.C

\*---------------------------------------------------------------------------*/

#ifndef DirectDrivePTO_H
#define DirectDrivePTO_H

#include "sixDoFRigidBodyMotionRestraint.H"
#include "point.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

namespace sixDoFRigidBodyMotionRestraints
{

/*---------------------------------------------------------------------------*\
                          Class DirectDrivePTO Declaration
\*---------------------------------------------------------------------------*/

class DirectDrivePTO
:
    public sixDoFRigidBodyMotionRestraint
{
    // Private data

        //- Damping coefficient (Ns/m)
        //scalar coeff_;
        scalar R_g;
        scalar V_g;
        scalar R_c;
        scalar V_c;
        scalar R_load;
        scalar V_load;
      
       //- Anchor point, where the spring is attached to an immovable
        // object
        point anchor_;
        //- Reference point of attachment to the solid body
        point refAttachmentPt_;
        //- Gap between translator and top of PTO when at rest (m)
        scalar topStrokeLength_;
        //- Top spring stiffness coefficient (N/m)
        scalar topSpringK_;
        //- Rest length of top spring - when no forces are applied to it (m)
        scalar topSpringLength_;
        //- Gap between translator and base of PTO when at rest (m)
        scalar bottomStrokeLength_;
        //- Bottom spring stiffness coefficient (N/m)
        scalar bottomSpringK_;
        //- Rest length of bottom spring - when no forces are applied to it (m)
        scalar bottomSpringLength_;
        //- Fully compressed length of the top spring (m)
        scalar topSpringFullyCompressedLength_;
        //- Fully compressed length of the bottom spring (m)
        scalar bottomSpringFullyCompressedLength_;


public:

    //- Runtime type information
    TypeName("DirectDrivePTO");


    // Constructors

        //- Construct from components
        DirectDrivePTO
        (
            const word& name,
            const dictionary& sDoFRBMRDict
        );

        //- Construct and return a clone
        virtual autoPtr<sixDoFRigidBodyMotionRestraint> clone() const
        {
            return autoPtr<sixDoFRigidBodyMotionRestraint>
            (
                new DirectDrivePTO(*this)
            );
        }


    //- Destructor
    virtual ~DirectDrivePTO();


    // Member Functions

        //- Calculate the restraint position, force and moment.
        //  Global reference frame vectors.
        virtual void restrain
        (
            const sixDoFRigidBodyMotion& motion,
            vector& restraintPosition,
            vector& restraintForce,
            vector& restraintMoment
        ) const;

        //- Update properties from given dictionary
        virtual bool read(const dictionary& sDoFRBMRCoeff);

        //- Write
        virtual void write(Ostream&) const;
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace solidBodyMotionFunctions
} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
