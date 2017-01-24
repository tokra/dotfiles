#!/bin/bash
repository=~/ghe.fork/KC2.0/

#colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green

echo -e "Starting ${BWhite}synchronizing${NC} '${BRed}master${NC}' & '${BRed}dev${NC}' with ${BWhite}upstream KC2.0${NC}..."
cd $repository
git fetch upstream

#master
echo -e "\n> ${BWhite}Checking out${NC} '${BRed}master${NC}'"
git checkout master
echo -e "\n> ${BWhite}Pull${NC} '${BRed}master${NC}' from '${BRed}upstream${NC}'"
git pull upstream master
#echo -e "\n> ${BWhite}Merge${NC} '${BRed}upstream/master${NC}' to '${BRed}local/master${NC}'"
# ?? maybe not needed
git merge upstream master
echo -e "\n> ${BWhite}Push${NC} '${BRed}master${NC}' to '${BRed}origin/master${NC}'"
git push origin master

#dev
echo -e "\n> ${BWhite}Checking out${NC} '${BRed}dev${NC}'"
git checkout dev
echo -e "\n> ${BWhite}Pull${NC} '${BRed}dev${NC}' from '${BRed}upstream${NC}'"
git pull upstream dev
#echo -e "\n> ${BWhite}Merge${NC} '${BRed}upstream/dev${NC}' to '${BRed}local/dev${NC}'"
# ?? maybe not needed
git merge upstream dev
echo -e "\n> ${BWhite}Push${NC} '${BRed}local/dev${NC}' to '${BRed}origin/dev${NC}'"
git push origin dev

echo -e "\nStarting ${BWhite}synchronizing${NC} '${BRed}master${NC}' & '${BRed}dev${NC}' with ${BWhite}upstream KC2.0${NC}... ${BGreen}done${NC}"