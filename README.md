# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
Sources fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## Current status
0. Last tested with Verilator v5.036 on Ubuntu 22.04.
1. Anything that is known to be not currently supported by Verilator is excluded with conditional compilation macros:
```
`ifdef VERILATOR
  // code that is not supported by Verilator...
`else
  // temporary work-around
`endif
```
2. Compiles with zero errors (subject to a rather long list of disabled warnings).
3. Execution abort at t=0:
```
- V e r i l a t i o n   R e p o r t: Verilator 5.036 2025-04-27 rev v5.036
- Verilator: Built from 20.774 MB sources in 355 modules, into 33.194 MB in 5344 C++ files needing 15.796 MB
- Verilator: Walltime 241.063 s (elab=0.489, cvt=5.038, bld=234.453); cpu 6.610 s on 1 threads; alloced 257.508 MB
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
./run_verilator.sh: line 134: 81355 Aborted                 (core dumped) ./verilator_obj_dir/Vuvm_pkg +UVM_TESTNAME="$OPT_TESTNAME"
```
The above run-time error is believed to be related to [Verilator Issue #5116](https://github.com/verilator/verilator/issues/5116)

## Try it yourself!
Install the latest version of Verilator.  See https://verilator.org/guide/latest/install.html for details.

Create a shell environment variable `ANTMICRO` to point to where you would like you clone of the UVM library to be:
```
$ git clone --recursive git@github.com:antmicro/verilator-verification-features-tests.git $ANTMICRO/main
```

Edit the (somewhat brain-dead) run-script to point a shell environment variable `UVM_HOME` to point to the above:
```
$ vim scripts/run_verilator.sh
>>> export UVM_HOME="$ANTMICRO/main/uvm/uvm-2017/src"
```

Run it!
```
$ cd scripts
$ ./run_verilator.sh data0_test
```
