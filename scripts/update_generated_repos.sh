#!/usr/bin/env bash

# Config for auto-building
git remote rename origin upstream
git config --global user.email "bot@pixhawk.org"
git config --global user.name "PX4BuildBot"
git config --global credential.helper "store --file=$HOME/.git-credentials"
echo "https://${GH_TOKEN}:@github.com" > "$HOME"/.git-credentials

GEN_START_PATH=$PWD

# Set supported languages
declare -a supported_langs=("c" "cpp" "java")

# Build libraries for the supported languages
mkdir -p include/mavlink/v2.0

for lang in "${supported_langs[@]}"
do
   git clone https://github.com/Dronecode/air-iop-${lang}_library_v2.git include/mavlink/v2.0/air-iop-${lang}_library_v2
   ./scripts/update_library.sh 2 ${lang}
done

# v1.0 legacy (C lib)
# cd "$GEN_START_PATH"
# mkdir -p include/mavlink/v1.0
# cd include/mavlink/v1.0
# git clone https://github.com/mavlink/c_library_v1.git
# cd ../../..
# ./scripts/update_library.sh 1
