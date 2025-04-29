#!/bin/bash

THEME_DIR="./"
ROFI_THEME_DIR="$HOME/.config/rofi/themes"
CONFIG_FILE="$HOME/.config/rofi/config.rasi"

mkdir -p "$ROFI_THEME_DIR"

THEME_FILES=($(find "$THEME_DIR" -maxdepth 1 -type f -name "*.rasi"))

if [ ${#THEME_FILES[@]} -eq 0 ]; then
  echo "No .rasi theme files found in $THEME_DIR"
  exit 1
fi

echo "Available themes:"
for i in "${!THEME_FILES[@]}"; do
  echo "$((i+1)). $(basename "${THEME_FILES[$i]}")"
done

read -p "Choose a theme number: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#THEME_FILES[@]} ]; then
  echo "Invalid choice"
  exit 1
fi

SELECTED="${THEME_FILES[$((choice - 1))]}"
BASENAME=$(basename "$SELECTED")

cp "$SELECTED" "$ROFI_THEME_DIR/$BASENAME"

echo "@theme \"./themes/$BASENAME\"" > "$CONFIG_FILE"

echo "Theme set to ./$(basename "$SELECTED") in $CONFIG_FILE"
