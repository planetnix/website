# ============================================================================
# PlanetNix Website - Just Commands
# ============================================================================
#
# This project uses Just (https://github.com/casey/just) as a command runner
# for common development tasks.
#
# Prerequisites (all managed through Flox):
# - just: Command runner
# - livereload: Development server
# - nodejs: For running Lighthouse via npx
# - imagemagick, pngquant, optipng: Image optimization tools
#
# Quick Start:
#   flox activate            # Enter development environment
#   flox services start      # Start development server (http://localhost:8888)
#   just                     # Show all available commands
#   just lighthouse          # Run performance audit
#   just perf                # Quick performance score
#   flox services stop       # Stop development server
#
# Available Commands:
#
# Performance Testing (Lighthouse):
#   just lighthouse          - Standard Lighthouse audit (opens HTML report)
#   just lighthouse-full     - Comprehensive desktop audit
#   just lighthouse-mobile   - Mobile performance audit
#   just perf                - Quick performance score check (84/100 baseline)
#
#   Note: Ensure dev server is running (flox services start) before
#   running Lighthouse commands
#
# Image Optimization:
#   just optimize-images              - Optimize all PNG images in assets/images/
#                                       Uses pngquant (65-80% quality) + optipng
#   just generate-responsive-images   - Generate 480w, 768w, 1024w versions of
#                                       background images for responsive loading
#                                       Creates WebP versions optimized for mobile
#                                       All generated files placed in assets/images/generated/
#   just generate-favicons            - Generate all favicon and app icons from
#                                       planetnix-logo-small.png (16x16, 32x32, 180x180,
#                                       192x192, 512x512, favicon.ico)
#   just regenerate-all-images        - Regenerate ALL optimized images from source
#                                       Creates WebP versions of all PNGs + responsive sizes
#
# Utilities:
#   just clean               - Remove all generated Lighthouse reports
#
# Report Files (all gitignored):
#   lighthouse-report.html / .json       - Standard audit
#   lighthouse-report-full.html / .json  - Desktop audit
#   lighthouse-mobile.html / .json       - Mobile audit
#   lighthouse-perf.json                 - Performance score only
#
# Example Workflow:
#   flox activate            # Enter environment (shows info + commands)
#   flox services start      # Start dev server
#   just lighthouse          # Run audit
#   just lighthouse-mobile   # Test mobile
#   flox services stop       # Stop dev server
#   just clean               # Clean up reports
#
# Notes:
# - Lighthouse runs via 'npx lighthouse' for cross-platform compatibility
# - First run will auto-download Lighthouse (~1 minute)
# - Subsequent runs are instant
# - Dev server runs on http://localhost:8888 (managed by Flox services)
#
# ============================================================================

# Default recipe - show environment info and available commands
@_default:
    @echo "📦 Environment Information:"
    @echo ""
    @flox list
    @echo ""
    @echo "🔗 Dev Server: http://localhost:8888"
    @echo ""
    @echo "📋 Available Commands:"
    @echo ""
    @just --list --unsorted

# Run Lighthouse performance audit
lighthouse:
    @echo "🔍 Running Lighthouse performance audit..."
    @sleep 3
    flox activate -- npx lighthouse http://localhost:8888 \
        --output html \
        --output json \
        --output-path ./lighthouse-report \
        --view \
        --chrome-flags="--headless"
    @echo "✅ Lighthouse report generated: lighthouse-report.html"

# Run Lighthouse with detailed metrics
lighthouse-full:
    @echo "🔍 Running comprehensive Lighthouse audit..."
    @sleep 3
    flox activate -- npx lighthouse http://localhost:8888 \
        --output html \
        --output json \
        --output-path ./lighthouse-report-full \
        --preset=desktop \
        --throttling.cpuSlowdownMultiplier=1 \
        --view \
        --chrome-flags="--headless"
    @echo "✅ Full Lighthouse report generated: lighthouse-report-full.html"

# Run Lighthouse for mobile
lighthouse-mobile:
    @echo "📱 Running Lighthouse mobile audit..."
    @sleep 3
    flox activate -- npx lighthouse http://localhost:8888 \
        --output html \
        --output json \
        --output-path ./lighthouse-mobile \
        --preset=mobile \
        --view \
        --chrome-flags="--headless"
    @echo "✅ Mobile Lighthouse report generated: lighthouse-mobile.html"

# Quick performance check (just scores, no report)
perf:
    @echo "⚡ Running quick performance check..."
    @sleep 3
    flox activate -- npx lighthouse http://localhost:8888 \
        --only-categories=performance \
        --output json \
        --output-path ./lighthouse-perf.json \
        --quiet \
        --chrome-flags="--headless"
    @echo "📊 Performance Score:"
    @flox activate -- node -e "const data = require('./lighthouse-perf.json'); console.log('  Performance: ' + Math.round(data.categories.performance.score * 100) + '/100');"

# Clean up generated reports
clean:
    @echo "🧹 Cleaning up reports..."
    @rm -f lighthouse-report.html lighthouse-report.json
    @rm -f lighthouse-report-full.html lighthouse-report-full.json
    @rm -f lighthouse-mobile.html lighthouse-mobile.json
    @rm -f lighthouse-perf.json
    @rm -f .server.pid
    @echo "✅ Cleaned up all reports"

# Run image optimization (from our previous work)
optimize-images:
    @echo "🖼️  Optimizing images..."
    @cd assets/images && \
    for img in *.png; do \
        if [ -f "$$img" ]; then \
            echo "  Processing $$img..."; \
            flox activate -- pngquant --quality=65-80 --speed 1 --force "$$img" -o "$${img%.png}-temp.png" && \
            flox activate -- optipng -o2 "$${img%.png}-temp.png" && \
            mv "$${img%.png}-temp.png" "$$img"; \
        fi; \
    done
    @echo "✅ Image optimization complete"

# Generate responsive image sizes for background images
# Creates 480w, 768w, and 1024w versions of specified images for responsive loading
# Original 1280w images are preserved
# All generated files are placed in assets/images/generated/
generate-responsive-images:
    @echo "🖼️  Generating responsive image sizes..."
    @mkdir -p assets/images/generated
    @cd assets/images && \
    for img in location-bg about-bg; do \
        echo "  Processing $${img}..."; \
        if [ -f "$${img}.png" ]; then \
            echo "    Creating 480w version..."; \
            sips -z 320 480 "$${img}.png" --out "generated/$${img}-480w.png" > /dev/null 2>&1; \
            echo "    Creating 768w version..."; \
            sips -z 512 768 "$${img}.png" --out "generated/$${img}-768w.png" > /dev/null 2>&1; \
            echo "    Creating 1024w version..."; \
            sips -z 682 1024 "$${img}.png" --out "generated/$${img}-1024w.png" > /dev/null 2>&1; \
        else \
            echo "    ⚠️  $${img}.png not found, skipping"; \
        fi; \
    done && \
    echo "  Optimizing resized PNGs..." && \
    cd generated && \
    for png in *-{480,768,1024}w.png; do \
        if [ -f "$$png" ]; then \
            flox activate -- pngquant --quality=65-80 --speed 1 --force "$$png" -o "$${png%.png}-temp.png" && \
            flox activate -- optipng -o2 "$${png%.png}-temp.png" && \
            mv "$${png%.png}-temp.png" "$$png"; \
        fi; \
    done && \
    echo "  Converting to WebP..." && \
    for img in location-bg about-bg; do \
        for size in 480 768 1024; do \
            if [ -f "$${img}-$${size}w.png" ]; then \
                flox activate -- cwebp -q 90 "$${img}-$${size}w.png" -o "$${img}-$${size}w.webp" 2>&1 | grep -E "(Saving|Output)" || true; \
            fi; \
        done; \
    done
    @echo "✅ Responsive images generated"
    @echo ""
    @echo "📊 File sizes created:"
    @cd assets/images/generated && ls -lh *-{480,768,1024}w.webp 2>/dev/null || echo "No responsive images found"

# Generate all favicon and app icon sizes from planetnix-logo-small.png
# Creates all required icon sizes in assets/images/generated/
# Sizes: favicon.ico, 16x16, 32x32, apple-touch-icon (180x180), android-chrome (192x192, 512x512)
generate-favicons:
    @echo "🎨 Generating favicons and app icons from planetnix-logo-small.png..."
    @mkdir -p assets/images/generated
    @cd assets/images && \
    if [ ! -f "planetnix-logo-small.png" ]; then \
        echo "❌ Error: planetnix-logo-small.png not found in assets/images/"; \
        exit 1; \
    fi && \
    echo "  Creating favicon-16x16.png..." && \
    flox activate -- magick planetnix-logo-small.png -resize 16x16 generated/favicon-16x16.png && \
    echo "  Creating favicon-32x32.png..." && \
    flox activate -- magick planetnix-logo-small.png -resize 32x32 generated/favicon-32x32.png && \
    echo "  Creating apple-touch-icon.png (180x180)..." && \
    flox activate -- magick planetnix-logo-small.png -resize 180x180 generated/apple-touch-icon.png && \
    echo "  Creating android-chrome-192x192.png..." && \
    flox activate -- magick planetnix-logo-small.png -resize 192x192 generated/android-chrome-192x192.png && \
    echo "  Creating android-chrome-512x512.png..." && \
    flox activate -- magick planetnix-logo-small.png -resize 512x512 generated/android-chrome-512x512.png && \
    echo "  Creating favicon.ico (multi-resolution)..." && \
    flox activate -- magick planetnix-logo-small.png -resize 16x16 -resize 32x32 -resize 48x48 generated/favicon.ico
    @echo "✅ All favicons and app icons generated"
    @echo ""
    @echo "📊 Generated files:"
    @cd assets/images/generated && ls -lh favicon* apple-touch-icon.png android-chrome-*.png 2>/dev/null

# Regenerate all optimized images from source images
# This command:
# 1. Finds all PNG source images in assets/images/ (excluding generated/ folder)
# 2. Creates WebP versions of all source PNGs in generated/
# 3. Generates responsive sizes (480w, 768w, 1024w) for background images
regenerate-all-images:
    @echo "🖼️  Regenerating all optimized images..."
    @mkdir -p assets/images/generated
    @echo ""
    @echo "📸 Converting source PNGs to WebP..."
    @cd assets/images && \
    for img in *.png; do \
        if [ -f "$$img" ] && [ "$$img" != "generated" ]; then \
            echo "  Converting $$img to WebP..."; \
            flox activate -- cwebp -q 90 "$$img" -o "generated/$${img%.png}.webp" 2>&1 | grep -E "(Saving|Output)" || true; \
        fi; \
    done
    @echo ""
    @echo "📐 Generating responsive sizes for background images..."
    @just generate-responsive-images
    @echo ""
    @echo "✅ All optimized images regenerated"
    @echo ""
    @echo "📊 Generated files:"
    @cd assets/images/generated && ls -lh *.webp 2>/dev/null | head -20 || echo "No generated images found"
