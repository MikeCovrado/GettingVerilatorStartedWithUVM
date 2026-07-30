# Copyright (c) 2026 Yusef Karim
# SPDX-License-Identifier: Apache-2.0

# Verilator release tag (mirrors the version called out in the top-level README).
# Override with --build-arg VERILATOR_VERSION=<tag>, e.g. v5.048.
ARG VERILATOR_VERSION=v5.050
FROM verilator/verilator:${VERILATOR_VERSION}

# Accellera UVM library version. The archive's top-level directory matches this
# string, so extracting into /opt/accellera/ yields
# /opt/accellera/<UVM_VERSION>/src, which UVM_HOME below points at.
ARG UVM_VERSION=1800.2-2017-1.0
ADD https://www.accellera.org/images/downloads/standards/uvm/Accellera-${UVM_VERSION}.tar.gz /tmp/uvm.tar.gz
RUN mkdir -p /opt/accellera \
 && tar xzf /tmp/uvm.tar.gz -C /opt/accellera/ \
 && rm /tmp/uvm.tar.gz
# Exposed so sim/Makefile picks up the path at run time without a command-line override.
ENV UVM_HOME=/opt/accellera/${UVM_VERSION}/src

# Install z3 SAT solver.
# Verilator shells out to z3 when evaluating SVA assertions at runtime.
RUN apt-get update \
 && apt-get install -y --no-install-recommends z3 \
 && rm -rf /var/lib/apt/lists/*

# Copy the project sources in. For day-to-day development, it's better to bind-mount your
# working tree over /work instead (see README) so edits don't require a rebuild.
COPY . /work

ENV HOME=/work
WORKDIR /work/sim

# Clear base image ENTRYPOINT.
ENTRYPOINT []

# `make all` cleans, builds, runs every test, and produces the coverage report.
CMD ["make", "all"]
