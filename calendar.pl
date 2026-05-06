#!/usr/bin/perl
# Shebang line: tells the system to use Perl to execute this script

# This script displays a web form that lets the user enter
# a month and year, then generates a calendar for that input.

use strict;     
use warnings;    # Shows warnings for potential issues
use CGI;         # Module for handling CGI (web form input/output)
use POSIX qw(strftime);  # Provides date/time formatting functions

# Create a new CGI object to handle incoming form data
my $cgi = CGI->new;

# Print HTTP header to indicate HTML content
print "Content-type: text/html\n\n";

# Get the current month, year, and day from the system
my $current_month = strftime("%m", localtime);  # Month (01–12)
my $current_year  = strftime("%Y", localtime);  # Full year (e.g., 2026)
my $today_day     = strftime("%d", localtime);  # Day of the month (01–31)

# Get user input from the form; if not provided, use current date values
my $month = $cgi->param("month") || $current_month;
my $year  = $cgi->param("year")  || $current_year;

# Begin HTML output
print "<html>";
print "<head>";
print "<title>System Calendar</title>";
# Link external CSS file for styling
print "<link rel='stylesheet' type='text/css' href='/styles.css'>";
print "</head>";
print "<body>";

print "<div class='container'>";
print "<h1>System Calendar</h1>";

# Display today's date
print "<p>Today's date is: $current_month/$today_day/$current_year</p>";

# -------------------------
# Form for user input
# -------------------------
print "<form method='POST' action='/cgi-bin/calendar.pl'>";

# Month input field
print "<label>Month:</label>";

print "<input type='number' name='month' min'1' max='12' value='$month' required>";

# Year input field
print "<label>Year:</label>";
print "<input type='number' name='year' min'1900' max='2100' value='$year' required>";

# Submit button
print "<input type='submit' value='View Calendar'>";
print "</form>";

# Display selected calendar heading
print "<h2>Calendar for $month/$year</h2>";

# -------------------------
# Input validation
# -------------------------
# Ensure month and year are numeric and month is within valid range
if ($month =~ /^[0-9]+$/ && $year =~ /^[0-9]+$/ && $month >= 1 && $month <= 12) {

    # Array of day names (week headers)
    my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");

    # Number of days in each month (default, February = 28)
    my @month_days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

    # Leap year check:
    # If leap year, February has 29 days
    if (($year % 4 == 0 && $year % 100 != 0) || ($year % 400 == 0)) {
        $month_days[1] = 29;
    }

    # Get the day of the week for the 1st of the month (0=Sunday, 6=Saturday)
    # Uses system 'date' command
    my $first_day = `date -d "$year-$month-01" +%w`;
    chomp($first_day);  # Remove newline from command output

    # Get total number of days in selected month
    my $days_in_month = $month_days[$month - 1];

    # -------------------------
    # Generate calendar table
    # -------------------------
    print "<table>";
    print "<tr>";

    # Print table headers (Sun–Sat)
    foreach my $day (@days) {
        print "<th>$day</th>";
    }

    print "</tr><tr>";

    # Print blank cells before the first day of the month
    for (my $blank = 0; $blank < $first_day; $blank++) {
        print "<td></td>";
    }

    # Loop through each day of the month
    for (my $day = 1; $day <= $days_in_month; $day++) {

        # CSS class for highlighting today's date
        my $class = "";

        # If current loop date matches today's real date, highlight it
        if ($month == $current_month && $year == $current_year && $day == $today_day) {
            $class = "class='today'";
        }

        # Print the day cell
        print "<td $class>$day</td>";

        # If end of the week (Saturday), start a new row
        if (($day + $first_day) % 7 == 0) {
            print "</tr><tr>";
        }
    }

    print "</tr>";
    print "</table>";

} else {
    # If validation fails, show error message
    print "<p>Invalid month or year.</p>";
}

# Add spacing and a return button
print "<br>";
print "<a class='button' href='/index.php'>Return Main Menu</a>";

# Close HTML tags
print "</div></body></html>";
