# Just Commands Documentation

This project uses [Just](https://github.com/casey/just) as a command runner for common development tasks.

## Prerequisites

All dependencies are managed through Flox:
- `just` - Command runner
- `livereload` - Development server
- `nodejs` - For running Lighthouse via npx
- Image optimization tools (`imagemagick`, `pngquant`, `optipng`)

## Available Commands

Run `just --list` or simply `just` to see all available commands.

### Development

```bash
# Start the development server
just dev
```

Starts livereload server on http://localhost:8888

### Performance Testing

```bash
# Run standard Lighthouse audit (opens report automatically)
just lighthouse

# Run comprehensive desktop audit
just lighthouse-full

# Run mobile performance audit
just lighthouse-mobile

# Quick performance score check (no HTML report)
just perf
```

All Lighthouse commands:
- Start dev server automatically
- Run the audit
- Generate HTML and JSON reports
- Open the report in your browser
- Stop the server when done

### Image Optimization

```bash
# Optimize all PNG images in assets/images/
just optimize-images
```

Uses pngquant and optipng to reduce image file sizes while maintaining quality.

### Utilities

```bash
# Show environment info
just info

# Clean up generated reports
just clean
```

## Report Files

Lighthouse generates the following reports (all gitignored):
- `lighthouse-report.html` / `.json` - Standard audit
- `lighthouse-report-full.html` / `.json` - Desktop audit
- `lighthouse-mobile.html` / `.json` - Mobile audit
- `lighthouse-perf.json` - Quick performance check

## Example Workflow

```bash
# 1. Check environment
just info

# 2. Run performance audit
just lighthouse

# 3. Run mobile audit
just lighthouse-mobile

# 4. Clean up reports
just clean
```

## Note on Lighthouse

Lighthouse is run via `npx lighthouse` using the Node.js installation from Flox. This approach:
- Works on all platforms (macOS, Linux, Windows)
- Automatically downloads and runs the latest Lighthouse version
- No global installation required
- Uses Node.js from the Flox environment
