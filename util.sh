#!/bin/bash

# Check if ACCESS_TOKEN is set
check_access_token_from_env() {
  if [ -z "$ACCESS_TOKEN" ]; then
    echo "ACCESS_TOKEN is not set. Please obtain it first and set it in .env"
    exit 1
  fi
}

source_github_file() {
  local url="$1"

  if [[ -z "$url" ]]; then
    echo "Usage: source_github_file <url>"
    return 1
  fi

  # Create a temporary file
  local temp_file=$(mktemp)

  # Download the script to the temporary file
  if ! curl -s -o "$temp_file" "$url"; then
    echo "Failed to download the script from $url"
    return 1
  fi

  # Source the downloaded script
  source "$temp_file"

  # Clean up the temporary file
  rm "$temp_file"
}

check_dir_exists() {
  local dir=$1
  if [ ! -d "$dir" ]; then
    log_warning "Missing directory $dir."
    mkdir -p "$dir"
    if [ $? -eq 0 ]; then
      log_info "$dir created successfully."
    else
      log_warning "Failed to create directory $dir."
      return 1
    fi
  fi
}

save_report() {
  local status=$1
  local file=$2
  local success_func=$3
  local error_func=$4
  if [ "$status" -eq 0 ]; then
    $success_func >>$file
    log_info "Report saved successfully. $file"
    return 0
  else
    $error_func >>$file
    log_error "Report saved successfully. $file"
    return 1
  fi
}

# Function to check if the script is running locally
is_local_server() {
  HOSTNAME=$(hostname)
  if [ "$HOSTNAME" == "jin.local" ]; then
    return 0
  else
    return 1
  fi
}

delete_logs() {
  rm -r ./logs
  log_success "Delete logs directory"
}

# Function to check robots.txt
check_robots_txt() {
  ROBOTS_URL="https://www.linkedin.com/robots.txt"
  ROBOTS_CONTENT=$(curl -s "$ROBOTS_URL")

  # Check if the user-agent is disallowed
  if echo "$ROBOTS_CONTENT" | grep -q "Disallow: /"; then
    log_warning "Scraping is disallowed by robots.txt"
    return 1
  fi
}

# Clean up function
cleanup() {
  rm -f $COOKIE_JAR
  echo "Cookie Jar Cleaned"
}

convert_array_to_string() {
  local array=("$@") # Correctly capture all arguments as an array
  IFS=,              # Set the Internal Field Separator to comma
  echo "${array[*]}" # Join the array elements with a comma
}
