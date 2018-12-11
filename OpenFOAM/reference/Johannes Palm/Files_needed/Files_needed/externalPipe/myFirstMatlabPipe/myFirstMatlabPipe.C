// Filename: myFirstMatlabPipe.C //

#include<iostream>
#include<cmath>
#include "engine.h"
#include "myFirstMatlabPipe.H"
//
using namespace std;
// Constructor //
myFirstMatlabPipe::myFirstMatlabPipe()
{
 	cout << "Matlab engine pointer initialized" << endl;
	// Create matlab engine pointer //
	eMatlabPtr=engOpen(NULL);
	// Create a matlab call no. iterator ii //
	engEvalString(eMatlabPtr,"ii=0;");
}
// Destructor //
myFirstMatlabPipe::~myFirstMatlabPipe()
{};

double myFirstMatlabPipe::matlabCallScript(const char* matlabFilename,double inputArg) const
{
	// Increase iterator value //
	engEvalString(eMatlabPtr,"ii=ii+1;");

	// Create scalar mxArray object compatible with MATLAB and C++ //
 	mxArray *inMxArray = mxCreateDoubleMatrix(1,1,mxREAL);	
 	double *inPtr = mxGetPr(inMxArray);

	// Send value of inMxArray to MATLAB // 
	inPtr[0] = inputArg;
 	engPutVariable(eMatlabPtr,"inputFromCpp",inMxArray);
	
	// Execute MATLAB script // 
 	engEvalString(eMatlabPtr,matlabFilename);

	// Extract value to C++ and return // 
	mxArray *outMxArray = engGetVariable(eMatlabPtr,"outputToCpp");
	double *outPtr = mxGetPr(outMxArray);
	
	
	return outPtr[0];
};

void myFirstMatlabPipe::close() const
{
	engClose(eMatlabPtr);
};
