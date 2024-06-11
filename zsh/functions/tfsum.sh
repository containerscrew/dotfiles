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