const { marked } = require('marked');

// Custom renderer to handle mermaid code blocks
const renderer = new marked.Renderer();
const defaultRenderer = renderer.code.bind(renderer);

renderer.code = (token) => {
  if (token.lang === 'mermaid') {
    // Wrap mermaid code in div with proper class
    return `<div class="mermaid">${token.text}</div>`;
  }
  // Fall back to default renderer for other languages
  return defaultRenderer(token);
};

module.exports = async (req, res) => {
  const { file } = req.query;
  
  if (!file || !file.endsWith('.md')) {
    return res.status(400).send('Missing or invalid file parameter');
  }
  
  try {
    const baseUrl = `https://${req.headers.host}`;
    const response = await fetch(`${baseUrl}/${file}`);
    
    if (!response.ok) {
      return res.status(404).send('File not found');
    }
    
    const markdown = await response.text();
    const htmlContent = marked.parse(markdown, { renderer });
    
    const fullHtml = `
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${file}</title>
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
    .mermaid { text-align: center; margin: 2rem 0; padding: 1rem; background: #f9f9f9; border-radius: 5px; }
  </style>
</head>
<body>
  ${htmlContent}
  <script>
    mermaid.initialize({ startOnLoad: true, theme: 'default' });
  </script>
</body>
</html>
    `;
    
    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    res.send(fullHtml);
    
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('Internal Server Error');
  }
};
