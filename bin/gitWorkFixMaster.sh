#!/bin/bash
repository=~/ghe.fork/KC2.0/

#colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green

#Emoji
CocktailGlass="\xF0\x9F\x8D\xB8"
WineGlass="\xF0\x9F\x8D\xB7"
WhiteOkHand="\xf0\x9f\x91\x8c\xf0\x9f\x8f\xbb"
PoutingFace="\xF0\x9F\x98\xA1"

#Function
function execute(){
    if eval "$1"; then
        echo -e "$WhiteOkHand"
    else
        echo -e "$PoutingFace"
        exit 1
    fi
}

branch="master"
cd $repository

echo -e "$CocktailGlass Starting ${BWhite}fixing${NC} '${BRed}$branch${NC}' branch..."

echo -e "\n> ${BWhite}Renaming${NC} '${BRed}$branch${NC}' branch"
execute "git branch -m $branch $branch-old"
echo -e "\n> ${BWhite}Fetching${NC} '${BRed}upstream${NC}'"
execute "git fetch upstream"
echo -e "\n> ${BWhite}Checking out${NC} '${BRed}$branch${NC}' from '${BRed}upstream${NC}'"
execute "git checkout -b $branch upstream/$branch"
echo -e "\n> ${BWhite}Force push${NC} '${BRed}$branch${NC}' to '${BRed}origin/$branch${NC}'"
execute "git push -f origin $branch"
echo -e "\n> ${BWhite}Deleting${NC} '${BRed}$branch-old${NC}' branch"
execute "git branch -D $branch-old"

echo -e "\n$WineGlass Finished ${BWhite}fixing${NC} '${BRed}$branch${NC}' branch..."
