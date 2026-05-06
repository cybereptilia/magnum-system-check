#!/usr/bin/perl

print "Content-type: text/html\n\n";

print "<html>";
print "<head>";
print "<title>Connected Users</title>";
print "<link rel='stylesheet' href='/styles.css'>";
print "</head>";
print "<body>";

print "<div class='container'>";
print "<h1>Users Connected to the System</h1>";
print "<p>This page displays users currently connected to the Linux system.</p>";
print "<pre>";

my @users = `who`;
print "<table>";
print "<tr><th>User</th><th>Terminal</th><th>Login Time</th></tr>";

foreach my $line (@users) {
	my @parts = split(/\s+/, $line);
	my $user = $parts[0];
	my $tty = $parts[1];
	my $time = "$parts[2] $parts[3]";

	print "<tr>";
	print "<td>$user</td>";
	print "<td>$tty</td>";
	print "<td>$time</td>";
	print "</tr>";
}
print "</table>";

print "</pre>";
print '<a class="button" href="/index.php">Return Main Menu</a>';
print "</div>";

print "</body>";
print "</html>";
