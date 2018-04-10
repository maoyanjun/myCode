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
    Foam::sixDoFRigidBodyMotionRestraints::HydraulicPTO

Description
    sixDoFRigidBodyMotionRestraints model.  coulomb spring.

SourceFiles
    HydraulicPTO.C

\*---------------------------------------------------------------------------*/

#ifndef HydraulicPTO_H
#define HydraulicPTO_H

#include "sixDoFRigidBodyMotionRestraint.H"
#include "point.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

namespace sixDoFRigidBodyMotionRestraints
{

/*---------------------------------------------------------------------------*\
                          Class HydraulicPTO Declaration
\*---------------------------------------------------------------------------*/

class HydraulicPTO
:
    public sixDoFRigidBodyMotionRestraint
{
    // Private data

        //- Damping coefficient (Ns/m)
        //scalar coeff_;
        
        //Piston
        scalar TopA = 0.0378;               // Top piston area [m^2]
				scalar BotA = 0.0378;               // Bottom piston area [m^2]
				
				//low Pressure Accumulator
				scalar LowAccumuVI0 = 6;            // Initial volume [m^3]
        scalar LowAccumuPIrated = 16e6;                // Rated working pressure
        scalar LowAccumuPIupper_limit = (4/3)*LowAccumuPIrated;     // Upper working pressure
        scalar LowAccumuPIlower_limit = (0.5)*LowAccumuPIupper_limit;  // Lower working pressure
        scalar LowAccumuPIprecharge = 0.9*LowAccumuPIlower_limit;  // Precharge pressure
        scalar LowAccumuVImax = LowAccumuVI0*(1-(LowAccumuPIprecharge/LowAccumuPIupper_limit)^(1/1.4));
        scalar LowAccumuVImin = LowAccumuVI0*(1-(LowAccumuPIprecharge/LowAccumuPIlower_limit)^(1/1.4));
        scalar LowAccumuVIeq = LowAccumuVImax;
        scalar LowAccumuPIeq = LowAccumuPIprecharge/(1-LowAccumuVIeq/LowAccumuVI0)^(1.4);
        
        // High Pressure Accumulator
        scalar HighAccumuVI0 = 8.5;           // Initial volume                          
        scalar HighAccumuDel_p_r = 15e6;                                         
        scalar HighAccumuPIrated = HighAccumuDel_p_r + LowAccumuPIrated;    // Rated working pressure
        scalar HighAccumuPIeq = LowAccumuPIeq;
        scalar HighAccumuPIlower_limit = HighAccumuPIeq;
        scalar HighAccumuPIupper_limit = 1.5*HighAccumuPIlower_limit;
        scalar HighAccumuPIprecharge = 0.9*HighAccumuPIlower_limit;
        scalar HighAccumuVIeq = HighAccumuVI0*(1-(HighAccumuPIprecharge/HighAccumuPIeq)^(1/1.4));
        scalar HighAccumuVImax = HighAccumuVI0*(1-(HighAccumuPIprecharge/HighAccumuPIupper_limit)^(1/1.4));
        scalar HighAccumuVImin = HighAccumuVI0*(1-(HighAccumuPIprecharge/HighAccumuPIlower_limit)^(1/1.4));
        
        //Hydraulic Motor
        scalar MotorangVelInit = 0;     // Initial speed
        scalar MotorJ = 20;        // Total moment of inertia (motor & generator) [kg-m^2]
        scalar MotorFric = 0.05;   // Fricton [kg-m^2/s]

        // Lookup Table Generator
        
        //load motorEff;
        scalar RotaryGeneratorTable = table;
        scalar RotaryGeneratorTgenBase = 2000;
        scalar RotaryGeneratorOmegaBase = 300;
        scalar RotaryGeneratorDriveEff = 0.98;
        scalar RotaryGeneratorDesiredSpeed = 150;  // Angular velocity [rad/s]


public:

    //- Runtime type information
    TypeName("HydraulicPTO");


    // Constructors

        //- Construct from components
        HydraulicPTO
        (
            const word& name,
            const dictionary& sDoFRBMRDict
        );

        //- Construct and return a clone
        virtual autoPtr<sixDoFRigidBodyMotionRestraint> clone() const
        {
            return autoPtr<sixDoFRigidBodyMotionRestraint>
            (
                new HydraulicPTO(*this)
            );
        }


    //- Destructor
    virtual ~HydraulicPTO();


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
//Functions at 


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
