#!/bin/bash


declare -A APPS
function find_dependencies() {
  for app in "$@"; do
    APPS[$app]=$(find_command $app)
  done
}


function fail() {
  message=$1

  echo "Failure $message"
  exit 1
}


function find_command() {
  command_name=$1

  full_path=$(which $command_name)

  if [ $? -ne 0 ]; then
    fail "You do not have '$command_name' in your PATH"
  fi

  echo "$full_path"
}


function subcommand_control() {
  find_dependencies tmux

  unset TMUX
  ${APPS[tmux]} -2 new-session ./gic.sh log\; split-window -v -p 10 ./gic.sh prompt\; attach
}


function subcommand_log() {
  find_dependencies watch git

  ${APPS[watch]} -t "${APPS[git]} pull -q; ${APPS[git]} log --pretty=format:'%<(17)%an%m %s'"
}

function subcommand_prompt() {
  find_dependencies git cut

  while true; do
    printf "> "
    read line
    if [[ $line == /join* ]]; then
      room=$(echo -n "$line" | ${APPS[cut]} -d' ' -f2)
      ${APPS[git]} checkout $room
    elif [[ $line == /create* ]]; then
      room=$(echo -n "$line" | ${APPS[cut]} -d' ' -f2)
      ${APPS[git]} checkout -b $room
      ${APPS[git]} push -u origin $room
    elif [[ $line == /help* ]]; then
      echo "/join --> joins an existing room"
      echo "/create --> creates a new room"
    else
      ${APPS[git]} commit -q --allow-empty -m "$line"
      ${APPS[git]} push -q
    fi
  done
}

function sanitize_subcommand() {
  subcommand=$1

  if [ -z "$subcommand" ]; then
    echo "subcommand_control"
  else
    echo "subcommand_$subcommand"
  fi
}

if [ "-bash" != "$0" ]; then
  $(sanitize_subcommand $1)
fi
