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