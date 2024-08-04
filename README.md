# thank_you_token

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## GitHub Workflow for Flutter Web Deployment

This repository includes a GitHub workflow that builds the Flutter web app with every push to the main branch and pushes this build to a `gh-pages` branch for hosting on GitHub Pages.

### Workflow File

The workflow file is located at `.github/workflows/flutter-web-deploy.yml`.

### Workflow Steps

1. **Trigger**: The workflow is triggered on every push to the `main` branch.
2. **Setup Flutter**: The workflow sets up Flutter on the runner.
3. **Install Dependencies**: The workflow installs the necessary dependencies.
4. **Build Web App**: The workflow builds the Flutter web app.
5. **Deploy to GitHub Pages**: The workflow deploys the built web app to the `gh-pages` branch.

### GitHub Pages Configuration

The `gh-pages` branch is configured to be used with GitHub Pages for hosting the Flutter web app. Ensure that the GitHub Pages settings in the repository are set to use the `gh-pages` branch as the source.
