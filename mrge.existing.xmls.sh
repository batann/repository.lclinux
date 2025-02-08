#!/bin/bash

REPO_DIR=$(dirname "$(realpath "$0")")
OUTPUT_XML="$REPO_DIR/addons.xml"
OUTPUT_MD5="$REPO_DIR/addons.xml.md5"

echo "Generating addons.xml..."

# Start the XML file
echo "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" > "$OUTPUT_XML"
echo "<addons>" >> "$OUTPUT_XML"

# Loop through all addon.xml files in zips/*/ directories
for addon in "$REPO_DIR"/zips/*/; do
    ADDON_XML="${addon}addon.xml"
    if [ -f "$ADDON_XML" ]; then
        # Append the content of addon.xml excluding the first XML declaration
        sed '1d' "$ADDON_XML" >> "$OUTPUT_XML"
        echo "" >> "$OUTPUT_XML" # Add a newline for readability
    fi
done

# Close the XML file
echo "</addons>" >> "$OUTPUT_XML"

# Generate MD5 checksum
md5sum "$OUTPUT_XML" | awk '{ print $1 }' > "$OUTPUT_MD5"

echo "Done! addons.xml and addons.xml.md5 have been generated."
