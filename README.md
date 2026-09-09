<!--
Copyright (c) 2026 Eclipse Foundation
SPDX-License-Identifier: Apache-2.0
-->
# GettingVerilatorStartedWithUVM
This is a somewhat modified version of the source code for "Getting Started with UVM", a textbook by Vanessa Cooper of Verilab.
The sources were fetched from the Verilab webpage at https://www.verilab.com/post/getting-started-with-uvm-book on 2023-08-24.
The goal of this repo is to create a simple, yet complete and realistic, UVM environment and get it compiling and running with Verilator.

> [!NOTE]
> This repo will be updated each time Verilator announces a new release.
> The current cadence of releases is approximately two months.

## You can help!
Check out the Issues and filter on 'Good First Issue',
or try something from 'Future Work' (at the end of this README).

## Current status
1. **Success!**
  - Compiles and executes with Verilator **v5.052** on Ubuntu 24.04.
  - UVM library version is 1800.2-2020.3.2 (see UVM_HOME in `sim/Makefile`).
2. There are **zero** code blocks excluded with conditional compilation (ifdef) macros!
3. Compiles with zero errors (subject to a rather long list of disabled warnings).
4. All tests run to completion and pass with no false positives.
5. The functional coverage code is not yet supported (warnings from previous releases are no longer present).
6. UVM component name constraints warning is gone(!).
6. Successful execution of the `data0_test`:
<details>

```
- V e r i l a t i o n   R e p o r t: Verilator 5.052 2026-09-05 rev v5.052
- Verilator: Built from 19.731 MB sources in 389 modules, into 33.041 MB in 2542 C++ files needing 130.752 MB
- Verilator: Walltime 39.673 s (elab=0.871, cvt=6.841, bld=31.512); cpu 8.559 s on 8 threads; allocated 701.559 MB
UVM Test Name: data0_test.fst
UVM_INFO @ 0: reporter [UVM/RELNOTES] 
  ***********       IMPORTANT RELEASE NOTES         ************

  This implementation of the UVM Library deviates from the 1800.2-2020
  standard.  See the DEVIATIONS.md file contained in the release
  for more details.

----------------------------------------------------------------
Accellera:1800.2:UVM:2020.3.2

All copyright owners for this kit are listed in NOTICE.txt
All Rights Reserved Worldwide
----------------------------------------------------------------

      (Specify +UVM_NO_RELNOTES to turn off this notice)

UVM_WARNING @ 0: reporter [NO_DPI_USED] We are thinking of removing support for UVM_NO_DPI.  Please try this test without it and evaluate the impact
UVM_INFO @ 0: reporter [NO_DPI_TSTNAME] UVM_NO_DPI defined--getting UVM_TESTNAME directly, without DPI
UVM_INFO @ 0: reporter [RNTST] Running test data0_test...
UVM_INFO @ 0: uvm_test_top.env [uvm_test_top.env] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in [uvm_test_top.env.penv_in] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent [uvm_test_top.env.penv_in.agent] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.driver [uvm_test_top.env.penv_in.agent.driver] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] INTERFACE USED = in_intf
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.monitor [uvm_test_top.env.penv_in.agent.monitor] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out [uvm_test_top.env.penv_out] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent [uvm_test_top.env.penv_out.agent] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent.monitor [pipe_monitor] INTERFACE USED = out_intf
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent.monitor [uvm_test_top.env.penv_out.agent.monitor] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.sb [uvm_test_top.env.sb] Build stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent [uvm_test_top.env.penv_in.agent] Connect stage complete.
UVM_INFO @ 0: uvm_test_top.env.penv_out.agent [uvm_test_top.env.penv_out.agent] Connect stage complete.
UVM_INFO @ 0: uvm_test_top.env [uvm_test_top.env] Connect phase complete.
UVM_INFO @ 0: uvm_test_top [data0_test] Printing the test topology :
-----------------------------------------------------------------------
Name                            Type                        Size  Value
-----------------------------------------------------------------------
uvm_test_top                    data0_test                  -     @161 
  env                           dut_env                     -     @231 
    penv_in                     pipe_env                    -     @252 
      agent                     pipe_agent                  -     @297 
        driver                  pipe_driver                 -     @432 
          rsp_port              uvm_analysis_port           -     @449 
          seq_item_port         uvm_seq_item_pull_port      -     @440 
        monitor                 pipe_monitor                -     @458 
          item_collected_port   uvm_analysis_port           -     @480 
        sequencer               pipe_sequencer              -     @309 
          rsp_export            uvm_analysis_export         -     @317 
          seq_item_export       uvm_seq_item_pull_imp       -     @423 
          arbitration_queue     array                       0     -    
          lock_queue            array                       0     -    
          num_last_reqs         integral                    32    'd1  
          num_last_rsps         integral                    32    'd1  
    penv_out                    pipe_env                    -     @260 
      agent                     pipe_agent                  -     @503 
        monitor                 pipe_monitor                -     @516 
          item_collected_port   uvm_analysis_port           -     @533 
    pipe_cov                    pipe_coverage               -     @276 
      analysis_imp              uvm_analysis_imp            -     @284 
    sb                          pipe_scoreboard             -     @268 
      input_packets_collected   uvm_tlm_analysis_fifo #(T)  -     @554 
        analysis_export         uvm_analysis_imp            -     @598 
        get_ap                  uvm_analysis_port           -     @589 
        get_peek_export         uvm_get_peek_imp            -     @571 
        put_ap                  uvm_analysis_port           -     @580 
        put_export              uvm_put_imp                 -     @562 
      output_packets_collected  uvm_tlm_analysis_fifo #(T)  -     @607 
        analysis_export         uvm_analysis_imp            -     @651 
        get_ap                  uvm_analysis_port           -     @642 
        get_peek_export         uvm_get_peek_imp            -     @624 
        put_ap                  uvm_analysis_port           -     @633 
        put_export              uvm_put_imp                 -     @615 
-----------------------------------------------------------------------

UVM_INFO @ 0: reporter [UVM/COMP/NAMECHECK] This implementation of the component name checks requires DPI to be enabled
UVM_WARNING @ 0: reporter [NO_VISIT_CHECK] Because UVM_REGEX_NO_DPI is defined, no uvm component name constraints will be checked
UVM_INFO @ 0: uvm_test_top.env.penv_in.agent.driver [pipe_driver] Resetting signals ... 
UVM_INFO @ 30: uvm_test_top.env.penv_in.agent.sequencer@@seq.req [DP] cf = 1 enable = 1 data_in0 = 0 data_in1 = 7c5f data_out0 = bcf1 data_out1 = cc97 delay = 1
UVM_INFO @ 1545: uvm_test_top.env.pipe_cov [pipe_coverage] Number of coverage packets collected = 2
UVM_INFO @ 1545: uvm_test_top.env.pipe_cov [pipe_coverage] Current coverage  = 0.000000
UVM_INFO @ 1545: uvm_test_top.env.penv_in.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 1
UVM_INFO @ 1545: uvm_test_top.env.penv_out.agent.monitor [pipe_monitor] REPORT: COLLECTED PACKETS = 1
UVM_INFO @ 1545: reporter [UVM/REPORT/SERVER] 
--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :   25
UVM_WARNING :    2
UVM_ERROR :    0
UVM_FATAL :    0
** Report counts by id
[DP]     1
[NO_DPI_TSTNAME]     1
[NO_DPI_USED]     1
[NO_VISIT_CHECK]     1
[RNTST]     1
[UVM/COMP/NAMECHECK]     1
[UVM/RELNOTES]     1
[data0_test]     1
[pipe_coverage]     2
[pipe_driver]     1
[pipe_monitor]     4
[uvm_test_top.env]     2
[uvm_test_top.env.penv_in]     1
[uvm_test_top.env.penv_in.agent]     2
[uvm_test_top.env.penv_in.agent.driver]     1
[uvm_test_top.env.penv_in.agent.monitor]     1
[uvm_test_top.env.penv_out]     1
[uvm_test_top.env.penv_out.agent]     2
[uvm_test_top.env.penv_out.agent.monitor]     1
[uvm_test_top.env.sb]     1

- /opt/accellera/1800.2-2020.3.2/src/base/uvm_test_runner.svh:297: Verilog $finish
- S i m u l a t i o n   R e p o r t: Verilator 5.052 2026-09-05
- Verilator: $finish at 2us; walltime 0.101 s; speed 15.255 us/s
- Verilator: cpu 0.078 s on 1 threads; allocated 46 MB
```
</details>

## Code Coverage!
The Makefile compiles, runs and merges all supported code coverage and produces a result simular to the following:
<details>

```
verilator_coverage --annotate logs/annotated_src logs/coverage/*.cov
Coverage Summary:
  line      : 27.1% ( 2671/ 9865)
  toggle    : 20.3% (   70/  344)
  branch    : 12.6% ( 1766/14024)
  expr      : 10.2% (  347/ 3404)
  fsm_state : 0.0% (    0/    0)
  fsm_arc   : 0.0% (    0/    0)
Annotation Summary:
  lines with all attached points covered :  7.00%  (1276/17757)
See lines with '%00' in logs/annotated_src
verilator_coverage --rank logs/coverage/*.cov > logs/coverage_ranking.txt
```
</details>

## Try it yourself!
1. Install the latest version of Verilator (currently v5.052).  See https://verilator.org/guide/latest/install.html for details.
2. Run it!
```
$ cd sim
$ make all
```

## Run it in a container

The included `Containerfile` builds on the official `verilator/verilator` image
(see https://hub.docker.com/r/verilator/verilator) and layers in the Accellera UVM library.
With this, no local Verilator or UVM install is needed.

> [!NOTE]
> The commands below use `podman`, but `docker` works too with two adjustments: pass
> `-f Containerfile` to `docker build` (docker looks for `Dockerfile` by default),
> and drop `--userns=keep-id` from `docker run` (docker doesn't support that flag).

### Build the image

From the repository root:
```sh
podman build -t verilator-uvm .
```

> [!NOTE]
> The `Containerfile` accepts `VERILATOR_VERSION` and `UVM_VERSION` build args (both
> default to the versions pinned in this repo). To experiment with a different
> combination, override them at build time:
> ```sh
> podman build --build-arg VERILATOR_VERSION=v5.048 --build-arg UVM_VERSION=1800.2-2017-1.0 -t verilator-uvm .
> ```
> Available Verilator release tags mirror the
> [verilator/verilator](https://hub.docker.com/r/verilator/verilator/tags) image on
> Docker Hub (e.g. `v5.048`, `v5.050`). Available UVM versions are those
> published by [Accellera](https://www.accellera.org/downloads/standards/uvm/).

### Get a shell inside the container

```sh
podman run --rm -it --userns=keep-id --user "$(id -u):$(id -g)" -v "$PWD":/work verilator-uvm bash
```

From here, you can run any make command you normally would, but now from inside the container with all the
necessary dependencies preinstalled for you. Generated artifacts (`obj_dir`, `logs`) are written under the
bind-mounted working tree, so they appear on the host just as they would for a native run.

### Run everything (clean, build, run all tests, coverage report)

```sh
podman run --rm --userns=keep-id --user "$(id -u):$(id -g)" -v "$PWD":/work verilator-uvm
```

The image's default command is `make all`, run from `/work/sim`.

### Run a single test

```sh
podman run --rm --userns=keep-id --user "$(id -u):$(id -g)" -v "$PWD":/work verilator-uvm make one UVM_TESTNAME=data0_test
```

## Future Work
1. Remove all the DISABLED WARNINGS in the Makefile.
2. Start pushing (more) advanced randomization of stimulus.
3. Add more tests to close code coverage (and one day, functional coverage too!).
