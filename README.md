# Data-Pipeline

Place a directory monitored by systemd. Runner the scripts specified on the data, and move to another directory. Can be executed as a pipeline.  See runner.sh for more details on how executables run.

Create the directory structure expected by the routines.
/opt/pipeline  
  - bin/ contains all executables

Numbered directories with pipeline root will be the nodes that data is passed through. Within this directory will be a debug and pipeline directory. While a file is being processed it moves to 'proc' subdirectory. If the routine fails data file moves to debug directory.
  
Example directories:
/opt/pipeline/00001  
/opt/pipeline/00001/debug/  
/opt/pipeline/00001/proc/  

