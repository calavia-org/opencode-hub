#!/bin/bash
# Build script for Vercel - converts .md files to .html for better SEO
# Requires: npm install -g marked

echo "Building OpenCode Hub..."

# Convert all .md files to .html (except node_modules)
find . -name "*.md" -not -path "*/node_modules/*" | while read mdfile; do
  htmlfile="${mdfile%.md}.html"
  
  # Skip if .html already exists and is newer
  if [ -f "$htmlfile" ] && [ "$htmlfile" -nt "$mdfile" ]; then
    continue
  fi
  
  echo "Converting: $mdfile → $htmlfile"
  
  # Create HTML wrapper with marked.js
  cat > "$htmlfile" <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>OpenCode Hub - $(basename "$mdfile" .md)</title>
  <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; max-width: 900px; margin: 0 auto; padding: 2rem; line-height: 1.6; color: #333; }
    h1 { color: #333; border-bottom: 2px solid #0066cc; padding-bottom: 0.5rem; }
    h2 { color: #0066cc; margin-top: 2rem; }
    h3 { color: #555; }
    code { background: #f4f4f4; padding: 0.2rem 0.4rem; border-radius: 3px; }
    pre { background: #f4f4f4; padding: 1rem; border-radius: 5px; overflow-x: auto; }
    table { width: 100%; border-collapse: collapse; margin: 1rem 0; }
    th, td { border: 1px solid #ddd; padding: 0.5rem; text-align: left; }
    th { background: #f4f4f4; }
    a { color: #0066cc; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
  <div id="content"></div>
  <script>
    fetch('/$mdfile')
      .then(response => response.text())
      .then(text => {
        document.getElementById('content').innerHTML = marked.parse(text);
        mermaid.initialize({ startOnLoad: true });
      });
  </script>
</body>
</html>
EOF
done

echo "Build complete!"
