require "nokogiri"
require "open-uri"
require "optparse"
require "set"
require "time"
require "fileutils"

class LinkScraper
  def initialize(start_url, depth: 3, time_limit: nil)
    @start_url = start_url
    @depth = depth
    @time_limit = time_limit
    @visited = Set.new
    @start_time = Time.now
    @output_file = File.join(Dir.pwd, "scraped_links.txt")

    # Ensure the file exists and is empty before starting
    FileUtils.touch(@output_file)
    File.open(@output_file, "w") { |file| file.puts "Scraped Links (from #{@start_url})\n\n" }
  end

  def scrape
    scrape_links(@start_url, 0)
  end

  private

  def scrape_links(url, current_depth)
    # Stop recursion if the depth exceeds or the time limit is reached
    if current_depth >= @depth || time_expired?
      return
    end

    return if @visited.include?(url)

    @visited.add(url)
    puts "Scraping URL: #{url}"

    begin
      page = Nokogiri::HTML(URI.open(url))
      links = page.css("a").map { |link| link["href"] }.compact

      links.each do |link|
        full_url = resolve_url(url, link)
        next if @visited.include?(full_url)

        # Store the URL in the output file
        store_link(full_url)

        # Recursively scrape links
        scrape_links(full_url, current_depth + 1)
      end
    rescue StandardError => e
      puts "Error fetching #{url}: #{e.message}"
    end
  end

  def resolve_url(base_url, relative_url)
    URI.join(base_url, relative_url).to_s
  end

  def store_link(url)
    File.open(@output_file, "a") do |file|
      file.puts url
    end
  end

  def time_expired?
    return false unless @time_limit

    elapsed_time = Time.now - @start_time
    elapsed_time >= @time_limit
  end
end

# Command-line options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: link_scraper.rb [options]"

  opts.on("-u", "--url URL", "Starting URL to scrape") do |url|
    options[:url] = url
  end

  opts.on("-d", "--depth DEPTH", Integer, "Max depth to scrape") do |depth|
    options[:depth] = depth
  end

  opts.on("-t", "--time TIME", Integer, "Max time in seconds to scrape") do |time|
    options[:time] = time
  end
end.parse!

# Default options if not provided
start_url = options[:url] || "https://example.com"
depth = options[:depth] || 3
time_limit = options[:time] || nil

# Run the scraper
scraper = LinkScraper.new(start_url, depth: depth, time_limit: time_limit)
scraper.scrape

puts "Scraping complete. Links saved to 'scraped_links.txt'."
