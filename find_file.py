#!/usr/bin/python3
# Shebang line: tells the system to use Python 3 to execute this script

# Import required modules
import os                # Access environment variables (e.g., request method)
import urllib.parse     # Parse URL-encoded form data
import subprocess       # Run system commands (like 'find')
import html             # Escape HTML to prevent injection
import sys              # Read input from standard input (POST data)

# Print HTTP header to indicate HTML content
print("Content-type: text/html\n")

# Get the HTTP request method (GET or POST)
request_method = os.environ.get("REQUEST_METHOD", "")

# Initialize filename variable
filename = ""

# -------------------------
# Handle POST request
# -------------------------
if request_method == "POST":
    # Get the length of incoming POST data
    length = int(os.environ.get("CONTENT_LENGTH", 0))

    # Read POST data from standard input (if any)
    post_data = sys.stdin.read(length) if length > 0 else ""

    # Parse the POST data into a dictionary
    # Extract the 'filename' field (default to empty string if not present)
    filename = urllib.parse.parse_qs(post_data).get("filename", [""])[0]

# -------------------------
# Start HTML output
# -------------------------
print("""
<html>
<head>
<title>Find File or Directory</title>
<link rel="stylesheet" type="text/css" href="/styles.css">
</head>
<body>
<div class="container">
<h1>Find a File or Directory</h1>
""")

# -------------------------
# If user submitted a filename
# -------------------------
if filename:
    # Escape filename for safe HTML display (prevents XSS)
    safe_filename = html.escape(filename)

    # Create search pattern for 'find' command (case-insensitive match)
    search = f"*{filename}*"

    # Run the Linux 'find' command to search within /home/garcia146
    completed = subprocess.run(
        ["find", "/home/garcia146", "-iname", search],  # Command and arguments
        stdout=subprocess.PIPE,     # Capture standard output
        stderr=subprocess.DEVNULL,  # Suppress error messages
        text=True                  # Return output as string (not bytes)
    )

    # Store the command output
    result = completed.stdout

    # Display search results heading
    print(f"<p>Search results for: <strong>{safe_filename}</strong></p>")

    # Display results in preformatted text block
    print("<pre>")

    # If results exist, print them (escaped for safety)
    if result.strip():
        print(html.escape(result))
    else:
        # If no results found
        print("No file or directory found.")

    print("</pre>")

# -------------------------
# If no filename provided (initial page load)
# -------------------------
else:
    # Display search form
    print("""
    <p>Enter the name of a file or directory to search inside /home.</p>
    <form method="POST" action="/cgi-bin/find_file.py">
    <input type="text" name="filename" required>
    <input type="submit" value="Search">
    </form>
    """)

# -------------------------
# Footer and navigation
# -------------------------
print("""
<a class="button" href="/index.php">Return Main Menu</a>
</div>
</body>
</html>
""")
