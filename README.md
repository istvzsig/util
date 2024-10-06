# Bash Utility Script

## Overview

This Bash utility script provides a collection of functions to facilitate various tasks, including downloading scripts from GitHub, checking environment variables, managing directories, and handling logs. It is designed to be easily sourced into your shell environment.

## Features

- **Check Access Token**: Verifies if the `ACCESS_TOKEN` environment variable is set.
- **Source GitHub File**: Downloads and sources a script from a given GitHub URL.
- **Check Directory Exists**: Checks if a specified directory exists and creates it if it doesn't.
- **Save Report**: Saves a report based on the success or failure of a command.
- **Check Local Server**: Determines if the script is running on a local server.
- **Delete Logs**: Deletes the logs directory.
- **Check robots.txt**: Checks if scraping is allowed based on the `robots.txt` file.
- **Cleanup**: Cleans up temporary files, such as cookie jars.
- **Convert Array to String**: Converts an array of arguments into a comma-separated string.

## Installation

To use this script, you can download it directly or clone the repository.

### Clone the Repository

```bash
git clone https://github.com/istvzsig/util.git
cd util
```

### Download the Script

Alternatively, you can download the script directly:

```bash
curl -s -o /tmp/util.sh "https://raw.githubusercontent.com/istvzsig/util/master/util.sh"
. /tmp/util.sh
```

## Usage

To use the utility script, source it in your terminal:

```bash
source /tmp/util.sh
```

### Example Usage

1. **Check Access Token**:

   ```bash
   check_access_token_from_env
   ```

2. **Source a GitHub File**:

   ```bash
   source_github_file "https://raw.githubusercontent.com/istvzsig/util/master/another_script.sh"
   ```

3. **Check and Create Directory**:

   ```bash
   check_dir_exists "/path/to/directory"
   ```

4. **Save a Report**:

   ```bash
   save_report $? "report.txt" "echo 'Success'" "echo 'Error'"
   ```

5. **Check if Running on Local Server**:

   ```bash
   if is_local_server; then
       echo "Running on local server."
   else
       echo "Not running on local server."
   fi
   ```

6. **Delete Logs**:

   ```bash
   delete_logs
   ```

7. **Check robots.txt**:

   ```bash
   check_robots_txt
   ```

8. **Cleanup**:

   ```bash
   cleanup
   ```

9. **Convert Array to String**:

   ```bash
   my_array=("item1" "item2" "item3")
   result=$(convert_array_to_string "${my_array[@]}")
   echo "$result"  # Output: item1,item2,item3
   ```

## Requirements

- Bash shell
- `curl` command-line tool

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
Feel free to adjust any URLs, function names, or descriptions to better match your specific implementation and needs!
```
