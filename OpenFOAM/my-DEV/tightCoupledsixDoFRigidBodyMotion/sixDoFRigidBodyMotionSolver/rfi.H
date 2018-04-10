#ifndef rfi_H
#define rfi_H
static int icorr=0;
namespace Foam
{
static vector fPrevIter;
static vector mPrevIter;
static vector rfiPre;
static vector rfi(0.0, 1.0, 0);
static scalar frelax1=1.0;
static scalar frelax=1.0;
}
#endif