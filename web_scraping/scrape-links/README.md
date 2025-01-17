# Link Scraper

This is a simple recursive link scraper written in Ruby. It starts from a given URL and scrapes links up to a specified depth or time limit. The scraped links are saved to a file named `scraped_links.txt`.

## Features

- Recursively scrapes links from a starting URL
- Configurable depth and time limit for scraping
- Stores scraped links in a text file

## Requirements

- Ruby
- Bundler

## Prerequisites

Ensure you have the following gems installed:

- `nokogiri`
- `optparse`

You can install them by running:

```sh
bundle install
```

## Usage

Run the scraper with the following command:

```sh
ruby scrape_links.rb -u <START_URL> -d <DEPTH> -t <TIME_LIMIT>
```

### Options

- `-u`, `--url URL`: Starting URL to scrape (default: `https://example.com`)
- `-d`, `--depth DEPTH`: Maximum depth to scrape (default: 3)
- `-t`, `--time TIME`: Maximum time in seconds to scrape (default: no limit)

### Example

```sh
ruby scrape_links.rb -u https://example.com -d 2 -t 60
```

This command will start scraping from `https://example.com`, with a maximum depth of 2 and a time limit of 60 seconds.

## Output

The scraped links will be saved in a file named `scraped_links.txt` in the current directory.

## License

This project is licensed under the MIT License.
