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
/*************************************/


//Noncompressible Fluid piston
if(vel*TopA >0)
	volFlow =vel*TopA;
else 
	volFlow =vel*BotA;

//Rectigying Valve
volFlowHigh =abs(volFlow);
volFlowLow =-abs(volFlow);


delPress = highPressure()-lowPressure();

if delPress<=15e6 && delPress>=4e6
    alphaD = 2.67e-11*delPress-8.52e-5;
else
    alphaD = 2e-5;
end

motorVol= alphaD; 

genTorque = 1/(1.05*desireSpeed)*delPress*motorVol*angVel;

angAccel = 1/MotorJ*(alphaD*delPress-genTorque-MotorFric*genTorque);

angVel =angVelPre+angAccel*deltT;

volFlowMH = -alphaD*angVel;
volFlowML =  alphaD*angVel;

//High pressure Accumulator
volHigh =volHighPre+(volFlowHigh+volFlowMH);
highPressure() = HighAccumuPIprecharge/(pow((1-volHigh/(HighAccumuVI0+VSMALL)),1.4)+VSMALL);

//Low pressure Accumulator
volLow =volLowPre+(volFlowLow+volFlowML);
lowPressure() = HighAccumuPIprecharge/(pow((1-volLow/(LowAccumuVI0+VSMALL)),1.4)+VSMALL);

//PTO force
if (highPressure()*BotA-lowPressure()*TopA>0)
	PTOforce =-(highPressure()*BotA-lowPressure()*TopA)*sign(vel);
else 
	PTOforce =-(highPressure()*TopA-lowPressure()*BotA)*sign(vel);


