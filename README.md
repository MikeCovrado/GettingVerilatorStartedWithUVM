# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
Sources fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator. 

## Current status
0. Last tested with Verilator v5.018 on Ubuntu 22.04.
1. Not yet compiling (working on it).
2. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
```
`ifdef VERILATOR
  // code that is not supported by Verilator...
`else
  // temporary work-around
`endif
```

## Try it yourself!
First, install the latest version of Verilator.  See https://verilator.org/guide/latest/install.html for details.

Second, create a shell environment variable `UVM_HOME` and clone the version of the UVM library from ChipsAlliance there. 
```
$ export UVM_HOME="/location/of/UVM/lib"
$ git clone git@github.com:chipsalliance/uvm-verilator.git $UVM_HOME
```

The (somewhat brain-dead) script will get you started:
```
$ cd scripts
$ ./run_verilator.sh testname
```
