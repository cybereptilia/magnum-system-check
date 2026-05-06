#!/usr/bin/python3
# Shebang line: tells the system to execute this script using Python 3

# Import required modules
import subprocess   # Used to execute system commands (curl)
import json         # Used to parse JSON data

# Print HTTP header so the browser knows this is HTML content
print("Content-type: text/html\n")

# -------------------------
# Retrieve location data
# -------------------------
# Use curl to silently (-s) fetch JSON data from ipinfo.io
# This service returns geolocation info based on the system's public IP
raw_data = subprocess.getoutput("curl -s ipinfo.io")

try:
    # Convert JSON string into a Python dictionary
    data = json.loads(raw_data)

    # Extract specific fields from the JSON response
    # Use .get() with default value "Not available" in case a field is missing
    city        = data.get("city", "Not available")
    region      = data.get("region", "Not available")
    country     = data.get("country", "Not available")
    coordinates = data.get("loc", "Not available")      # Latitude,Longitude
    timezone    = data.get("timezone", "Not available")
    ip          = data.get("ip", "Not available")

except:
    # If JSON parsing fails (e.g., network issue or invalid response),
    # set all fields to "Not available"
    city = region = country = coordinates = timezone = ip = "Not available"

# -------------------------
# Output HTML page
# -------------------------
print(f"""
<html>
<head>
<title>System Location</title>

<!-- Link to external stylesheet -->
<link rel="stylesheet" href="/styles.css">     
</head>
<body>

<div class="container">

<!-- Table displaying location data -->
<table>  

<h1>System Location</h1>

<tr><th>Field</th><th>Value</th></tr>

<!-- Display each field and its value -->
<tr><td>IP Address</td><td>{ip}</td></tr>
<tr><td>City</td><td>{city}</td></tr>
<tr><td>Region</td><td>{region}</td></tr>
<tr><td>Country</td><td>{country}</td></tr>
<tr><td>Coordinates</td><td>{coordinates}</td></tr>
<tr><td>Timezone</td><td>{timezone}</td></tr>

</table>

<!-- Navigation button back to main menu -->
<a class="button" href="/index.php">Return Main Menu</a>

</div>

</body>
</html>
""")
