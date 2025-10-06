# Google Tag Manager Setup

This site includes Google Tag Manager (GTM) integration that can be activated by setting an environment variable.

## How to enable Google Tag Manager

### For local development:

Set the `GTM_CONTAINER_ID` environment variable before building the site:

```bash
export GTM_CONTAINER_ID="GTM-XXXXXXX"
bundle exec jekyll build
```

Or run it inline:

```bash
GTM_CONTAINER_ID="GTM-XXXXXXX" bundle exec jekyll serve
```

### For GitHub Pages deployment:

**Important:** GitHub Pages' built-in Jekyll build runs in safe mode and does not execute custom plugins. To use GTM with this site, you must use GitHub Actions to build and deploy.

1. Go to your repository settings
2. Navigate to "Settings" → "Pages"
3. Under "Build and deployment" → "Source", select "GitHub Actions"
4. Navigate to "Secrets and variables" → "Actions"
5. Create a new repository secret named `GTM_CONTAINER_ID`
6. Set its value to your Google Tag Manager container ID (e.g., `GTM-XXXXXXX`)
7. The provided `.github/workflows/jekyll.yml` workflow will automatically build and deploy your site with the GTM code

## How it works

- The `_plugins/environment_variables.rb` plugin reads the `GTM_CONTAINER_ID` from the environment and stores it in `site.config['env']['GTM_CONTAINER_ID']`
- In Liquid templates, this is accessed via `site.env.GTM_CONTAINER_ID` (Jekyll's Drop system provides access to `site.config['env']` through `site.env`)
- The analytics code is included only when the ID is set and contains "GTM-"
- The GTM script is added to the `<head>` section via `_includes/head-custom.html`
- The GTM noscript fallback is added to the `<body>` section via `_layouts/default.html`
- **Note:** Custom Jekyll plugins only work when building with GitHub Actions, not with GitHub Pages' built-in Jekyll builder

## Files involved

- `.github/workflows/jekyll.yml` - GitHub Actions workflow that builds and deploys with environment variables
- `_plugins/environment_variables.rb` - Reads environment variables and makes them available in templates
- `_includes/analytics.head.html` - GTM script for the head section
- `_includes/analytics.body.html` - GTM noscript fallback for the body section
- `_includes/head-custom.html` - Includes the head analytics
- `_layouts/default.html` - Overrides theme layout to include body analytics
