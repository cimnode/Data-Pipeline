# Data-Pipeline

Data pipeline is meant to receive data from any source. Modify the data at a series of nodes. And pass the data to some external source. An open and modular framework for ETL.  

Pipeline nodes directory are monitored by systemd path and service unit files. The included example shows a basic configuration. Any method can be used to place the file in the initial pipeline. Some routines will be provided. 

Place a directory monitored by systemd. Runner the scripts specified on the data, and move to another directory. Can be executed as a pipeline.  See runner.sh for more details on how executables run.

Create the directory structure expected by the routines.
/opt/pipeline  
  - bin/ contains all executables

Numbered directories with pipeline root will be the nodes that data is passed through. Within this directory will be a debug and pipeline directory. While a file is being processed it moves to 'proc' subdirectory. If the routine fails data file moves to debug directory.
  
Example directories:
/opt/pipeline/00001  
/opt/pipeline/00001/debug/  
/opt/pipeline/00001/proc/  



To do:  
- create input methods  
    - HEC (DONE)
    - generic http  
    - csv to http
 
- modification examples  
    - add field to csv  
    - remove value from csv  
    - route to node based on included value  
    - extract a value and route to a node  
 
- external route   
    - email  
    - slack  
    - UF  
    - HEC passthrough  

- documentation
- friendly configuration
