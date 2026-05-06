#!/usr/bin/python3

import subprocess
import json

print("Content-type: text/html\n")

# Get the location data from ipinfo
raw_data = subprocess.getoutput("curl -s ipinfo.io")

try:
    data = json.loads(raw_data)

    city = data.get("city", "Not available")
    region = data.get("region", "Not available")
    country = data.get("country", "Not available")
    coordinates = data.get("loc", "Not available")
    timezone = data.get("timezone", "Not available")
    ip = data.get("ip", "Not available")

except:
    city = region = country = coordinates = timezone = ip = "Not available"

print(f"""
<html>
<head>
<title>System Location</title>
<link rel="stylesheet" href="/styles.css">     
</head>
<body>

<div class="container">
 <table>  
 <h1>System Location</h1>
          <tr><th>Field</th><th>Value</th></tr>
          <tr><td>IP Address</td><td>{ip}</td></tr>
          <tr><td>City</td><td>{city}</td></tr>
          <tr><td>Region</td><td>{region}</td></tr>
          <tr><td>Country</td><td>{country}</td></tr>
          <tr><td>Coordinates</td><td>{coordinates}</td></tr>
          <tr><td>Timezone</td><td>{timezone}</td></tr>
 </table>

    <a class="button" href="/index.php">Return Main Menu</a>
</div>

</body>
</html>
""")


