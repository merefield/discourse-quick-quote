|                      |                     |                                                                                                                                                                                                                                                                                                      |
| -------------------- | ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| :information_source: | **Summary**         | A Discourse theme component that automatically adds concise quotes when replying to older posts                                                                                                                                                                                                      |
| :hammer_and_wrench:  | **Repository Link** | <https://github.com/merefield/discourse-quick-quote>                                                                                                                                                                                                                                                 |
| :open_book:          | **Install Guide**   | [How to install themes and theme components in Discourse](https://meta.discourse.org/t/how-do-i-install-a-theme-or-theme-component/63682)                                                                                                                                                            |
| :heart:              | **Sponsorship**     | Please consider becoming an ongoing [sponsor of my open source work](https://github.com/sponsors/merefield) at a level that suits your or your organisation's resources and needs to ensure this theme component gets the maintenance it deserves and continues to work for your site in the future. |

Enjoying this theme component? Please :star: it on [GitHub](https://github.com/merefield/discourse-quick-quote)! :pray:

### Features

Quick Quote adds context to replies in Discourse's standard topic view without requiring people to select text manually:

- Automatically quotes a post when it is older than a configurable number of recent posts.
- Opens a normal unquoted reply for recent posts.
- Preserves manually selected quotes instead of replacing them with an automatic quote.
- Can remove nested quotes from the generated quote.
- Can remove links and linked images from the generated quote.
- Can combine separate paragraphs into a continuous quoted block.
- Can limit long quotes by retaining their final characters.

### Settings

The theme component provides five settings:

- `quick_quote_post_location_threshold` controls how many recent posts do not receive an automatic quote.
- `quick_quote_remove_links` removes links and linked images from automatic quotes.
- `quick_quote_remove_prior_quotes` removes nested quotes from automatic quotes.
- `quick_quote_remove_contiguous_new_lines` combines paragraphs in automatic quotes into a continuous block.
- `quick_quote_character_limit` sets the maximum automatic quote length and retains the final characters when that limit is exceeded.

### Compatibility

Discourse's official nested replies format is not yet supported. Quick Quote currently applies only to the standard topic view.
