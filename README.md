# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
Sources fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## Current status
0. Last tested with Verilator v5.032 on Ubuntu 22.04.
1. Compiles with zero errors (subject to a rather long list of disabled warnings).
2. Execution abort at t=0:
```
- V e r i l a t i o n   R e p o r t: Verilator 5.032 2025-01-01 rev v5.032
- Verilator: Built from 19.865 MB sources in 355 modules, into 31.144 MB in 5344 C++ files needing 15.500 MB
- Verilator: Walltime 2427.444 s (elab=0.710, cvt=5.992, bld=2418.529); cpu 8.042 s on 1 threads; alloced 227.215 MB
UVM_INFO @ 0: reporter [UVM/RELNOTES] 
  ***********       IMPORTANT RELEASE NOTES         ************

  This implementation of the UVM Library deviates from the 1800.2-2017
  standard.  See the DEVIATIONS.md file contained in the release
  for more details.

----------------------------------------------------------------
Accellera:1800.2-2017:UVM:1.0

All copyright owners for this kit are listed in NOTICE.txt
All Rights Reserved Worldwide
----------------------------------------------------------------

      (Specify +UVM_NO_RELNOTES to turn off this notice)

UVM_INFO @ 0: reporter [NO_DPI_TSTNAME] UVM_NO_DPI defined--getting UVM_TESTNAME directly, without DPI
UVM_INFO @ 0: reporter [RNTST] Running test data0_test...
%Error: ../rtl/../tb/top.sv:20: Input combinational region did not converge.
Aborting...
./run_verilator.sh: line 133: 994147 Aborted                 (core dumped) ./verilator_obj_dir/Vuvm_pkg +UVM_TESTNAME="$OPT_TESTNAME"
```
3. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
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
$ git clone git@github.com:antmicro/uvm-verilator.git -b current-patches $UVM_HOME
```

The (somewhat brain-dead) script will get you started:
```
$ cd scripts
$ ./run_verilator.sh data0_test
```
