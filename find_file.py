#!/usr/bin/python3
# Shebang: use Python 3

# Import required modules
import os
import urllib.parse
import subprocess
import html
import sys
import re   # For input validation

# Print HTTP header
print("Content-type: text/html\n")

# Get request method
request_method = os.environ.get("REQUEST_METHOD", "")

# Initialize filename
filename = ""

# -------------------------
# Handle POST request safely
# -------------------------
if request_method == "POST":
    try:
        # Limit max POST size to prevent abuse (e.g., 1KB)
        length = min(int(os.environ.get("CONTENT_LENGTH", 0)), 1024)

        post_data = sys.stdin.read(length) if length > 0 else ""

        # Extract filename
        filename = urllib.parse.parse_qs(post_data).get("filename", [""])[0]

    except:
        filename = ""

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
    # Trim whitespace
    filename = filename.strip()

    # Escape for HTML display
    safe_filename = html.escape(filename)

    # -------------------------
    # Validate input (IMPORTANT)
    # -------------------------
    # Allow only safe characters (letters, numbers, ., -, _)
    if not re.match(r'^[\w.\-]{1,100}$', filename):
        print("<p>Invalid filename. Use only letters, numbers, ., -, _</p>")
    else:
        # Create safe search pattern
        search = f"*{filename}*"

        try:
            # Run find with safety limits
            completed = subprocess.run(
                ["find", "/home/garcia146", "-iname", search],
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
                text=True,
                timeout=5  # Prevent long-running searches
            )

            result = completed.stdout

        except subprocess.TimeoutExpired:
            result = "Search timed out. Please try a more specific name."

        # -------------------------
        # Display results
        # -------------------------
        print(f"<p>Search results for: <strong>{safe_filename}</strong></p>")
        print("<pre>")

        if result.strip():
            # Limit output size (e.g., first 10,000 chars)
            print(html.escape(result[:10000]))
        else:
            print("No file or directory found.")

        print("</pre>")

# -------------------------
# If no filename provided
# -------------------------
else:
    print("""
    <p>Enter the name of a file or directory to search inside /home.</p>
    <form method="POST" action="/cgi-bin/find_file.py">
    <input type="text" name="filename" required>
    <input type="submit" value="Search">
    </form>
    """)

# -------------------------
# Footer
# -------------------------
print("""
<a class="button" href="/index.php">Return Main Menu</a>
</div>
</body>
</html>
""")
