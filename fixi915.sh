#!/bin/bash

# Source: https://francoconidi.it/fix-error-possible-missing/
# Source: https://syslinuxos.com

# Install curl, wget, lynx

sudo apt update; sudo apt install -y wget curl lynx

# folder creation
mkdir /home/$USER/i915; cd /home/$USER/i915

# Download the web page and use lynx to extract the HTTP/HTTPS links

lynx -dump "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/i915/" | grep -o 'https\?://[^ ]*\.bin' > /home/$USER/i915/links.txt

# Download the .bin files from the list of links
while read -r line
do
  # Extract the filename from the link
  filename=$(basename "$line")

  # Download the file from the link using curl
  curl -OJL "$line"

  # Rename the downloaded file to its original name
  mv "$filename" "${filename%.*}.bin"
done < "links.txt"

# Two folders to compare
folder1="/home/$USER/i915"
folder2="/lib/firmware/i915/"

# Check folders
if [ ! -d "$folder1" ]; then
  echo "Error: First folder does not exist."
  exit 1
fi

if [ ! -d "$folder2" ]; then
  echo "Error: Second folder does not exist."
  exit 1
fi

# Cycle through the files in the first folder
for file1 in "$folder1"/*.bin; do
  # Extract the filename without the path
  filename="$(basename "$file1")"
  # Check if the file exists in the second folder
  if [ ! -f "$folder2/$filename" ]; then
    # Copy the missing file into the second folder
    sudo cp "$file1" "$folder2"
    echo "The file $filename has been copied to the second folder."
  fi
done

echo "The check has been completed."

# Update initramfs
sudo update-initramfs -u

echo "Fix missing firmware has been completed."

