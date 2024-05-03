function bws(){
  bw list items --search "$1" | jq
}