#!/usr/bin/perl
use strict;
use warnings;

print "Content-type: text/html\n\n";

print "<html><head>";
print "<title>Processes</title>";

print "<link rel='stylesheet' type='text/css' href='/styles.css'>";

print "</head";
print "<body>";

print "<div class='container'>";

print "<h1>Current Processes</h1>";

print "<div class='table-box'>";

print "<table>";
print "<tr>";
print "<th>UID</th>";
print "<th>PID</th>";
print "<th>PPID</th>";
print "<th>C</th>";
print "<th>STIME</th>";
print "<th>TTY</th>";
print "<th>TIME</th>";
print "<th>CMD</th>";
print "</tr>";

my @lines = `ps -ef | head -n 25`;
shift @lines;

foreach my $line (@lines) {
    my @parts = split(/\s+/, $line, 8);
    my ($uid, $pid, $ppid, $c, $stime, $tty, $time, $cmd) = @parts;

print "<tr>";
print "<td>$uid</td>";
print"<td>$pid</td>";
print "<td>$ppid</td>";
print "<td>$c</td>";
print "<td>$stime</td>";
print "<td>$tty</td>";
print "<td>$time</td>";
print "<td>$cmd</td>";
print "</tr>";
}

print "</table>";  
print "</div>";    

print '<a class="button" href="/index.php">Return Main Menu</a>';

print "</div>";
print "</body>";
print "</html>";
