#!/bin/bash
local_repos_dir=`realpath ~/ghe.fork/`
repo_name="KC2.0"
repo_path=${local_repos_dir}/${repo_name}
branch="$1"
branch_remote_tracking="origin"
git_remote="upstream"

# print input variables
echo "local_repos_dir        : $local_repos_dir"
echo "repo_name              : $repo_name"
echo "repo_path              : $repo_path"
echo "branch                 : $branch"
echo "branch_remote_tracking : $branch_remote_tracking"
echo "git_remote             : $git_remote"
echo ""

#colors
NC="\x1B[m"               # Color Reset
BWhite='\x1B[1;37m'       # White
BRed='\x1B[1;31m'         # Red
BGreen='\x1B[1;32m'       # Green

cd ${repo_path}
echo -e "Start ${BWhite}synchronizing${NC} '${BRed}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."

echo -e "\n> ${BWhite}Fetching${NC} from '${BRed}${git_remote}${NC}'"
git fetch ${git_remote}

echo -e "\n> ${BWhite}Checking out${NC} '${BRed}${branch}${NC}'"
git checkout ${branch}

echo -e "\n> ${BWhite}Pulling${NC} '${BRed}${branch}${NC}' from '${BRed}${git_remote}${NC}'"
git pull ${git_remote} ${branch}

echo -e "\n> ${BWhite}Pushing${NC} '${BRed}${branch}${NC}' to '${BRed}${branch_remote_tracking}${NC}'"
git push -u ${branch_remote_tracking} ${branch}

echo -e "\nFinished ${BWhite}synchronizing${NC} '${BRed}${branch}${NC}' of '${BRed}${repo_name}${NC}' with '${BRed}${git_remote}${NC}'..."