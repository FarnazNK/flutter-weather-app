# GitHub Repository Setup Guide

This guide will help you set up your Flutter Weather App repository on GitHub to showcase your skills.

## Initial Setup

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com)
2. Click "New repository"
3. Repository name: `flutter-weather-app`
4. Description: "Production-ready Flutter weather app with Clean Architecture, BLoC, and CI/CD"
5. Choose Public
6. Don't initialize with README (we already have one)
7. Click "Create repository"

### 2. Initialize Local Repository

```bash
cd flutter_weather_app

# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Production-ready Flutter Weather App with Clean Architecture"

# Add remote
git remote add origin https://github.com/YOUR_USERNAME/flutter-weather-app.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Repository Configuration

### 1. Add Topics

Go to repository settings and add topics:
- `flutter`
- `dart`
- `clean-architecture`
- `bloc-pattern`
- `weather-app`
- `ci-cd`
- `github-actions`
- `mobile-development`
- `android`
- `ios`
- `dependency-injection`
- `testing`

### 2. Configure Repository

#### About Section
```
🌤️ Production-ready Flutter weather app showcasing Clean Architecture, 
BLoC pattern, comprehensive testing, and CI/CD best practices.
```

#### Website
Add demo link if deployed (e.g., GitHub Pages URL)

#### Enable Features
- ✅ Issues
- ✅ Projects (optional)
- ✅ Wiki (optional)
- ✅ Discussions (optional)

### 3. Create Branch Protection Rules

1. Go to Settings → Branches
2. Add rule for `main` branch:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Include administrators

### 4. Enable GitHub Actions

1. Go to Actions tab
2. Enable workflows
3. First push will trigger CI/CD

## Secrets Configuration

### For CI/CD

1. Go to Settings → Secrets and variables → Actions
2. Add the following secrets:

#### Optional Secrets (for automated deployment)
- `CODECOV_TOKEN` - For code coverage reporting
- `GOOGLE_SERVICES_JSON` - For Android (base64 encoded)
- `APPLE_CERTIFICATE` - For iOS signing
- `PROVISIONING_PROFILE` - For iOS

## Repository Structure

```
flutter-weather-app/
├── .github/
│   └── workflows/
│       └── ci-cd.yml           # Main CI/CD workflow
├── docs/
│   ├── QUICK_START.md
│   ├── ARCHITECTURE.md
│   └── DEPLOYMENT.md
├── lib/                        # Application source code
├── test/                       # Tests
├── scripts/                    # Development scripts
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## README Badges

Update your README with these badges:

```markdown
[![Flutter CI/CD](https://github.com/YOUR_USERNAME/flutter-weather-app/workflows/Flutter%20CI/CD/badge.svg)](https://github.com/YOUR_USERNAME/flutter-weather-app/actions)
[![codecov](https://codecov.io/gh/YOUR_USERNAME/flutter-weather-app/branch/main/graph/badge.svg)](https://codecov.io/gh/YOUR_USERNAME/flutter-weather-app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev/)
```

## Issue Templates

Create `.github/ISSUE_TEMPLATE/`:

### Bug Report
```markdown
---
name: Bug Report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

**Describe the bug**
A clear description of the bug.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
 - Device: [e.g. iPhone 12]
 - OS: [e.g. iOS 15.0]
 - App Version: [e.g. 1.0.0]

**Additional context**
Any other context about the problem.
```

### Feature Request
```markdown
---
name: Feature Request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

**Is your feature request related to a problem?**
A clear description of the problem.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Alternative solutions or features you've considered.

**Additional context**
Any other context or screenshots.
```

## Pull Request Template

Create `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description
Brief description of changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## How Has This Been Tested?
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests
- [ ] Manual testing

## Checklist:
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where needed
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix/feature works
- [ ] New and existing tests pass locally
- [ ] Any dependent changes have been merged

## Screenshots (if applicable):

## Additional Notes:
```

## GitHub Pages Setup (Optional)

To deploy your app's web version:

1. Build web version:
```bash
flutter build web --base-href "/flutter-weather-app/"
```

2. Go to Settings → Pages
3. Source: Deploy from a branch
4. Branch: `gh-pages`
5. Or use GitHub Actions workflow

## Best Practices for Commits

### Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tooling changes

### Examples
```bash
feat(weather): add 5-day forecast feature

- Implement forecast API integration
- Create forecast display widget
- Add forecast bloc and states

Closes #15

fix(location): fix permission request on iOS

- Update Info.plist with permission descriptions
- Add proper permission handling

Fixes #23
```

## Repository Maintenance

### Regular Tasks

1. **Update Dependencies**
```bash
flutter pub upgrade
git commit -am "chore: update dependencies"
```

2. **Review Issues** - Weekly
3. **Merge PRs** - Within 48 hours
4. **Update Documentation** - As needed
5. **Create Releases** - For major updates

### Release Process

```bash
# Update version in pubspec.yaml
# Update CHANGELOG.md

git add .
git commit -m "chore: bump version to 1.1.0"
git tag -a v1.1.0 -m "Release version 1.1.0"
git push origin main
git push origin v1.1.0
```

## Portfolio Optimization

### Showcase Your Skills

1. **Pin Repository** on your GitHub profile
2. **Add to Portfolio** website/resume
3. **Write Blog Post** about your implementation
4. **Create Demo Video** and add to README
5. **LinkedIn Post** highlighting the project

### README Highlights

Make sure your README includes:
- ✅ Clear project description
- ✅ Technology stack
- ✅ Architecture diagram
- ✅ Setup instructions
- ✅ Screenshots/GIFs
- ✅ Live demo link
- ✅ Your contact information

## Metrics to Track

Enable Insights tab to track:
- Stars ⭐
- Forks 🍴
- Contributors 👥
- Traffic 📈
- Issues/PRs 🎯

## Community Engagement

- Respond to issues promptly
- Welcome new contributors
- Acknowledge contributions
- Keep discussions professional
- Update project regularly

## Resources

- [GitHub Docs](https://docs.github.com)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)

---

**Good luck showcasing your skills! 🚀**
