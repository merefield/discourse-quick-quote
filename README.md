# Quick Quote

Quick Quote is a Discourse theme component that automatically quotes older posts when a user clicks the post reply button. Recent posts still open a normal reply without a quote.

## Functionality

- Automatically quotes posts older than a configurable number of recent posts.
- Leaves recent post replies unquoted.
- Optionally removes nested quotes and links from automatic quotes.
- Optionally combines quoted paragraphs into a continuous block.
- Optionally keeps only the final characters of long quotes.
- Preserves Discourse's standard manually selected quote behavior.

Each behavior is configurable in the theme component settings.

## Compatibility

Discourse's official nested replies format is not yet supported. Quick Quote currently applies only to the standard topic view.

For installation and usage details, see the [Quick Quote topic on Discourse Meta](https://meta.discourse.org/t/quick-quote-theme-component/143621).

## Development

Use Node.js 22 or newer and pnpm 10:

```sh
pnpm install
pnpm lint
```

To run the browser-backed tests, clone this repository under a Discourse checkout's `tmp/themes` directory, then run:

```sh
bin/rspec tmp/themes/discourse-quick-quote/spec/system
```
