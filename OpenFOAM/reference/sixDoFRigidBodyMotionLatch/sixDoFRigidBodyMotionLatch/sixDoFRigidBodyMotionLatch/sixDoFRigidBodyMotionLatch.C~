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

\*---------------------------------------------------------------------------*/

#include "sixDoFRigidBodyMotionLatch.H"
#include "septernion.H"

#include <iostream>
#include <fstream>

// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotion::applyRestraints()
{
    if (restraints_.empty())
    {
        return;

    }

    if (Pstream::master())
    {
        forAll(restraints_, rI)
        {
            if (report_)
            {
                Info<< "Restraint " << restraints_[rI].name() << ": ";
            }

            // restraint position
            point rP = vector::zero;

            // restraint force
            vector rF = vector::zero;

            // restraint moment
            vector rM = vector::zero;

            restraints_[rI].restrain(*this, rP, rF, rM);

            a() += rF/mass_;

            // Moments are returned in global axes, transforming to
            // body local to add to torque.
            tau() += Q().T() & (rM + ((rP - centreOfMass()) ^ rF));
        }
    }
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotion::sixDoFRigidBodyMotion()
:
    motionState_(),
    motionState0_(),
    restraints_(),
    constraints_(),
    tConstraints_(tensor::I),
    rConstraints_(tensor::I),
    initialCentreOfMass_(vector::zero),
    initialQ_(I),
    momentOfInertia_(diagTensor::one*VSMALL),
    mass_(VSMALL),
    aRelax_(1.0),
    aDamp_(1.0),
    report_(false)
{}


Foam::sixDoFRigidBodyMotion::sixDoFRigidBodyMotion
(
    const point& centreOfMass,
    const tensor& Q,
    const vector& v,
    const vector& a,
    const vector& pi,
    const vector& tau,
    scalar mass,
    const point& initialCentreOfMass,
    const tensor& initialQ,
    const diagTensor& momentOfInertia,
    scalar aRelax,
    scalar aDamp,
    bool report
)
:
    motionState_
    (
        centreOfMass,
        Q,
        v,
        a,
        pi,
        tau
    ),
    motionState0_(motionState_),
    restraints_(),
    constraints_(),
    tConstraints_(tensor::I),
    rConstraints_(tensor::I),
    initialCentreOfMass_(initialCentreOfMass),
    initialQ_(initialQ),
    momentOfInertia_(momentOfInertia),
    mass_(mass),
    aRelax_(aRelax),
    aDamp_(aDamp),
    report_(report)
{}


Foam::sixDoFRigidBodyMotion::sixDoFRigidBodyMotion
(
    const dictionary& dict,
    const dictionary& stateDict
)
:
    motionState_(stateDict),
    motionState0_(motionState_),
    restraints_(),
    constraints_(),
    tConstraints_(tensor::I),
    rConstraints_(tensor::I),
    initialCentreOfMass_
    (
        dict.lookupOrDefault
        (
            "initialCentreOfMass",
            vector(dict.lookup("centreOfMass"))
        )
    ),
    initialQ_
    (
        dict.lookupOrDefault
        (
            "initialOrientation",
            dict.lookupOrDefault("orientation", tensor::I)
        )
    ),
    momentOfInertia_(dict.lookup("momentOfInertia")),
    mass_(readScalar(dict.lookup("mass"))),
    aRelax_(dict.lookupOrDefault<scalar>("accelerationRelaxation", 1.0)),
    aDamp_(dict.lookupOrDefault<scalar>("accelerationDamping", 1.0)),
    report_(dict.lookupOrDefault<Switch>("report", false))

{
    addRestraints(dict);
    addConstraints(dict);
    addLatch(dict);
}


Foam::sixDoFRigidBodyMotion::sixDoFRigidBodyMotion
(
    const sixDoFRigidBodyMotion& sDoFRBM
)
:
    motionState_(sDoFRBM.motionState_),
    motionState0_(sDoFRBM.motionState0_),
    restraints_(sDoFRBM.restraints_),
    constraints_(sDoFRBM.constraints_),
    initialCentreOfMass_(sDoFRBM.initialCentreOfMass_),
    initialQ_(sDoFRBM.initialQ_),
    momentOfInertia_(sDoFRBM.momentOfInertia_),
    mass_(sDoFRBM.mass_),
    aRelax_(sDoFRBM.aRelax_),
    aDamp_(sDoFRBM.aDamp_),
    report_(sDoFRBM.report_)
{}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::sixDoFRigidBodyMotion::~sixDoFRigidBodyMotion()
{}


// * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * * //

void Foam::sixDoFRigidBodyMotion::addRestraints
(
    const dictionary& dict
)
{
    if (dict.found("restraints"))
    {
        const dictionary& restraintDict = dict.subDict("restraints");

        label i = 0;

        restraints_.setSize(restraintDict.size());

        forAllConstIter(IDLList<entry>, restraintDict, iter)
        {
            if (iter().isDict())
            {
                restraints_.set
                (
                    i++,
                    sixDoFRigidBodyMotionRestraint::New
                    (
                        iter().keyword(),
                        iter().dict()
                    )
                );
            }
        }

        restraints_.setSize(i);
    }
}


void Foam::sixDoFRigidBodyMotion::addConstraints
(
    const dictionary& dict
)
{
    if (dict.found("constraints"))
    {
        const dictionary& constraintDict = dict.subDict("constraints");

        label i = 0;

        constraints_.setSize(constraintDict.size());

        pointConstraint pct;
        pointConstraint pcr;

        forAllConstIter(IDLList<entry>, constraintDict, iter)
        {
            if (iter().isDict())
            {
                constraints_.set
                (
                    i,
                    sixDoFRigidBodyMotionConstraint::New
                    (
                        iter().keyword(),
                        iter().dict()
                    )
                );

                constraints_[i].constrainTranslation(pct);
                constraints_[i].constrainRotation(pcr);

                i++;
            }
        }

        constraints_.setSize(i);

        tConstraints_ = pct.constraintTransformation();
        rConstraints_ = pcr.constraintTransformation();



        Info<< "Translational constraint tensor " << tConstraints_ << nl
            << "Rotational constraint tensor " << rConstraints_ << endl;




Info<<nl<<"Creating timeTxt"<<nl<<endl;

    }
}



void Foam::sixDoFRigidBodyMotion::addLatch
(
    const dictionary& dict
)
{

    if (dict.found("latch"))
    {
        const dictionary& latchDict = dict.subDict("latch");

//read and define general parameters
	typeLatch_ = latchDict.lookupOrDefault<string>("typeLatch", "constant");
	timeLatch_ = latchDict.lookupOrDefault<scalar>("timeLatch", -1);
	if (typeLatch_ == "constant")
	{
		if (timeLatch_ <= 0)
		{
			timeStartLatch_ = 1e4;
		}
	}
	timeStartLatch_ = latchDict.lookupOrDefault<scalar>("timeStartLatch", 0);

	nOuterCorrectors_ = latchDict.lookupOrDefault<scalar>("nOuterCorrectors", 1);
	if (nOuterCorrectors_==1)
	{
		Info<<"Number of PIMPLE iteration is set to 1 by default. Check if it is the actual value in system/fvSolution"<<endl;
	}
	timeEscape_ = 10*timeLatch_;

//initialize supporting variables

	timeFinish_ = 0;
	timeSim_ = 0;
	latching_ = 0;
	startIndex_ = 0;
	vPrevious_ = v0()[2];


//define the Degree of Freedom to latch

	dofLatch_ = latchDict.lookupOrDefault<string>("DoF", "heave"); //choose between surge(x), sway(y), heave(z)
	Info<<"Latching Degree of Freedom: "<<dofLatch_<<endl;
	if (dofLatch_ == "heave")
	{
		dof_=8;
	}else if(dofLatch_ == "surge")
	{
		dof_=0;
	}else if(dofLatch_ == "sway")
	{
		dof_=4;
	}


//define adaptive latching parameters

	if (typeLatch_ == "adaptive")
	{
		tToll_ = latchDict.lookupOrDefault<scalar>("tToll", 0.01); //percentage
		aToll_ = latchDict.lookupOrDefault<scalar>("aToll", 0.01); //percentage
		waveT_ = latchDict.lookupOrDefault<scalar>("waveT", 1e4); //wave period
		dTimeLatch_ = latchDict.lookupOrDefault<scalar>("dTimeLatch", 0.005);   //percentage of waveT_
		dTimeLatch_ = -dTimeLatch_*waveT_;  // negative because first step backwards	
		amplitudePre_ = 0;
		amplitudeStable_ = 0;
		timePeakPre_ = 0;
		numOfPeriods_ = latchDict.lookupOrDefault<scalar>("initialAdditionalNumOfPeriods", 5);
		minNumOfPeriods_ = latchDict.lookupOrDefault<scalar>("minNumOfPeriods", 7);
		numOfPeriods_ = -numOfPeriods_;
		if (waveT_ == 1e4)
		{
			Info<<nl<<"INFORMATION ABOUT WAVE PERIOD IS MISSING!!!!!"<<nl<<endl;
		}
		Info<<"Period tollerance: "<<tToll_<<nl;
		Info<<"Amplitude tollerance: "<<aToll_<<nl;
		Info<<"Delta latching time: "<<dTimeLatch_<<endl;
	}

//define alternative latching parameters

	if (typeLatch_ == "alternative")
	{
		timeLatchPositive_ = latchDict.lookupOrDefault<scalar>("timeLatchPositive", timeLatch_);
		timeLatchNegative_ = latchDict.lookupOrDefault<scalar>("timeLatchNegative", timeLatch_);
		timeEscape_ = 10*timeLatchPositive_;
	}

//printing latching parameters

	Info<<nl<<"Latching parameters: "<<nl<<nl;

	if (typeLatch_ != "alternative")
	{
	Info<<"Time of latch: "<<timeLatch_<<nl;
	}else
	{
	Info<<"Positive time of latch: "<<timeLatchPositive_<<nl;
	Info<<"Negative time of latch: "<<timeLatchNegative_<<nl;
	}
	Info<<"Starting time without latching: "<<timeStartLatch_<<nl;
	Info<<"Number of PIMPLE ITERATION: "<<nOuterCorrectors_<<nl;
	Info<<"Latching type: "<<typeLatch_<<nl<< endl;
	
    }
    else
    {
	timeStartLatch_ = 1e4; //hence practically it will never start
    }
	

}





void Foam::sixDoFRigidBodyMotion::updatePosition
(
    scalar deltaT,
    scalar deltaT0
)
{
    // First leapfrog velocity adjust and motion part, required before
    // force calculation


    if (Pstream::master())
    {

//calculation of the simulation time

	timeSim_ += deltaT0/nOuterCorrectors_;
	Info<<nl<<"Simulation time: "<<timeSim_<<nl<<nl;

	if (timeSim_ >= timeStartLatch_) //do I start latching?
	{
	    Info<<"vPrevious_ : "<<vPrevious_<<endl;
	    Info<<"v0()[2] : "<<v0()[2]<<endl;

	    if (v0()[2]*vPrevious_ <= 0)  //positive or negative peak or latched plateau
	    {	       
//adaptive algorithm 
//Hyp: function amplitude-latchingTime is concave with only a maximum at a latching time smaller than the linear one
		if (typeLatch_ == "adaptive")
		{
			if ( startIndex_ == 1  &&   centreOfMass()[2] > 0)  //starting of a positive peak
			{
				if ( timeSim_ > timePeakPre_ + waveT_/2 )
				{
					numOfPeriods_ += 1;
					Info<<"Positive peak number"<< numOfPeriods_<<" with lathing time "<< timeLatch_ <<" s: "<<centreOfMass()[2]<<endl;
					Info<<"Period: "<<timeSim_ - timePeakPre_<<endl;

					if (fabs(timeSim_ - timePeakPre_ - waveT_)/waveT_ <= tToll_)  //response period is stabilized to the exciting wave period
					{
						if ( (fabs(centreOfMass()[2] - amplitudePre_)/amplitudePre_ <= aToll_) && numOfPeriods_ > minNumOfPeriods_)//the amplitude is stabilized as well
						{

							if (centreOfMass()[2] < amplitudeStable_)  //there was not an improvement
							{ 
								dTimeLatch_ = -dTimeLatch_/2; //since there wasn't an improvement, it means that I passed over the maxima, hence I change direction and refine the research
							
							}
							timeLatch_ += dTimeLatch_;
							Info<<"New time Latch: "<<timeLatch_<<endl;
							amplitudeStable_ = centreOfMass()[2];
							Info<<"New stable amplitude: "<<amplitudeStable_<<endl;
							numOfPeriods_ = 0;
						}					
					}
					timePeakPre_ = timeSim_;
					amplitudePre_ = centreOfMass()[2];
				}
			}
		}

//latching algorithm

		if (typeLatch_ == "alternative")
		{
			if (centreOfMass()[2] >= 0)
			{
				timeLatch_=timeLatchPositive_;
			}else
			{
				timeLatch_=timeLatchNegative_;
			}
		}


		if (latching_ == 0) 
		{
		    tConstraints_[dof_] = 0;
		    startIndex_ = 1;
		    Info<<nl<<"Start to latch"<<nl<<endl;
		    
		    latching_ = 1;
		    timeFinish_ = timeSim_ + timeLatch_;

		}
		else 
		{
			if (timeSim_ < timeFinish_)
			{
			    tConstraints_[dof_]=0;
		    	    startIndex_ = 0;
			    Info<<nl<<"Continue to latch"<<nl<<endl;
			}
			else if (timeSim_ >= timeFinish_ && timeSim_ < timeFinish_+timeEscape_)
			{	
				tConstraints_[dof_]=1;
				    Info<<nl<<"Escaping from latching"<<nl<<endl;
			}

		}
	    }
	    else
	    {
		latching_ = 0;
	    }
	}

	vPrevious_ = v0()[2];

        v() = tConstraints_ & aDamp_*(v0() + 0.5*deltaT0*a());
        pi() = rConstraints_ & aDamp_*(pi0() + 0.5*deltaT0*tau());

        // Leapfrog move part
        centreOfMass() = centreOfMass0() + deltaT*v();

        // Leapfrog orientation adjustment
        Tuple2<tensor, vector> Qpi = rotate(Q0(), pi(), deltaT);
        Q() = Qpi.first();
        pi() = rConstraints_ & Qpi.second();
    }

    Pstream::scatter(motionState_);


}


void Foam::sixDoFRigidBodyMotion::updateAcceleration
(
    const vector& fGlobal,
    const vector& tauGlobal,
    scalar deltaT
)
{
    static bool first = false;

    // Second leapfrog velocity adjust part, required after motion and
    // acceleration calculation

    if (Pstream::master())
    {
        // Save the previous iteration accelerations for relaxation
        vector aPrevIter = a();
        vector tauPrevIter = tau();

        // Calculate new accelerations
        a() = fGlobal/mass_;
        tau() = (Q().T() & tauGlobal);
        applyRestraints();

        // Relax accelerations on all but first iteration
        if (!first)
        {
            a() = aRelax_*a() + (1 - aRelax_)*aPrevIter;
            tau() = aRelax_*tau() + (1 - aRelax_)*tauPrevIter;
        }
        first = false;

        // Correct velocities
        v() += tConstraints_ & aDamp_*0.5*deltaT*a();
        pi() += rConstraints_ & aDamp_*0.5*deltaT*tau();



        if (report_)
        {
            status();
        }
    }

    Pstream::scatter(motionState_);
}


void Foam::sixDoFRigidBodyMotion::updateVelocity(scalar deltaT)
{
    // Second leapfrog velocity adjust part, required after motion and
    // acceleration calculation

    if (Pstream::master())
    {
        v() += tConstraints_ & aDamp_*0.5*deltaT*a();
        pi() += rConstraints_ & aDamp_*0.5*deltaT*tau();



        if (report_)
        {
            status();
        }
    }

    Pstream::scatter(motionState_);
}


void Foam::sixDoFRigidBodyMotion::updateAcceleration
(
    const pointField& positions,
    const vectorField& forces,
    scalar deltaT
)
{
    vector fGlobal = vector::zero;

    vector tauGlobal = vector::zero;

    if (Pstream::master())
    {
        fGlobal = sum(forces);

        forAll(positions, i)
        {
            tauGlobal += (positions[i] - centreOfMass()) ^ forces[i];
        }
    }

    updateAcceleration(fGlobal, tauGlobal, deltaT);
}


Foam::point Foam::sixDoFRigidBodyMotion::predictedPosition
(
    const point& pInitial,
    const vector& deltaForce,
    const vector& deltaMoment,
    scalar deltaT
) const
{
    vector vTemp = v() + deltaT*(a() + deltaForce/mass_);
    vector piTemp = pi() + deltaT*(tau() + (Q().T() & deltaMoment));
    point centreOfMassTemp = centreOfMass0() + deltaT*vTemp;
    Tuple2<tensor, vector> QpiTemp = rotate(Q0(), piTemp, deltaT);

    return
    (
        centreOfMassTemp
      + (QpiTemp.first() & initialQ_.T() & (pInitial - initialCentreOfMass_))
    );
}


Foam::vector Foam::sixDoFRigidBodyMotion::predictedOrientation
(
    const vector& vInitial,
    const vector& deltaMoment,
    scalar deltaT
) const
{
    vector piTemp = pi() + deltaT*(tau() + (Q().T() & deltaMoment));
    Tuple2<tensor, vector> QpiTemp = rotate(Q0(), piTemp, deltaT);

    vector o(QpiTemp.first() & initialQ_.T() & vInitial);
    o /= mag(o);

    return o;
}


void Foam::sixDoFRigidBodyMotion::status() const
{


    Info<< "Centre of mass: " << centreOfMass() << nl
        << "Linear velocity: " << v() << nl
        << "Angular velocity: " << omega()
        << endl;


}


Foam::tmp<Foam::pointField> Foam::sixDoFRigidBodyMotion::currentPosition
(
    const pointField& initialPoints
) const
{
    return
    (
        centreOfMass()
      + (Q() & initialQ_.T() & (initialPoints - initialCentreOfMass_))
    );
}


Foam::tmp<Foam::pointField> Foam::sixDoFRigidBodyMotion::scaledPosition
(
    const pointField& initialPoints,
    const scalarField& scale
) const
{
    // Calculate the transformation septerion from the initial state
    septernion s
    (
        centreOfMass() - initialCentreOfMass(),
        quaternion(Q() & initialQ().T())
    );

    tmp<pointField> tpoints(new pointField(initialPoints));
    pointField& points = tpoints();

    forAll(points, pointi)
    {
        // Move non-stationary points
        if (scale[pointi] > SMALL)
        {
            // Use solid-body motion where scale = 1
            if (scale[pointi] > 1 - SMALL)
            {
                points[pointi] = currentPosition(initialPoints[pointi]);
            }
            // Slerp septernion interpolation
            else
            {
                septernion ss(slerp(septernion::I, s, scale[pointi]));

                points[pointi] =
                    initialCentreOfMass()
                  + ss.transform(initialPoints[pointi] - initialCentreOfMass());
            }
        }
    }

    return tpoints;
}


bool Foam::sixDoFRigidBodyMotion::read(const dictionary& dict)
{
    dict.lookup("momentOfInertia") >> momentOfInertia_;
    dict.lookup("mass") >> mass_;
    aRelax_ = dict.lookupOrDefault<scalar>("accelerationRelaxation", 1.0);
    aDamp_ = dict.lookupOrDefault<scalar>("accelerationDamping", 1.0);
    report_ = dict.lookupOrDefault<Switch>("report", false);

    restraints_.clear();
    addRestraints(dict);

    constraints_.clear();
    addConstraints(dict);

    addLatch(dict);

    return true;
}


// ************************************************************************* //
