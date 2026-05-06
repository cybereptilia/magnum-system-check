#!/usr/bin/perl
# This script displays a web form that lets the user enter
# a month and year, then it runs the Linux cal command.

use strict;
use warnings;
use CGI;
use POSIX qw(strftime);

# We first create CGI object to read form input
my $cgi = CGI->new;

print "Content-type: text/html\n\n";

my $current_month = strftime("%m", localtime);
my $current_year = strftime("%Y", localtime);
my $today_day = strftime("%d", localtime);

my $month = $cgi->param("month") || $current_month;
my $year = $cgi->param("year") || $current_year;

print "<html>";
print "<head>";
print "<title>System Calendar</title>";
print "<link rel='stylesheet' type='text/css' href='/styles.css'>";
print "</head>";
print "<body>";

print "<div class='container'>";
print "<h1>System Calendar</h1>";
print "<p>Today's date is: $current_month/$today_day/$current_year</p>";


# Form
print "<form method='POST' action='/cgi-bin/calendar.pl'>";
print "<label>Month:</label>";
print "<input type='number' name='month' min'1' max='12' value='$month' required>";

print "<label>Year:</label>";
print "<input type='number' name='year' min'1900' max='2100' value='$year' required>";

print "<input type='submit' value='View Calendar'>";
print "</form>";

print "<h2>Calendar for $month/$year</h2>";

# VALIDATION
if ($month =~ /^[0-9]+$/ && $year=~ /^[0-9]+$/ && $month >= 1 && $month <= 12) {
	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
	my @month_days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

	if (($year % 4 == 0 && $year % 100 != 0) || ($year % 400 == 0)) {
		$month_days[1] = 29;
	}

	my $first_day = `date -d "$year-$month-01" +%w`;
	chomp($first_day);

	my $days_in_month = $month_days[$month - 1];

	print "<table>";
	print "<tr>";

	foreach my $day (@days) {
		print "<th>$day</th>";
	}

	print "</tr><tr>";

	for (my $blank = 0; $blank < $first_day; $blank++) {
		print "<td></td>";
	}

	for (my $day = 1; $day <= $days_in_month; $day++) {
		my $class = "";

		if ($month == $current_month && $year == $current_year && $day == $today_day) {
			$class = "class='today'";
		}

		print "<td $class>$day</td>";

		if (($day + $first_day) % 7 == 0) {
			print "</tr><tr>";
		}
	}

	print "</tr>";
	print "</table>";
} else {
	print "<p>Invalid month or year.</p>";
}
print "<br>";
print "<a class='button' href='/index.php'>Return Main Menu</a>";
print "</div></body></html>";
