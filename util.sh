#!/bin/bash

# Function to check if the ACCESS_TOKEN environment variable is set
check_access_token_from_env() {
  # Check if ACCESS_TOKEN is empty
  if [ -z "$ACCESS_TOKEN" ]; then
    echo "ACCESS_TOKEN is not set. Please obtain it first and set it in .env"
    exit 1 # Exit the script with an error code if ACCESS_TOKEN is not set
  fi
}

# Function to download and source a script from a given GitHub URL
source_github_file() {
  local url="$1" # Store the first argument as the URL

  # Check if the URL is provided
  if [[ -z "$url" ]]; then
    echo "Usage: source_github_file <url>"
    return 1 # Return an error if no URL is provided
  fi

  # Create a temporary file to store the downloaded script
  local temp_file=$(mktemp)

  # Download the script to the temporary file
  if ! curl -s -o "$temp_file" "$url"; then
    echo "Failed to download the script from $url"
    return 1 # Return an error if the download fails
  fi

  # Source the downloaded script to execute it in the current shell
  source "$temp_file"

  # Clean up the temporary file after sourcing
  rm "$temp_file"
}

# Function to create a directory if it does not already exist
create_dir_if_not_exists() {
  local dir=$1 # Store the first argument as the directory name
  # Check if the directory does not exist
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir" # Create the directory and any necessary parent directories
    if [ $? -eq 0 ]; then
      # Directory created successfully
      return 0
    else
      return 1 # Return an error if the directory creation fails
    fi
  fi
}

# Function to save a report based on the status of a command
save_report() {
  local status=$1       # Store the first argument as the command status
  local file=$2         # Store the second argument as the report file name
  local success_func=$3 # Store the third argument as the success function
  local error_func=$4   # Store the fourth argument as the error function

  # Check if the command was successful
  if [ "$status" -eq 0 ]; then
    $success_func >>$file # Execute the success function and append output to the file
    return 0
  else
    $error_func >>$file # Execute the error function and append output to the file
    return 1
  fi
}

# Function to check if the script is running on a local server
is_local_server() {
  HOSTNAME=$(hostname) # Get the hostname of the current machine
  # Check if the hostname matches the local server name
  if [ "$HOSTNAME" == "jin.local" ]; then
    return 0 # Return success if running on the local server
  else
    return 1 # Return failure if not running on the local server
  fi
}

# Function to delete a directory if it exists
delete_dir_if_exists() {
  local dir=$1 # Store the first argument as the directory name
  rm -r $dir   # Remove the directory and its contents recursively
}

# Function to check the robots.txt file for disallowed user-agents
check_robots_txt() {
  ROBOTS_URL="https://www.linkedin.com/robots.txt" # URL of the robots.txt file
  ROBOTS_CONTENT=$(curl -s "$ROBOTS_URL")          # Fetch the content of robots.txt

  # Check if the user-agent is disallowed
  if echo "$ROBOTS_CONTENT" | grep -q "Disallow: /"; then
    return 1 # Return failure if disallowed
  fi
}

# Clean up function to remove the cookie jar file
cleanup_cookie_jar() {
  rm -f $COOKIE_JAR         # Remove the cookie jar file if it exists
  echo "Cookie Jar Cleaned" # Print a message indicating cleanup is complete
}

# Function to convert an array of arguments into a comma-separated string
convert_array_to_string() {
  local array=("$@") # Correctly capture all arguments as an array
  IFS=,              # Set the Internal Field Separator to comma
  echo "${array[*]}" # Join the array elements with a comma and print
}

# Higher order function to avoid echo to console
hoc_mute_func() {
  local wrapped_func=$1
  shift
  $wrapper_func $@ >/dev/null
}
