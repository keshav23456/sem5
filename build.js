const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🔧 Building Semester 5 Notes...');

// Create public directory
if (!fs.existsSync('public')) {
  fs.mkdirSync('public');
}

// Create pdfs directory inside public
if (!fs.existsSync('public/pdfs')) {
  fs.mkdirSync('public/pdfs');
}

// Install Typst if not available
try {
  execSync('typst --version', { stdio: 'pipe' });
  console.log('✅ Typst is available');
} catch (error) {
  console.log('📦 Installing Typst...');
  // Install Typst using the official installer
  execSync('curl -fsSL https://typst.community/typst-install/install.sh | sh', { stdio: 'inherit' });
  // Add to PATH for this session
  process.env.PATH = `${process.env.HOME}/.local/bin:${process.env.PATH}`;
}

// Find all .typ files recursively (max 2 levels deep)
function findTypFiles(dir, maxDepth = 2, currentDepth = 0) {
  let typFiles = [];
  
  if (currentDepth >= maxDepth) return typFiles;
  
  const items = fs.readdirSync(dir);
  
  for (const item of items) {
    const fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    
    if (stat.isDirectory() && !item.startsWith('.') && item !== 'node_modules' && item !== 'public') {
      typFiles = typFiles.concat(findTypFiles(fullPath, maxDepth, currentDepth + 1));
    } else if (stat.isFile() && item.endsWith('.typ')) {
      typFiles.push(fullPath);
    }
  }
  
  return typFiles;
}

const typFiles = findTypFiles('.');

if (typFiles.length === 0) {
  console.log('❌ No .typ files found');
  process.exit(1);
}

console.log(`📝 Found ${typFiles.length} Typst files`);

// Compile each .typ file to PDF
const compiledFiles = [];

for (const typFile of typFiles) {
  try {
    const filename = path.basename(typFile, '.typ');
    const outputPath = `public/pdfs/${filename}.pdf`;
    
    console.log(`🔨 Compiling ${typFile}...`);
    execSync(`typst compile "${typFile}" "${outputPath}"`, { stdio: 'inherit' });
    
    compiledFiles.push({
      name: filename,
      path: `pdfs/${filename}.pdf`,
      source: typFile
    });
    
    console.log(`✅ ${typFile} → ${outputPath}`);
  } catch (error) {
    console.error(`❌ Failed to compile ${typFile}:`, error.message);
  }
}

// Generate index.html
const indexHtml = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Semester 5 Notes</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        h1 {
            text-align: center;
            color: #2d3748;
            margin-bottom: 2rem;
            font-size: 2.5rem;
            font-weight: 700;
        }
        .subtitle {
            text-align: center;
            color: #718096;
            margin-bottom: 3rem;
            font-size: 1.1rem;
        }
        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .note-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
        }
        .note-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.12);
        }
        .note-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 1rem;
        }
        .note-path {
            font-size: 0.9rem;
            color: #718096;
            margin-bottom: 1.5rem;
            font-family: 'SF Mono', Monaco, monospace;
            background: #f7fafc;
            padding: 0.5rem;
            border-radius: 5px;
        }
        .download-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .download-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .stats {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f7fafc;
            border-radius: 10px;
            color: #4a5568;
        }
        .empty-state {
            text-align: center;
            color: #718096;
            font-size: 1.2rem;
            margin-top: 3rem;
        }
        .footer {
            text-align: center;
            margin-top: 3rem;
            color: #a0aec0;
            font-size: 0.9rem;
        }
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .container { padding: 1.5rem; }
            h1 { font-size: 2rem; }
            .notes-grid { grid-template-columns: 1fr; gap: 1rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Semester 5 Notes</h1>
        <p class="subtitle">Academic notes compiled from Typst documents</p>
        
        ${compiledFiles.length > 0 ? `
        <div class="stats">
            <strong>${compiledFiles.length}</strong> PDF${compiledFiles.length !== 1 ? 's' : ''} available for download
        </div>
        
        <div class="notes-grid">
            ${compiledFiles.map(file => `
            <div class="note-card">
                <div class="note-title">${file.name.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}</div>
                <div class="note-path">${file.source}</div>
                <a href="${file.path}" class="download-btn" target="_blank">
                    📄 Download PDF
                </a>
            </div>
            `).join('')}
        </div>
        ` : `
        <div class="empty-state">
            No PDF files were generated. Check your Typst files for compilation errors.
        </div>
        `}
        
        <div class="footer">
            Built with ❤️ using Typst • Deployed on Vercel
        </div>
    </div>
</body>
</html>
`;

fs.writeFileSync('public/index.html', indexHtml);

console.log(`🎉 Build completed! Generated ${compiledFiles.length} PDF files.`);
console.log('📁 Files available at: public/index.html');