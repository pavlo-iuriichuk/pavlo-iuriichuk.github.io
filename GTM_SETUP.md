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

1. Go to your repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Create a new repository secret named `GTM_CONTAINER_ID`
4. Set its value to your Google Tag Manager container ID (e.g., `GTM-XXXXXXX`)

### For GitHub Actions workflows:

Add the environment variable to your Jekyll build workflow:

```yaml
- name: Build with Jekyll
  env:
    GTM_CONTAINER_ID: ${{ secrets.GTM_CONTAINER_ID }}
  run: bundle exec jekyll build
```

## How it works

- The `_plugins/environment_variables.rb` plugin reads the `GTM_CONTAINER_ID` from the environment
- The analytics code is included only when the ID is set and contains "GTM-"
- The GTM script is added to the `<head>` section via `_includes/head-custom.html`
- The GTM noscript fallback is added to the `<body>` section via `_layouts/default.html`

## Files involved

- `_plugins/environment_variables.rb` - Reads environment variables
- `_includes/analytics.head.html` - GTM script for the head section
- `_includes/analytics.body.html` - GTM noscript fallback for the body section
- `_includes/head-custom.html` - Includes the head analytics
- `_layouts/default.html` - Overrides theme layout to include body analytics
