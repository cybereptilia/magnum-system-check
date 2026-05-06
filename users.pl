#!/usr/bin/perl
# Shebang line: tells the system to execute this script using Perl

# Print HTTP header so the browser knows this is HTML content
print "Content-type: text/html\n\n";

# -------------------------
# Start HTML structure
# -------------------------
print "<html>";
print "<head>";

# Page title
print "<title>Connected Users</title>";

# Link external CSS file for styling
print "<link rel='stylesheet' href='/styles.css'>";

print "</head>";
print "<body>";

# Main container for layout/styling
print "<div class='container'>";

# Page heading and description
print "<h1>Users Connected to the System</h1>";
print "<p>This page displays users currently connected to the Linux system.</p>";


print "<pre>";

# -------------------------
# Get list of logged-in users
# -------------------------
# Execute the 'who' command to list currently logged-in users
my @users = `who`;

# Start table
print "<table>";

# Table headers
print "<tr><th>User</th><th>Terminal</th><th>Login Time</th></tr>";

# -------------------------
# Process each line of output
# -------------------------
foreach my $line (@users) {

    # Split line into parts using whitespace
    my @parts = split(/\s+/, $line);

    # Extract relevant fields
    my $user = $parts[0];              # Username
    my $tty  = $parts[1];              # Terminal (e.g., pts/0)
    my $time = "$parts[2] $parts[3]";  # Login date and time

    # Output table row
    print "<tr>";
    print "<td>$user</td>";
    print "<td>$tty</td>";
    print "<td>$time</td>";
    print "</tr>";
}

# Close table
print "</table>";

# Close preformatted block
print "</pre>";

# Navigation button back to main menu
print '<a class="button" href="/index.php">Return Main Menu</a>';

# Close container and HTML
print "</div>";
print "</body>";
print "</html>";
