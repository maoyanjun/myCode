// Filename: myFirstMatlabPipe.H //

#ifndef myFirstMatlabPipe_H
#define myFirstMatlabPipe_H

#include "engine.h"

using namespace std;

class myFirstMatlabPipe
{
	// Type definition //

	// Private data objects //
	Engine *eMatlabPtr;

	// Number of calltimes //
	int ii;

public:
	// Constructor //
	myFirstMatlabPipe();

	// Destructor //
	virtual ~myFirstMatlabPipe();

	// Send and return a double array to a matlab script //
	virtual double matlabCallScript(const char* matlabFilename,double inputArg) const;
	
	// Close the pipe to MATLAB //
	virtual void close() const;
};

#endif