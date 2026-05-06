<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$option = $_POST["option"];

	if ($option == "process") {
		header("Location: /cgi-bin/processes.pl");
		exit;
	} elseif ($option == "calendar") {
		header("Location: /cgi-bin/calendar.pl");
		exit;
	} elseif ($option == "location") {
		header("Location: /cgi-bin/location.py");
		exit;
	} elseif ($option == "users") {
		header("Location: /cgi-bin/users.pl");
		exit;
	} elseif ($option == "find") {
		header("Location: /cgi-bin/find_file.py");
		exit;
	}
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Magnum System Check</title>
<link rel="stylesheet" href="/styles.css">
</head>
<body>

<div class="container">
<h1>Welcome to Magnum System Check</h1>

<form method="POST" action="index.php">

<div class="menu-options">

<label class="option">
<input type="radio" name="option" value="process" required>
View my process
</label>


<label class="option">
<input type="radio" name="option" value="calendar">
View the calendar
</label>

<label class="option">
<input type="radio" name="option" value="location">
View my location coordinates
</label>

<label class="option">
<input type="radio" name="option" value="users">
View all users connected to my system
</label>

<label class="option">
<input type="radio" name="option" value="find">
Find a file or directory
</label>

<input type="submit" value="Submit">
</form>
</div>
</body>
</html>






