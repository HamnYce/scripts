require "listen"
require "optparse"

# Parse command-line options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"

  opts.on("-i", "--initial COMMAND", "Initial command to run") do |initial_command|
    options[:initial_command] = initial_command
  end

  opts.on("-c", "--change COMMAND", "Command to run on file change") do |change_command|
    options[:change_command] = change_command
  end

  opts.on("-d", "--directory DIR", "Directory to watch for changes") do |directory|
    options[:directory] = directory
  end

  opts.on("-v", "--verbose", "Enable verbose output") do
    options[:verbose] = true
  end
end.parse!

# Check if all required options are provided
if options[:initial_command].nil? || options[:change_command].nil? || options[:directory].nil?
  puts "Missing required options. Usage: #{$0} -i INITIAL_COMMAND -c CHANGE_COMMAND -d DIRECTORY"
  exit 1
end

# Run the initial command
def run_command(command, verbose)
  puts "Running command: #{command}" if verbose
  system(command)
end

# Run the initial command
run_command(options[:initial_command], options[:verbose])

# Setup listener for file changes
listener = Listen.to(options[:directory]) do |modified, added, removed|
  unless modified.empty? && added.empty? && removed.empty?
    puts "Detected file changes:" if options[:verbose]
    puts "Modified: #{modified}" if options[:verbose]
    puts "Added: #{added}" if options[:verbose]
    puts "Removed: #{removed}" if options[:verbose]
    run_command(options[:change_command], options[:verbose])
  end
end

# Start the listener
puts "Watching directory: #{options[:directory]}" if options[:verbose]
listener.start

# Keep the script running
sleep
