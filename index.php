<?php
// Check if the form was submitted using POST method
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Retrieve the selected radio button value from the form
    $option = $_POST["option"];

    // Based on the selected option, redirect the user
    if ($option == "process") {
        // Redirect to Perl script that shows system processes
        header("Location: /cgi-bin/processes.pl");
        exit; // Stop further script execution after redirect

    } elseif ($option == "calendar") {
        // Redirect to calendar CGI script
        header("Location: /cgi-bin/calendar.pl");
        exit;

    } elseif ($option == "location") {
        // Redirect to Python script that shows location coordinates
        header("Location: /cgi-bin/location.py");
        exit;

    } elseif ($option == "users") {
        // Redirect to script that lists system users
        header("Location: /cgi-bin/users.pl");
        exit;

    } elseif ($option == "find") {
        // Redirect to Python script that searches for files/directories
        header("Location: /cgi-bin/find_file.py");
        exit;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Magnum System Check</title>

<!-- Link to external CSS file for styling -->
<link rel="stylesheet" href="/styles.css">
</head>
<body>

<div class="container">
<h1>Welcome to Magnum System Check</h1>

<!-- Form that sends user selection back to this same PHP file -->
<form method="POST" action="index.php">

<div class="menu-options">

<!-- Option 1: View system processes -->
<label class="option">
<input type="radio" name="option" value="process" required>
View my process
</label>

<!-- Option 2: View calendar -->
<label class="option">
<input type="radio" name="option" value="calendar">
View the calendar
</label>

<!-- Option 3: View location -->
<label class="option">
<input type="radio" name="option" value="location">
View my location coordinates
</label>

<!-- Option 4: View connected users -->
<label class="option">
<input type="radio" name="option" value="users">
View all users connected to my system
</label>

<!-- Option 5: Find file or directory -->
<label class="option">
<input type="radio" name="option" value="find">
Find a file or directory
</label>

<!-- Submit button -->
<input type="submit" value="Submit">

</form>
</div>
</body>
</html>
