#!/usr/bin/env bash

GITROCKET_URL="https://raw.githubusercontent.com/Brodylive/GitRocket/master/bin/gitrocket.sh"
GITROCKET_PATH="$HOME/.gitrocket/bin"
GITROCKET_SCRIPT="$GITROCKET_PATH/gitrocket"

##################################################################
# Installation procedure
if [[ ! -f "$GITROCKET_SCRIPT" ]]; then
    if [[ ! -d "$GITROCKET_PATH" ]]; then
        mkdir -p ${GITROCKET_PATH}
    fi

    if [[ $(basename $0) != "gitrocket" ]]; then
        echo -e "\tDownloading"
        curl -sS -o ${GITROCKET_SCRIPT} ${GITROCKET_URL}
    else
        echo -e "\tLocal install"
        cp $0 ${GITROCKET_SCRIPT}
    fi
fi

# Add to profile
for FILE in $HOME/.profile $HOME/.bash_profile $HOME/.bashrc; do
    if [[ -f ${FILE} ]]; then
        if [[ $(grep -s "$GITROCKET_PATH" ${FILE}) ]]; then
            unset FILE; break
        fi
    fi
done

if [[ -f ${FILE} ]]; then
    echo -e "\tAdd GitRocket to your $FILE"
    echo "source $GITROCKET_SCRIPT" >> ${FILE}
fi


##################################################################
# COLORS
source "${BASH_SOURCE%/*}/GitRocket/assets/colors.sh" || source GitRocket/assets/colors.sh

##################################################################
# ERRORS & SUCCESS VARS
source "${BASH_SOURCE%/*}/GitRocket/assets/flags.sh" || source GitRocket/assets/flags.sh

##################################################################
# DISPLAY (Help, Version, Header)
source "${BASH_SOURCE%/*}/GitRocket/display.sh" || source GitRocket/display.sh

##################################################################
# SELECT
source "${BASH_SOURCE%/*}/GitRocket/select.sh" || source GitRocket/select.sh

##################################################################
# MESSENGER
source "${BASH_SOURCE%/*}/GitRocket/messenger.sh" || source GitRocket/messenger.sh




##################################################################
# MODULES



clone()
{
  echo -ne "\n\t\033[0;37m☄💫 uri git ➣ $COLOR_NONE"
  read uri
  echo -e "\n $COLOR_DARK_GRAY Clone ... $COLOR_NONE"

  git clone $uri $1 || {
    error "$ERROR_CLONE"
    return 1
  } 

  echo -e " $COLOR_DARK_GRAY ... finished! $COLOR_NONE"

  cd "$1" || {
    error "$ERROR_CD"
    return 1
  } 

  # if [ "$1" != "." ]; then
  #   if [ ! -d "$1" ]; then
  #     git clone $uri $1 || {
  #       echo "1er cas"
  #       errorMsg "$ERROR_CLONE"
  #       return 1
  #     } 
  #     cd $1 || {
  #       errorMsg "$ERROR_CD"
  #       return 1
  #     }
  #   else
  #     cd $1 || {
  #       errorMsg "$ERROR_CD"
  #       return 1
  #     } 
  #     git clone $uri || {
  #       echo "2er cas"
  #       errorMsg "$ERROR_CLONE"
  #       return 1
  #     } 
  #   fi
  # else
  #   git clone $uri || {
  #     echo "3er cas"
  #     errorMsg "$ERROR_CLONE"
  #     return 1
  #   } 
  # fi

  echo -e "\n  \033[0;37m Current directory : $PWD$COLOR_NONE"
  success "${SUCCESS_CLONE}"

  return 0
}

initCommit()
{
  (touch README.md && git add README.md && git commit -m ":tada: Initial Commit with GitRocket :rocket:" && git push -u origin master) || {
      error "$ERROR_INIT"
      return 1
  }
  success "${SUCCESS_INIT}"

  return 0
}

function before_commit(){
  # ADD
  echo -en "\n $COLOR_DARK_GRAY Adding files. $COLOR_NONE"

  git_add=$(git add . 2>&1)
  if [[ ${git_add} =~ "not a git repository" ]]; then
    error "$ERROR_NOT_GIT_REPO"
    return 1
  elif [[ ${git_add} =~ "please commit or stash them" ]]; then
    git_add=$(git add . 2>&1) || {
        echo "\n $RED NEW ADD ERROR :: ${git_add} :: $COLOR_NONE"
        error "$ERROR_ADD"
        return 1
    }
  fi

  echo -e "\n $COLOR_DARK_GRAY Status of branch : $COLOR_NONE\n"

  # STATUS
  git_status=$(git status)
  if [[ ${git_status} =~  "publish your local commits" ]]; then
    # SOMETHING TO PUSH
    echo -en "\n $COLOR_DARK_GRAY Preparing to publish your lasts commits. $COLOR_NONE"
    pull || {
        error ${ERROR_PULL}
        return 1
    }
    push && success ${SUCCESS_PUSH} || return 1
    return 1
  elif [[ ${git_status} =~ "nothing to commit" ]]; then
    # ALL'S RIGHT
    success "$SUCCESS_NOTHING"
    return 1 # to stop execution
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    # CONTINUE PROGRAM
    # branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    git status # Format this display
    return 0
  else
    # BUG STATUS
    echo "\n $RED NEW STATUS ERROR :: ${git_status} :: $COLOR_NONE"
    error "$ERROR_STATUS"
    return 1
  fi
}

function commit(){
    COUNTER=0
    ANSWER="n"
    while [[  ${COUNTER} -lt 42 ]]; do
      if [[ -z "$1" ]]; then
        echo -ne "\n\t\033[0;37m🚀 Commit this? [y/n] $COLOR_NONE"
        read ANSWER
      else
        ANSWER="y"
      fi
      case "$ANSWER" in
        y | yes | yep | yep! | yup! | yup | ouaip | zyva | 1 | true)
          write_message
          git_commit=$(git commit -m "$MESSAGE")
            if [[ ${git_commit} =~ "Could not read from remote repository" ]]; then
              error "${ERROR_COMMIT}"
              return 1
            else
              echo -e " $COLOR_DARK_GRAY Commit written $COLOR_NONE"
              return 0
            fi
          ;;
        n | no | nope | np | nein | 0 | false)
          reset || return 1
          commit || return 1
          return 0
          ;;
        * )
          echo -e "\n\t\033[5;33m Not an anwser$COLOR_NONE"
          ;;
      esac
    done
}

function write_message() {
  COUNTER=0
  commit_thrown=1
  while [[  ${COUNTER} -lt 42 ]]; do
    if [[ ${commit_thrown} -eq 1 ]]; then
        selectEmoji

        echo -en "\n \033[0;37m ✎ Label du commit ➣ $COLOR_NONE"
        read label
        # $selectedEmoji from SELECT
        MESSAGE="$selectedEmoji $label"
    fi
    echo -en "\n $WHITE ☞ $RED $MESSAGE $CYAN OK? [y/n] $COLOR_NONE"
    read proceeded

    case "$proceeded" in
      y | yes | yep | yep! | yup! | yup | ouaip | zyva | 1 | true)
        echo -e "\n $COLOR_DARK_GRAY Connect to remote repository...  $COLOR_NONE"
        return 0
        ;;
      n | no | nope | np | nein | 0 | false)
        echo -e "$COLOR_DARK_GRAY Commit thrown. $COLOR_NONE"
        commit_thrown=1
        ;;
      * )
        echo -e "\n\t\033[5;33m Not an anwser$COLOR_NONE"
        commit_thrown=0
        ;;
    esac
  done
}

function push()
{
    echo -en "\n $COLOR_DARK_GRAY Push starting... $COLOR_NONE"
    git_push=$(git push -v 2>&1)

    if [[ ${git_push} =~ "updating local tracking ref" ]]; then
      # ALL'S RIGHT!
      echo -e "\n $COLOR_DARK_GRAY It's pushed! $COLOR_NONE\n"
      return 0
    elif [[ ${git_push} =~ "unstaged changes" ]]; then
      rocket || error ${ERROR_ROCKET}
      return 0
    elif [[ ${git_push} =~ "Could not read from remote repository" ]];then
        error ${ERROR_ACCESS}
        return 1
    else
      # BUG PUSH
      echo "\n $RED NEW PUSH ERROR :: ${git_push} :: $COLOR_NONE"
      error "${ERROR_PUSH}"
      return 1
    fi
}

function pull(){
  echo -en "\n $COLOR_DARK_GRAY Pull starting... $COLOR_NONE"
  git_pull=$(git pull --rebase 2>&1)

  if [[ ${git_pull} =~ "is up to date" ]]; then
    echo -e "\n $COLOR_DARK_GRAY Pull finished. $COLOR_NONE"
    return 0
  elif [[ ${git_pull} =~ "please commit or stash them" ]]; then
    # ASK for stash or commit
    stash || return 1
    return 0
  elif [[ ${git_pull} =~ "rewinding head to replay your work on top of it" ]]; then
    pull || return 1
    return 0
  else
    # BUG PULL
    echo "\n $RED NEW PULL ERROR :: ${git_pull} :: $COLOR_NONE"
    return 1
  fi
}

function stash(){
    echo -en "\n $COLOR_DARK_GRAY Stashing your work... $COLOR_NONE"
    git_stash=$(git stash)
    pull || return 1
    git_stash=$(git stash pop)
    echo -en "\n $COLOR_DARK_GRAY Stash apply! $COLOR_NONE"
    return 0
}

function reset(){
  echo -ne "\n\t\033[0;37m❌ Want to reset all or a file? [y/n/namefile] $COLOR_NONE"
  read proceeded
  case "$proceeded" in
    y | yes | yep | yep! | yup! | yup | ouaip | zyva | 1 | true)
      (git reset HEAD && git checkout .) || {
        error ${ERROR_RESET}
        return 1
      }
      # RAINBOW COLOR
      echo -e "\n\t\033[0;36m🌞 \033[0;1;94;105m Have \033[0;97;44m a nice \033[0;97;101m day! ️$COLOR_NONE"
      return 1 # to stop execution
      ;;
    n | no | nope | np | nein | 0 | false)
      echo -e "\n\t\033[5;33m⚠️ \033[0;1;33m Don't forget to commit dude! ️$COLOR_NONE"
      return 1 # to stop execution
      ;;
    * )
      (git reset HEAD "$proceeded" && git checkout "$proceeded") || {
        error ${ERROR_RESET}
        return 1
      }
      echo -e " $COLOR_DARK_GRAY The file has been reset. $COLOR_NONE"
      return 0
      ;;
  esac
}

function rocket() {
    # throws errors and success,
    # so just stop execution if something is thrown
    before_commit || return 1
    commit $1 || return 1
    pull || return 1
    push || return 1
    return 0
}

##################################################################
# MAIN

GitRocket()
{
  header

  # myarray=(one two three)
  # case "${myarray[@]}" in  *"two"*) echo "found" ;; esac

## New branch?

  # HELP or INITIAL COMMIT - variable 1
  case "$1" in
    v)
      version
      ;;
    c)
    # CLONE GIT REPO - variable 2 = folder for git repo
      clone "$2"
      return 0
      ;;
    i)
      # INITIAL COMMIT
      initCommit
      return 0
      ;;
    p)
      pull && success "${SUCCESS_PULL}" || error "${ERROR_PULL}"
      return 0
      ;;
    m)
      # Errors thrown inside the rocket
      rocket && success "$SUCCESS_PUSH"
      return 0
      ;;
    ma)
      # Errors thrown inside the rocket
      rocket "agree" && success "$SUCCESS_PUSH"
      return 0
      ;;
    *)
    # HELP
      help
      return 0
      ;;
  esac
  return 0
}
