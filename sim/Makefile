# Copyright (c) 2026 Eclipse Foundation
# SPDX-License-Identifier:Apache-2.0

# Variables
BANNER     = "*******************************************************************************"
VERILATOR  = verilator
COV_TOOL   = verilator_coverage
TOP_MODULE = uvm_pkg
SV_SOURCES = ../sv/pipe_pkg.sv \
             ../sv/pipe_if.sv \
             ../rtl/pipe.v \
             ../tb/top.sv

# UVM variables
# Accelera's UVM library fetched with `wget https://www.accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz`
UVM_HOME       = /opt/accellera/1800.2-2017-1.0/src
UVM_PKG        = $(UVM_HOME)/uvm_pkg.sv
UVM_TESTNAME  ?= data0_test
ALL_TESTNAMES ?= data0_test data1_test random_test many_random_test

# Output Directories
OBJ_DIR  = obj_dir
LOG_DIR  = logs
CMP_LOG  = $(LOG_DIR)/verilator_compile.log
COV_DIR  = $(LOG_DIR)/coverage
COV_FILE = $(COV_DIR)/$(UVM_TESTNAME).cov

# Verilator Flags
# --coverage means all of --coverage-line, --coverage-toggle, and --coverage-user
VERILATOR_FLAGS = --binary \
                  --build \
                  --cc \
                  --Mdir $(OBJ_DIR) \
                  --error-limit 5 \
                  --hierarchical \
                  --coverage \
                  -j 4 \
                  -Wall \
                  --timescale 1ns/1ns

# Deliberately disabled warnings (all from the UVM class library)
# TODO: eliminate these one-by-one.
DISABLED_WARNINGS= -Wno-DECLFILENAME \
                   -Wno-CONSTRAINTIGN \
                   -Wno-MISINDENT \
                   -Wno-VARHIDDEN \
                   -Wno-WIDTHTRUNC \
                   -Wno-CASTCONST \
                   -Wno-WIDTHEXPAND \
                   -Wno-UNDRIVEN \
                   -Wno-UNUSEDSIGNAL \
                   -Wno-UNUSEDPARAM \
                   -Wno-SYMRSVDWORD \
                   -Wno-ZERODLY \
                   -Wno-CASEINCOMPLETE \
                   -Wno-SIDEEFFECT \
                   -Wno-fatal \
                   -Wno-REALCVT

INCDIRS = +incdir+"$(UVM_HOME)" \
          +incdir+../rtl \
          +incdir+../sv \
          +incdir+../tb

DEFINES = +define+UVM_REPORT_DISABLE_FILE_LINE \
          +define+UVM_NO_DPI \
          +define+SVA_ON

# --- Targets ---

.PHONY: all clean run report epilog

targets:
	@echo "Available targets..."
	@echo "  $(OBJ_DIR)/V$(TOP_MODULE): compile and build"
	@echo "  run: run UVM test $(UVM_TESTNAME) (depends on $(OBJ_DIR)/V$(TOP_MODULE))."
	@echo "  cov_report: generate a coverage report (depends on run)."
	@echo "  epilog: print location of objs, logs and coverage files (no dependents)."
	@echo "  clean: delete all generated files."
	@echo "  one: clean, run_data0, cov_report and epilog (in that order)."
	@echo "  all: clean, run_all, cov_report and epilog (in that order)."

one: clean $(OBJ_DIR)/V$(TOP_MODULE) run_data0 cov_report epilog
all: clean $(OBJ_DIR)/V$(TOP_MODULE) run_all cov_report epilog

# Compile and Build
$(OBJ_DIR)/V$(TOP_MODULE): $(SV_SOURCES)
	@echo $(BANNER)
	@echo "Compiling..."
	@echo $(BANNER)
	@mkdir -p $(LOG_DIR)
	$(VERILATOR) $(VERILATOR_FLAGS) $(DISABLED_WARNINGS) $(DEFINES) $(INCDIRS) $(UVM_PKG) $(SV_SOURCES) 2>&1 | tee $(CMP_LOG)

# Run one simulation
run: $(OBJ_DIR)/V$(TOP_MODULE)
	@echo $(BANNER)
	@echo "Running $(UVM_TESTNAME)..."
	@echo $(BANNER)
	@mkdir -p $(COV_DIR)
	./$(OBJ_DIR)/V$(TOP_MODULE) \
		+UVM_TESTNAME="$(UVM_TESTNAME)" \
		+verilator+coverage+file+$(COV_DIR)/$(UVM_TESTNAME) \
		2>&1 | tee $(LOG_DIR)/$(UVM_TESTNAME).log

## Run all testcases
run_all: $(OBJ_DIR)/V$(TOP_MODULE)
	@echo $(BANNER)
	@echo "Running _all_ testcases..."
	@echo $(BANNER)
	@mkdir -p $(COV_DIR)
	@for testname in $(ALL_TESTNAMES); do \
		echo "Creating $$testname..."; \
		./$(OBJ_DIR)/V$(TOP_MODULE) \
			+UVM_TESTNAME="$$testname" \
			+verilator+coverage+file+$(COV_DIR)/$$testname.cov \
			2>&1 | tee $(LOG_DIR)/$$testname.log; \
	done

# Generate Coverage Report
# Annotate creates a copy of the source code with coverage markers
# This feature is not yet fully supported by Verilator.
cov_report: run
	@echo $(BANNER)
	@echo "Generating coverage report..."
	@echo $(BANNER)
	$(COV_TOOL) --annotate $(LOG_DIR)/annotated_src $(COV_DIR)/*.cov
	$(COV_TOOL) --rank $(COV_DIR)/*.cov > $(LOG_DIR)/coverage_ranking.txt

epilog:
	@echo $(BANNER)
	@echo "Compilation logfiles in $(CMP_LOG)"
	@echo "Simulation logfiles in $(LOG_DIR)/<UVM_TESTNAME>.log"
	@echo "Annotated coverage reports in $(LOG_DIR)/annotated_src"
	@echo "Coverage ranking report in $(LOG_DIR)/coverage_ranking.txt"
	@echo $(BANNER)

clean:
	@echo $(BANNER)
	@echo "Delete _all_ generated files..."
	@echo $(BANNER)
	rm -rf $(OBJ_DIR) $(LOG_DIR)
