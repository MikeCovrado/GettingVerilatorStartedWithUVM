#!/usr/bin/perl -w
# ==============================================================================
# @brief  simple script to analyze test results
# @author Verilab (www.verilab.com)
# ==============================================================================

use strict;           # Follow rigid variable/subroutine declarations
use 5.004;            # Insist on Perl version 5.004 or newer for safety
use File::Basename;   # Compute the containing directory of this script
use Getopt::Long;     # Command-line Options decoder with long options
$| = 1;               # Flush output stream continuously for readability
my $Pgm = $0;

# Usage message - list options, usage and help here

my $Version = "0.1";
my $Usage = <<EOF;

Usage: $Pgm

Purpose:
   analyze a log file or stdout pipe for error messages and other interesting stuff
   replace tee functionality, with flushed output

Options:
   -q(uiet)    - dont pass input lines thru to stdout, just look for errors and return status
   -t(ee) FILE - pass input lines to FILE as well as stdout
   -s(ummary)  - only pass error-like lines to stdout
   -status     - also pass 'status' non-error lines to stdout

EOF

# Options decoding - define globals and call GetOptions here

use vars qw($ShowHelp $ShowVersion $Verbose $OptQuiet $OptTee $OptSummary $OptStatus);

GetOptions ( 'help|h'         => \$ShowHelp
            ,'verbose|v'      => \$Verbose
            ,'version'        => \$ShowVersion
            ,'quiet|q'        => \$OptQuiet
            ,'tee|t=s'        => \$OptTee
            ,'summary|s'      => \$OptSummary
            ,'status'         => \$OptStatus
            ) or die "$Pgm: $Usage";
if ($ShowHelp) { print STDERR $Usage; exit 0; }
if ($ShowVersion) { print STDERR "$Pgm version $Version\n"; exit 0; }

# Check for illegal option combinations

# Do Stuff

sub is_abort_message($) {
    my $line = $_[0];
    return 1 if ($line =~ /(Fatal:|Failure:)/io);
    return 1 if ($line =~ /UVM_FATAL \@/o);
    return 1 if ($line =~ /\*F,/o);
    return 1 if ($line =~ /Failure to license for systemc/o);
    return 1 if ($line =~ /Failure to obtain a Verilog simulation license/o);
    return 1 if ($line =~ /(segmentation fault|bad pointer|core dump|bus error)/io);
    return 1 if ($line =~ /(no such file|no space left|i\/o error)/io);
    return 1 if ($line =~ /input\/output error/io);
    return 1 if ($line =~ /(nc.*: \*E,SIGUSR)/o);
    return 1 if ($line =~ /ncsim: double free or corruption/o);
    return 0;
}

sub is_timeout_message($) {
    my $line = $_[0];
    return 1 if ($line =~ /WAIT_FOR_END_TIMEOUT/o);
    return 1 if ($line =~ /WATCHDOG TIMEOUT/o);
    return 1 if ($line =~ /Watchdog timeout/o);
    return 0;
}

sub is_fail_message($) {
    my $line = $_[0];
    return 1 if ($line =~ /(FAILED:)/io);
    return 1 if ($line =~ /(UVM_ERROR \@)/o);
    return 1 if ($line =~ /UVM_WARNING \@/o);
    return 1 if ($line =~ /(ASRTST|Assertion failed)/o);
    return 1 if ($line =~ /(\*E,)/o);
    return 1 if ($line =~ /(Error\!)/o);
    return 0;
}

sub is_warning_message($) {
    my $line = $_[0];
    return 1 if ($line =~ /(Warn:|Warning:)/io);
    return 0;
}

sub is_status_message($) {
    my $line = $_[0];
    return 1 if ($line =~ /(found|compiling|compiler|sccom |linking|running|elaborating)/io);
    return 0;
}


if ($OptTee) {
    open(TEEFILE,">>$OptTee") or die "Can't create/append tee file $OptTee\n";
}

# exit codes:
# 0 = no errors or fails found
# 1 = timeout messages found which indicate a likely hang
# 2 = soft fail messages found, which indicate the status of the test run
# 3 = errors found which may mean the run was invalid

my $found_fails=0;
my $found_aborts=0;
my $found_timeouts=0;

while (<>) {
    my $abort       = is_abort_message($_);
    my $timeout     = is_timeout_message($_);
    my $fail        = is_fail_message($_);
    my $status      = ($OptStatus) ? (is_status_message($_)) : 0;
    my $interesting = ($OptSummary) ? ($fail | $timeout | $abort | $status) : 1;
    $found_fails += $fail;
    $found_timeouts += $timeout;
    $found_aborts += $abort;
    if ($OptTee) { print TEEFILE $_; }
    if ($interesting & (! $OptQuiet)) { print "    ".$_; }
}

if ($OptTee) {
    close TEEFILE or die "Can't close tee file $OptTee\n";
}

if ($Verbose) {
    print "$Pgm: done processing lines\n";
    print "$Pgm: - found $found_aborts abort messages and $found_fails fail messages\n";
}

exit( ($found_aborts) ? 3 : ($found_timeouts) ? 1 : ($found_fails) ? 2 : 0 );

# End
