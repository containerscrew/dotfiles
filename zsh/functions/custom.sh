# Custom functions
function aws-profile() {
    local AWS_PROFILES
    AWS_PROFILES=$(cat ~/.aws/credentials | sed -n -e 's/^\[\(.*\)\]/\1/p' | fzf)
    if [[ -n "$AWS_PROFILES" ]]; then
        export AWS_PROFILE=$AWS_PROFILES
        echo "Selected profile: $AWS_PROFILES"
    else
        echo "No profile selected"
    fi
}

function batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

function git-containerscrew(){
  git config user.name "containerscrew"
  git config user.email "info@containerscrew.com"
}

function git-work() {
  git config user.name "myuser"
  git config user.email "daniels@mycompany.com"
}

function chpr(){
  git fetch origin pull/"$1"/head:pr-"$1"
}

function tfsum() {
  if [ -z "$1" ];
  then
    echo "You should type 'tfsum terraform|terragrunt'"
  else
    echo -en "Starting tf summary... Please wait"
    # If you want to print full plan output: $1 plan -out plan.tfplan
    $1 plan -out plan.tfplan 1> /dev/null
    $1 show -json plan.tfplan | tftools summarize --show-tags --compact
    # Delete plan out file to avoid git tracking (although is included in .gitignore)
    if [ -f "plan.tfplan" ]; then rm plan.tfplan; fi
  fi
}