# Planet Nix Website - Project Documentation

> **Important**: This file and README.md should always be kept in sync. When updating project information, documentation, or development workflow in one file, make sure to update the other accordingly.

## Project Overview

This is a single-page website for Planet Nix, built with simplicity in mind - no build steps required. Optimized for performance with a Lighthouse score of 84/100.

## Technology Stack

### Core Technologies
- **HTML5**: Semantic markup for the single-page structure in `index.html`
- **[Pico CSS](https://picocss.com/)**: Minimal, elegant CSS framework
  - Classless semantic CSS framework
  - Responsive by default with mobile-first design
  - Built-in dark mode support
  - Beautiful typography out of the box
  - No utility classes needed - uses semantic HTML

### Development Tools
- **[Flox](https://flox.dev/)**: Reproducible development environment
  - Handles all environment setup and dependencies
  - Ensures consistent development environment across machines
- **[Just](https://github.com/casey/just)**: Command runner for common tasks
  - `just dev` - Start development server
  - `just perf` - Check performance
  - `just lighthouse` - Run full audit
- **livereload**: Automatic browser refresh during development
- **[Lighthouse](https://github.com/GoogleChrome/lighthouse)**: Performance monitoring and CI

## Project Structure

```
planetnix-website/
├── index.html              # Main single-page website file
├── assets/                 # All website resources
│   ├── css/
│   │   ├── pico.min.css   # Pico CSS framework
│   │   └── style.css      # Custom styles
│   ├── fonts/             # Local fonts (Geist, Geist Mono)
│   ├── images/            # Optimized images (76.6% size reduction)
│   └── js/                # JavaScript files (if needed)
├── Justfile               # Command runner recipes with inline docs
├── .github/workflows/     # CI/CD automation
│   └── lighthouse-pr.yml  # Automated performance testing
├── CLAUDE.md              # Project documentation for AI assistants
└── README.md              # User-facing documentation
```

### Assets Folder

All extra resources needed for the website should be placed in the `assets/` folder:
- **assets/css/** - CSS stylesheets (Pico CSS + custom styles)
- **assets/fonts/** - Local font files (Geist, Geist Mono)
- **assets/images/** - Optimized images, icons, logos, and graphics
  - All images optimized using pngquant and optipng
  - Lazy loading for below-the-fold images
  - Total size reduced from 2.3 MB to 556 KB
- **assets/js/** - JavaScript files for interactivity (minimal)

## Development Workflow

### Quick Start
```bash
# 1. Enter the development environment
flox activate

# 2. Start the development server
just dev

# 3. Edit index.html - changes reload automatically
```

### Common Tasks

**Important**: All `just` commands must be run within the Flox environment using `flox activate --`:

```bash
flox activate -- just                   # List all available commands
flox activate -- just dev              # Start development server
flox activate -- just perf             # Quick performance check (84/100 current)
flox activate -- just lighthouse       # Full performance audit with HTML report
flox activate -- just lighthouse-mobile # Mobile performance test
flox activate -- just optimize-images  # Re-optimize images
flox activate -- just clean            # Remove generated reports
flox activate -- just info             # Show environment info
```

Alternatively, activate the Flox shell first, then run just commands directly:
```bash
flox activate
# Now you can run just commands directly:
just dev
just perf
```

### Performance Testing
- **Local**: Use `flox activate -- just perf` before committing
- **CI/CD**: Automated Lighthouse tests on every PR
- **Comparison**: CI compares PR performance vs base branch
- **Reports**: Posted as PR comments with score deltas

## Design Philosophy

- **No build process**: Direct HTML and CSS for maximum simplicity
- **Single-page design**: All content accessible from one page
- **Semantic styling**: Pico CSS uses semantic HTML, no utility classes
- **Performance first**: Every optimization counts
  - Images: 2.3 MB → 556 KB (76.6% reduction)
  - Initial load: Only 139 KB of images (lazy loading)
  - Lighthouse score: 84/100 and improving
- **Reproducible environment**: Flox ensures consistent setup across machines
- **Automated quality**: CI/CD prevents performance regressions

## Performance Optimizations

### Implemented
- ✅ **Image optimization**: pngquant + optipng (76.6% size reduction)
- ✅ **Lazy loading**: Below-the-fold images load on demand
- ✅ **Local fonts**: Geist and Geist Mono with font-display: swap
- ✅ **Minimal CSS**: Pico CSS is only 22 KB minified
- ✅ **Semantic HTML**: No unnecessary divs or classes

### Monitoring
- **GitHub Actions**: Automated Lighthouse audits on every PR
- **Performance tracking**: Score comparisons show impact of changes
- **Just commands**: Easy local testing before pushing
