#!/usr/bin/env bash

##################################################################
# COLORS
source "${BASH_SOURCE%/*}/assets/colors.sh" || source assets/colors.sh


##################################################################
# VERSION

VERSION="0.9.5"

function version() {
    echo -e "$COLOR_DARK_ORANGE  Version $ORANGE $VERSION $COLOR_NONE"
}


##################################################################
# HELP

function help()
{
    echo -e "$COLOR_DARK_ORANGE  Version $ORANGE $VERSION $COLOR_NONE"

    echo -e "\n  📙$ORANGE Usage      $WHITE GitRocket $GREEN<options> $CYAN[name]$COLOR_NONE\n"
    echo -e "\t$COLOR_GREEN_UNDERLINED  Options  $COLOR_NONE"

    echo -e "\t$GREEN   m  \t\t\t$COLOR_LIGHT_GRAY To check changes and commit your stuff $COLOR_NONE"
    echo -e "\t$GREEN   ma  \t\t\t$COLOR_LIGHT_GRAY To commit your stuff directly"
    echo -e "\t${GREEN}   c ${CYAN}<new_folder>  \t$COLOR_LIGHT_GRAY To clone a git repo' into new folder"
    echo -e "\t${GREEN}   i  \t\t\t$COLOR_LIGHT_GRAY To make an initial commit $COLOR_NONE"
    echo -e "\t${GREEN}   p  \t\t\t$COLOR_LIGHT_GRAY To pull when your teammates tell you to do it $COLOR_NONE"
    echo -e "\t${GREEN}   s  \t\t\t$COLOR_LIGHT_GRAY To synchronize your local repo with the remote $COLOR_NONE"
    echo -e "\t${GREEN}   v  \t\t\t$COLOR_LIGHT_GRAY To show the version of the rocket $COLOR_NONE"

    echo -e "\n\t${ORANGE}   update \t\t$COLOR_LIGHT_GRAY Update GitRocket and never miss a new feature! $COLOR_NONE"

    echo -e "\n\t$COLOR_GREEN_UNDERLINED  Soon  $COLOR_NONE"
    echo -e "\t$GREEN   r  \t\t\t$COLOR_LIGHT_GRAY Revert & Push $COLOR_NONE"

    echo -e "\n\n$PURPLE Made with $MAGENTA ❤︎ $COLOR_LIGHT_CYAN by Jenn Brody$COLOR_NONE"
}

## NPM ? UPDATE ?


##################################################################
# HEADER

function header() {
    echo -e "\n\n  \033[37m🚀    Welcome to \033[1;33mGitRocket\033[0;37m!    🚀$COLOR_NONE"
    echo -e "  \033[34m---------------------------------$COLOR_NONE"
}

