#!/usr/bin/env bash

##################################################################
# COLORS
source "${BASH_SOURCE%/*}/assets/colors.sh" || source assets/colors.sh

##################################################################
# ERRORS & SUCCESS VARS
source "${BASH_SOURCE%/*}/assets/flags.sh" || source assets/flags.sh


##################################################################
# ERRORS MESSAGES

function error()
{
  case "$1" in
    # Change Directory CASE
    "$ERROR_CD" )
      echo -e "\a\n\t\033[5m⛔️ \033[0;1;31mImpossible to change directory"
      ;;
    # DIR (homemade function) CASE
    "$ERROR_DIR" )
      echo -e "\a\n\t\033[5m⛔️ \033[0;1;31mDir doesn't work"
      ;;
    # CLONE CASE
    "$ERROR_CLONE" )
      echo -e "\a\n\t\033[5m⛔️ \033[0;1;31mImpossible to clone"
      ;;
    # INIT CASE
    "$ERROR_INIT" )
      echo -e "\a\n\t\033[5m⛔️ \033[0;1;31mImpossible to push initial commit"
      ;;
    # ADD CASE
    "$ERROR_NOT_GIT_REPO" )
      echo -e "\a\n\t\033[5m⛔️ \033[0;1;31mYou're not where you think you are..."
      echo -e "\t   \033[0;1;2;31m Have a look bro' : $PWD$COLOR_NONE"
      echo -e "\a\n\t \033[0;1;31mIt's not a git repository."
      ;;
    # ADD CASE 2
    "$ERROR_ADD" )
      echo -e "\a\n\t$COLOR_LIGHT_RED💥️ \033[0;1;31mPlease commit your change before"
      ;;
    # STATUS CASE
    "$ERROR_STATUS" )
      echo -e "\a\n\t\033[5m ⁉️ STATUS \033[0;1;31mSomething appends during the status$COLOR_NONE"
      ;;
    # PULL CASE
    "$ERROR_PULL" )
      echo -e "\a\n\t$COLOR_LIGHT_RED💥  Something appends during the pull...$COLOR_NONE"
      ;;
    # RESET CASE
    "$ERROR_RESET" )
      echo -e "\a\n\t$COLOR_LIGHT_RED💥  It's seems the reset didn't work as we wanted....$COLOR_NONE"
      ;;
    # PUSH CASE 'changes since git add'
    "$ERROR_PUSH" )
      echo -e "\a\n\t$COLOR_LIGHT_RED💥  Hum, sorry... It's not pushed. Kill the creator of this shit.$COLOR_NONE"
      ;;
    # PUSH CASE
    "$ERROR_ACCESS" )
      echo -e "\a\n\t\033[5m 🚨 $RED Please make sure you have the correct access rights and the repository exists.$COLOR_NONE"
      ;;
    # PULL CASE
    "$ERROR_UNREACHABLE" )
      echo -e "\a\n\t\033[5m 🚨 $RED Git seems unreachable... Trying again later. $COLOR_NONE"
      ;;
    # PULL CASE
    "$ERROR_UNMERGEDFILES" )
      echo -e "\a\n\033[5m  💥$COLOR_LIGHT_RED You have unmerged files!"
      echo -e " $RED    Resolve confilts first, then launch the rocket again$COLOR_NONE"
      ;;
    # PUSH CASE
    "$ERROR_ROCKET" )
      echo -e "\a\n\t\033[5m 💥🚀  \033[0;1;31mHouston! We have a problem!$COLOR_NONE"
      echo -e "\t\033[0;2;1;31m KEEP CALM & eat a Donut!$COLOR_NONE"
      ;;
    # DEFAULT CASE
    * )
      echo -e "\a\n\t$RED Error uncaught."
    ;;
  esac
}

function step_error()
{
  echo -e "$COLOR_LIGHT_RED [✘] $COLOR_NONE"
}

function step_wait()
{
  echo -e "$COLOR_DARK_ORANGE [↓] $COLOR_NONE"
}

##################################################################
# SUCCESS MESSAGES

function success()
{
  case "$1" in
    # NOTHING TO COMMIT
    "$SUCCESS_NOTHING" )
      echo -e "\n  $COLOR_BLACK_ON_WHITE ✅  Nothing to commit Bro'!  $COLOR_NONE"
      ;;
    # PUSHED
    "$SUCCESS_PUSH" )
      echo -e "\n  $COLOR_BLACK_ON_WHITE ✅  It's all good, man! 👌 $COLOR_NONE"
      ;;
    # PULLED
    "$SUCCESS_PULL")
      echo -e "\n  $COLOR_BLUE_ON_WHITE ✅  Everything is pulled, man! $COLOR_NONE"
      ;;
    "$SUCCESS_CLONE")
      echo -e "\n  $COLOR_BLUE_ON_WHITE ✅  The git repo is cloned! $COLOR_NONE"
      ;;
    "$SUCCESS_INIT")
      echo -e "\n  $COLOR_BLACK_ON_WHITE 🎉 It's the initiiiial commit! 🌸 $COLOR_NONE"
      ;;
  esac
}

function step_success()
{
  echo -e "$COLOR_LIGHT_GREEN [✔︎] $COLOR_NONE"
}