#!/bin/bash

# Function to create directories if they don't exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Get today's date in YYYY-MM-DD format
today=$(date +"%Y-%m-%d")

# Create directory for today's date
create_directory "$today"

# Function to download file from S3
download_file() {
    local url=$1
    local download_type=$2
    local filename=$(basename "$url")
    local path

    if [ "$download_type" = "artists" ]; then
        path="$today/artists/$filename"
    else
        path="$today/$filename"
    fi

    create_directory "$(dirname "$path")"

    # Check if file exists, if not, download it
    if [ ! -f "$path" ]; then
        echo "Downloading: $url"
        response=$(curl -s -o "$path" -w "%{http_code}" "$url")
        if [ "$response" != "200" ]; then
            echo "Error: Failed to download $url. Status code: $response"
            rm "$path"  # Remove the partially downloaded file
        else
            echo "Successfully downloaded: $url"
        fi
    fi
}

# List of numbers
numbers=(
    1 2 3 4 5 6 7 8 9 10
    11 12 13 14 15 16 17 18 19 20
    # Add more numbers as needed
    # ...
    # Example: 21 22 ... up to the desired number
)

echo "Downloading files..."

# Iterate over the array and download each file
for i in "${numbers[@]}"; do
    download_file "https://*.cloudfront.net/$i.png"
done
