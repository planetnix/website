# Planet Nix Website - Project Documentation

> **Important**: This file and README.md should always be kept in sync. When updating project information, documentation, or development workflow in one file, make sure to update the other accordingly.

## Project Overview

This is a single-page website for Planet Nix, built with simplicity in mind - no build steps required.

## Technology Stack

### Core Technologies
- **HTML5**: Semantic markup for the single-page structure in `index.html`
- **Tailwind CSS**: Utility-first CSS framework for styling
  - Provides responsive design capabilities
  - Enables rapid UI development with utility classes
  - Maintains consistent design system

### Development Tools
- **Live Reload Tool**: Automatic browser refresh during development
- **Flox**: Development environment management
  - Handles all environment setup and dependencies
  - Ensures consistent development environment

## Project Structure

```
planetnix-website/
├── index.html          # Main single-page website file
├── assets/             # All website resources
│   ├── css/           # CSS files (Tailwind CSS)
│   ├── js/            # JavaScript files
│   └── images/        # Images, icons, and graphics
├── CLAUDE.md          # Project documentation for Claude
└── README.md          # Project documentation
```

### Assets Folder

All extra resources needed for the website should be placed in the `assets/` folder:
- **assets/css/** - CSS stylesheets including Tailwind CSS
- **assets/js/** - JavaScript files for interactivity
- **assets/images/** - All images, icons, logos, and graphics used on the site

## Development Workflow

1. Enter the development environment with Flox
2. Start the live reload server
3. Edit `index.html` - changes reload automatically in the browser

## Git Workflow

### Commit Guidelines
- **No Claude attribution**: Do not include any Claude-related attribution in commit messages or pull requests
  - No "🤖 Generated with Claude Code" footer
  - No "Co-Authored-By: Claude" lines
  - Keep commit messages clean and professional

### Pull Request Guidelines
- **No test plans**: Do not include test plans or testing checklists in PR descriptions
  - Keep PR descriptions concise and focused on the changes made
  - Describe what was changed and why, not how to test it

## Design Philosophy

- **No build process**: Direct HTML and CSS for maximum simplicity
- **Single-page design**: All content accessible from one page
- **Utility-first styling**: Tailwind CSS for rapid development and consistent design
- **Reproducible environment**: Flox ensures consistent setup across machines
