# Run Command on File Change

This script allows you to run an initial command and then execute a different command whenever a file change is detected in a specified directory.

## Requirements

- Ruby
- Bundler

## Prerequisites

Ensure you have the following gems installed:

- `listen`
- `logger`
- `optparse`

You can install them by running:

```sh
bundle install
```

## Usage

```sh
./run_command_on_file_change -i INITIAL_COMMAND -c CHANGE_COMMAND -d DIRECTORY
```

### Options

- `-i`, `--initial`: The initial command to run.
- `-c`, `--change`: The command to run on file change.
- `-d`, `--directory`: The directory to watch for changes.
- `-v`, `--verbose`: Enable verbose output.

### Example

```sh
./run_command_on_file_change -i "echo Initial Command" -c "echo File Changed" -d /path/to/directory
```

In this example:

- The script will first run `echo Initial Command`.
- It will then watch the specified directory for any file changes.
- Upon detecting a file change, it will run `echo File Changed`.

## How It Works

1. The script parses the command-line options to get the initial command, change command, and directory to watch.
2. It runs the initial command.
3. It sets up a listener on the specified directory.
4. When a file change is detected, it runs the change command.

## License

This project is licensed under the MIT License.
