#!/bin/bash

git submodule init
git submodule update
pod install

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Place 'GoogleService-Info.plist' in the project root directory.${NC}"
