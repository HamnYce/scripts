# Run Command on File Change

This script monitors file changes in the current directory and runs a specified command whenever a file is modified.

## Dependencies

Ensure you have the following gems installed:

- `listen`
- `logger`

You can install them by running:

```sh
bundle install
```

## Usage

To use the script, run the following command:

```sh
ruby middleman.rb "your_command"
```

Replace `"your_command"` with the command you want to execute when a file changes. For example:

```sh
ruby middleman.rb "flutter run"
```

or

```sh
ruby middleman.rb "ls"
```

## Example

```sh
ruby middleman.rb "echo File changed"
```

This will print "File changed" to the console whenever a file in the current directory is modified.

## Notes

- Ensure you have the necessary permissions to execute the specified command.
- The script will continue to run and monitor file changes until you manually stop it.
