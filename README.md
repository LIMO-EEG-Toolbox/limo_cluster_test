As of Aug 14, this contains some functions to test the runtime speed of 
the LIMO clustering functions.

In particular, we have profiling code which calls limo_display_results, 
specifying existing data.

The Matlab profiler is scripted to run, and properties from the profiler 
are saved while clustering is done.

Info for each run is saved in bmark.mat.

Andrew Stewart, Aug 2014
