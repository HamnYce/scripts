require 'open3'
require 'listen'

def communicate_with_process(command)
  Open3.popen2e(command) do |stdin, stdout_err, wait_thr|
    # Send input to the process
    input_thread = Thread.new do
      while (input = gets.chomp)
        stdin.puts(input)
      end
    end

    # Receive output from the process
    output_thread = Thread.new do
      while (output = stdout_err.gets)
        puts output
      end
    end

    # Monitor file modifications in the current directory
    listener = Listen.to(Dir.pwd) do |modified, _added, _removed|
      modified.each do |file|
        puts "File modified: #{file}"
        stdin.puts('r')
      end
    end

    # Start the file monitoring listener
    listener.start

    # Wait for the process to finish
    exit_status = wait_thr.value

    # Stop the file monitoring listener
    listener.stop

    # Join the input and output threads
    input_thread.join
    output_thread.join

    exit_status
  end
end

# Replace "your_process_command" with the command to run your desired process
communicate_with_process('your_process_command')
