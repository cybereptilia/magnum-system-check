#!/usr/bin/perl
# Shebang line: tells the system to execute this script using Perl

use strict;     # Enforce variable declaration and safer coding practices
use warnings;   # Enable warnings for potential issues

# Print HTTP header so the browser knows the response is HTML
print "Content-type: text/html\n\n";

# -------------------------
# Start HTML structure
# -------------------------
print "<html><head>";

# Page title
print "<title>Processes</title>";

# Link external CSS file for styling
print "<link rel='stylesheet' type='text/css' href='/styles.css'>";

# NOTE: Minor bug here — missing closing ">" in </head>
print "</head";

print "<body>";

# Container for styling/layout
print "<div class='container'>";

# Page heading
print "<h1>Current Processes</h1>";

# Wrapper div for table styling
print "<div class='table-box'>";

# -------------------------
# Table headers
# -------------------------
print "<table>";
print "<tr>";

# Column headers corresponding to `ps -ef` output
print "<th>UID</th>";    # User ID
print "<th>PID</th>";    # Process ID
print "<th>PPID</th>";   # Parent Process ID
print "<th>C</th>";      # CPU utilization
print "<th>STIME</th>";  # Start time
print "<th>TTY</th>";    # Terminal
print "<th>TIME</th>";   # CPU time used
print "<th>CMD</th>";    # Command that started the process

print "</tr>";

# -------------------------
# Get process list
# -------------------------
# Execute system command:
# - ps -ef: list all processes in full format
# - head -n 25: limit output to first 25 lines
my @lines = `ps -ef | head -n 25`;

# Remove the first line (header row from ps output)
shift @lines;

# -------------------------
# Process each line
# -------------------------
foreach my $line (@lines) {

    # Split line into columns (max 8 parts to preserve full command)
    my @parts = split(/\s+/, $line, 8);

    # Assign each column to a variable
    my ($uid, $pid, $ppid, $c, $stime, $tty, $time, $cmd) = @parts;

    # Print table row
    print "<tr>";
    print "<td>$uid</td>";
    print "<td>$pid</td>";
    print "<td>$ppid</td>";
    print "<td>$c</td>";
    print "<td>$stime</td>";
    print "<td>$tty</td>";
    print "<td>$time</td>";
    print "<td>$cmd</td>";
    print "</tr>";
}

# -------------------------
# Close table and layout
# -------------------------
print "</table>";  
print "</div>";    # Close table-box

# Navigation button back to main menu
print '<a class="button" href="/index.php">Return Main Menu</a>';

# Close container and HTML
print "</div>";
print "</body>";
print "</html>";
