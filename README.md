# 🌙 Planet Nix Website

> **Where Nix Builders Come Together** - The official website for PlanetNix conference

A beautifully simple, single-page website built with modern web standards and optimized for performance. No build steps, no complex tooling - just clean HTML, elegant CSS, and lightning-fast load times.

[![Performance](https://img.shields.io/badge/Lighthouse-84%2F100-brightgreen)]()
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)]()

## ✨ What Makes This Special

- 🚀 **Blazing Fast** - Optimized images (76.6% size reduction) + lazy loading
- 📱 **Fully Responsive** - Beautiful on all devices with [Pico CSS](https://picocss.com/)
- ♿ **Accessible** - Semantic HTML and proper alt attributes
- 🎯 **Simple** - No build process, no complex tooling
- 🔄 **Auto-reload** - Live development with instant feedback
- 🧪 **CI/CD** - Automated performance testing on every PR

## 🚀 Quick Start

Get up and running in 3 commands:

```bash
# 1. Clone the repository
git clone https://github.com/planetnix/website.git
cd website

# 2. Enter the Flox development environment
flox activate

# 3. Start the development server
just dev
```

That's it! Open http://localhost:8888 in your browser and start coding. Changes reload automatically.

## 🛠️ Technology Stack

### Core Technologies
- **HTML5** - Semantic, accessible markup
- **[Pico CSS](https://picocss.com/)** - Minimal, elegant, classless CSS framework
  - Responsive by default
  - Dark mode support
  - No utility classes needed
  - Beautiful typography out of the box
- **Modern CSS** - Custom properties, Grid, Flexbox

### Development Tools
- **[Flox](https://flox.dev/)** - Reproducible development environment
- **[Just](https://github.com/casey/just)** - Command runner for common tasks
- **[Lighthouse](https://github.com/GoogleChrome/lighthouse)** - Performance monitoring
- **livereload** - Automatic browser refresh during development

## 📋 Development Commands

We use [Just](https://github.com/casey/just) for common development tasks. Run `just` to see all available commands:

```bash
# Development
just dev                 # Start development server on http://localhost:8888
just info                # Show environment information

# Performance Testing
just lighthouse          # Run full Lighthouse audit (opens HTML report)
just lighthouse-mobile   # Test mobile performance
just perf                # Quick performance score check

# Image Optimization
just optimize-images     # Optimize all PNG images

# Utilities
just clean               # Remove generated reports
```

## 📁 Project Structure

```
planetnix-website/
├── index.html              # Main single-page website
├── assets/
│   ├── css/
│   │   ├── pico.min.css   # Pico CSS framework
│   │   └── style.css      # Custom styles
│   ├── fonts/             # Local fonts (Geist, Geist Mono)
│   ├── images/            # Optimized images and icons
│   └── js/                # JavaScript (if needed)
├── Justfile               # Command runner recipes
├── .github/workflows/     # CI/CD automation
├── CLAUDE.md              # AI assistant documentation
└── README.md              # You are here!
```

## 🎨 Design Philosophy

- **Simplicity First** - No build process, no complex tooling
- **Performance Matters** - Every kilobyte counts
- **Accessibility Always** - Everyone should be able to use the site
- **Developer Joy** - Fast feedback loops, clear documentation
- **Modern Standards** - HTML5, CSS3, ES6+

## 🏎️ Performance

We take performance seriously:

- **Images**: Optimized from 2.3 MB → 556 KB (76.6% reduction)
- **Initial Load**: Only 139 KB of images load initially (lazy loading)
- **Lighthouse Score**: 84/100 and improving
- **CI/CD**: Automated performance testing on every PR

## 🤝 Contributing

**We'd love your help making this website better!** Whether you're fixing a typo, improving performance, or adding new features - all contributions are welcome.

### Ways to Contribute

- 🐛 **Report bugs** - Found something broken? [Open an issue](https://github.com/planetnix/website/issues)
- 💡 **Suggest features** - Have an idea? We'd love to hear it
- 📝 **Fix typos** - Even small improvements matter
- 🎨 **Improve design** - Make it prettier or more accessible
- ⚡ **Boost performance** - Help us make it even faster
- 📚 **Write docs** - Help others understand the project

### Getting Started with Contributing

1. **Fork the repository**
   ```bash
   # Click the Fork button on GitHub, then:
   git clone https://github.com/YOUR_USERNAME/website.git
   cd website
   ```

2. **Create a branch**
   ```bash
   git checkout -b my-awesome-feature
   ```

3. **Make your changes**
   ```bash
   flox activate
   just dev  # Start the dev server
   # Edit files, see changes live!
   ```

4. **Test your changes**
   ```bash
   just perf  # Check performance impact
   ```

5. **Commit and push**
   ```bash
   git add .
   git commit -m "Add awesome feature"
   git push origin my-awesome-feature
   ```

6. **Open a Pull Request**
   - Go to GitHub and click "New Pull Request"
   - Our CI will automatically test performance
   - We'll review and provide feedback

### Development Guidelines

- ✅ Keep it simple - no build process
- ✅ Test on mobile and desktop
- ✅ Use semantic HTML
- ✅ Optimize images before committing
- ✅ Check performance with `just perf`
- ✅ Follow existing code style

### First Time Contributing?

No worries! Here are some **beginner-friendly tasks**:

- Fix typos or grammar
- Improve alt text for images
- Add missing links
- Update outdated information
- Improve documentation

Check out issues labeled [`good first issue`](https://github.com/planetnix/website/labels/good%20first%20issue) to get started!

## 🧪 Testing

Our CI/CD pipeline automatically:
- ✅ Runs Lighthouse performance audits
- ✅ Compares performance against the base branch
- ✅ Posts results as PR comments
- ✅ Prevents performance regressions

Test locally before pushing:
```bash
just perf              # Quick performance check
just lighthouse        # Full audit with HTML report
```

## 📚 Learn More

- **[Pico CSS Documentation](https://picocss.com/docs)** - Learn about the CSS framework
- **[Flox Documentation](https://flox.dev/docs)** - Understand the dev environment
- **[Just Manual](https://github.com/casey/just)** - Master the command runner
- **[CLAUDE.md](CLAUDE.md)** - Detailed project documentation

## 💬 Need Help?

- 📧 Email: [planetnix@flox.dev](mailto:planetnix@flox.dev)
- 🐛 Issues: [GitHub Issues](https://github.com/planetnix/website/issues)
- 💬 Questions: [GitHub Discussions](https://github.com/planetnix/website/discussions)

## 📄 License

This project is open source. Feel free to use it, learn from it, and contribute to it!

---

<div align="center">

**Built with ❤️ by the Nix community**

[View Website](https://planetnix.com) • [Report Bug](https://github.com/planetnix/website/issues) • [Contribute](https://github.com/planetnix/website/blob/main/README.md#-contributing)

</div>
