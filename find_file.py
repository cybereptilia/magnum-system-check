#!/usr/bin/python3

import os
import urllib.parse
import subprocess
import html
import sys

print("Content-type: text/html\n")

request_method = os.environ.get("REQUEST_METHOD", "")

filename = ""

if request_method == "POST":
      length = int(os.environ.get("CONTENT_LENGTH", 0))
      post_data = sys.stdin.read(length) if length > 0 else ""
      filename = urllib.parse.parse_qs(post_data).get("filename", [""])[0]
      

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

if filename:
    safe_filename = html.escape(filename)
    search = f"*{filename}*"

    completed = subprocess.run(
        ["find", "/home/garcia146", "-iname", search],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True
    )

    result = completed.stdout

    print(f"<p>Search results for: <strong>{safe_filename}</strong></p>")
    print("<pre>")
    if result.strip():
        print(html.escape(result))
    else:
        print("No file or directory found.")
    print("</pre>")
else:
    print("""
    <p>Enter the name of a file or directory to search inside /home.</p>
    <form method="POST" action="/cgi-bin/find_file.py">
    <input type="text" name="filename" required>
    <input type="submit" value="Search">
    </form>
    """)
print("""
    <a class="button" href="/index.php">Return Main Menu</a>
    </div>
    </body>
    </html>
    """)
