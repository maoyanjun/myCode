This is a shell script to merge separated force coefficient data genearted by OpenFOAM. 

OpenFOAM separates the force coefficient data when the simulations restart. If you have many time folders in your `postProcessing/forceCoeffs` folder, this script will perhaps save your time.


## Usage:

This is the file structure before you execute this script:
```
forces
├── 0
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── 136.17
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── 45
│   ├── forceCoeffs_bins.dat
│   ├── #forceCoeffs.dat#
│   └── forceCoeffs.dat
├── 90
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
└── mergeData
```

Then, type `sh ./mergeData` in the forces folder. Two merged data will be genearted.

```
forces
├── 0
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── 136.17
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── 45
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── 90
│   ├── forceCoeffs_bins.dat
│   └── forceCoeffs.dat
├── forceCoeffs_bins.dat.merged
├── forceCoeffs.dat.merged
└── mergeData
```
