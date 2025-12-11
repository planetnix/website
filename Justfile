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
#   just              # Show all available commands
#   just dev          # Start development server
#   just lighthouse   # Run performance audit
#   just perf         # Quick performance score
#
# Available Commands:
#
# Development:
#   just dev                 - Start livereload server on http://localhost:8888
#
# Performance Testing (Lighthouse):
#   just lighthouse          - Standard Lighthouse audit (opens HTML report)
#   just lighthouse-full     - Comprehensive desktop audit
#   just lighthouse-mobile   - Mobile performance audit
#   just perf                - Quick performance score check (84/100 baseline)
#
#   All Lighthouse commands automatically:
#   - Start dev server in background
#   - Run the audit
#   - Generate HTML and JSON reports
#   - Open report in browser (except perf)
#   - Stop server when done
#
# Image Optimization:
#   just optimize-images     - Optimize all PNG images in assets/images/
#                              Uses pngquant (65-80% quality) + optipng
#
# Utilities:
#   just info                - Show Flox environment information
#   just clean               - Remove all generated Lighthouse reports
#
# Report Files (all gitignored):
#   lighthouse-report.html / .json       - Standard audit
#   lighthouse-report-full.html / .json  - Desktop audit
#   lighthouse-mobile.html / .json       - Mobile audit
#   lighthouse-perf.json                 - Performance score only
#
# Example Workflow:
#   just info                # Check environment
#   just lighthouse          # Run audit
#   just lighthouse-mobile   # Test mobile
#   just clean               # Clean up reports
#
# Notes:
# - Lighthouse runs via 'npx lighthouse' for cross-platform compatibility
# - First run will auto-download Lighthouse (~1 minute)
# - Subsequent runs are instant
# - Dev server runs on http://localhost:8888
# - Helper recipes (start-server-bg, stop-server) are internal utilities
#
# ============================================================================

# Default recipe - show available commands
@_default:
    just --list --unsorted

# Start the development server
dev:
    @echo "🚀 Starting development server on http://localhost:8888"
    flox activate -- livereload --port 8888

# Run Lighthouse performance audit
lighthouse: start-server-bg
    @echo "🔍 Running Lighthouse performance audit..."
    @sleep 3
    flox activate -- npx lighthouse http://localhost:8888 \
        --output html \
        --output json \
        --output-path ./lighthouse-report \
        --view \
        --chrome-flags="--headless"
    @echo "✅ Lighthouse report generated: lighthouse-report.html"
    @just stop-server

# Run Lighthouse with detailed metrics
lighthouse-full: start-server-bg
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
    @just stop-server

# Run Lighthouse for mobile
lighthouse-mobile: start-server-bg
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
    @just stop-server

# Quick performance check (just scores, no report)
perf: start-server-bg
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
    @just stop-server

# Start server in background (helper)
start-server-bg:
    @echo "🔧 Starting server in background..."
    @flox activate -- livereload --port 8888 > /dev/null 2>&1 & echo $$! > .server.pid
    @sleep 2

# Stop background server (helper)
stop-server:
    @if [ -f .server.pid ]; then \
        echo "🛑 Stopping server..."; \
        kill `cat .server.pid` 2>/dev/null || true; \
        rm .server.pid; \
    fi

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

# Show current environment info
info:
    @echo "📦 Environment Information:"
    @echo ""
    @flox list
    @echo ""
    @echo "🔗 Dev Server: http://localhost:8888"
