# Deployment Guide for Semester 5 Notes

This guide will help you deploy your Typst notes repository to Vercel.

## Prerequisites

- GitHub account
- Vercel account (free)
- Your repository pushed to GitHub

## Step-by-Step Deployment

### 1. Prepare Your Repository

Add the following files to your repository root:

1. **package.json** - Node.js configuration
2. **build.js** - Build script that compiles Typst files
3. **vercel.json** - Vercel deployment configuration
4. Update **.gitignore** - Add Node.js and build artifacts

### 2. Push to GitHub

```bash
git add .
git commit -m "Add Vercel deployment configuration"
git push origin main
```

### 3. Deploy to Vercel

#### Option A: Using Vercel CLI
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Follow the prompts:
# - Link to existing project? N
# - What's your project's name? semester-5-notes
# - In which directory is your code located? ./
```

#### Option B: Using Vercel Dashboard
1. Go to [vercel.com](https://vercel.com)
2. Sign in with GitHub
3. Click "New Project"
4. Import your repository
5. Vercel will auto-detect the configuration
6. Click "Deploy"

### 4. Verify Deployment

After deployment:
- Visit your Vercel URL (e.g., `https://semester-5-notes.vercel.app`)
- You should see a clean interface with all your PDF notes
- Each PDF should be downloadable

## How It Works

1. **Build Process**: The `build.js` script:
   - Installs Typst if not available
   - Finds all `.typ` files in your repository
   - Compiles them to PDFs in `public/pdfs/`
   - Generates a beautiful `index.html` with download links

2. **File Structure After Build**:
   ```
   public/
   ├── index.html          # Main page with PDF links
   └── pdfs/               # Compiled PDFs
       ├── Ethical-Hacking.pdf
       ├── Financial-Engineering.pdf
       ├── Operating-Systems.pdf
       ├── Operations-Research.pdf
       └── Soft-Computing.pdf
   ```

3. **Routing**: Vercel serves:
   - `/` → `public/index.html`
   - `/pdfs/*` → `public/pdfs/*`

## Customization

### Modify the UI
Edit the HTML template in `build.js` to change:
- Colors and styling
- Page title and description
- Card layout and design

### Add More File Types
Extend the `findTypFiles` function to include other formats or change the compilation logic.

### Environment Variables
If you need to customize build behavior, add environment variables in Vercel dashboard under Project Settings → Environment Variables.

## Troubleshooting

### Build Fails
- Check Vercel function logs in the dashboard
- Ensure all `.typ` files compile locally first
- Verify no syntax errors in your Typst files

### PDFs Not Showing
- Check file paths are correct
- Verify build process completed successfully
- Look at Network tab in browser dev tools

### Performance Issues
- Large PDF files may cause slow loading
- Consider optimizing Typst compilation
- Use Vercel's Edge Network features

## Auto-Deploy

Once set up, any push to your main branch will automatically trigger a new deployment with updated PDFs.

## Custom Domain (Optional)

1. In Vercel dashboard, go to your project
2. Settings → Domains
3. Add your custom domain
4. Follow DNS configuration instructions

Your notes will be available at your custom domain!