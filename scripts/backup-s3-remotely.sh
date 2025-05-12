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

# Create directory for artists within today's date directory
create_directory "$today/artists"

# Iterate over artist paths 20 times
for ((i = 1; i <= 72; i++)); do
    download_file "https://*.cloudfront.net/artists/$i-original.png" "artists"
    download_file "https://*.cloudfront.net/artists/$i-preview.png" "artists"
done

# Iterate over paths X times
for ((i = 1; i <= 1300; i++)); do
    download_file "https://*.cloudfront.net/$i-border.png"
    download_file "https://*.cloudfront.net/$i-no-border.png"
    download_file "https://*.cloudfront.net/$i-animation.gif"
    download_file "https://*.cloudfront.net/$i-preview.png"
    download_file "https://*.cloudfront.net/$i-video.mp4"
done
