#!/usr/bin/env bash

##################################################################
# COLORS
source "${BASH_SOURCE%/*}/assets/colors.sh" || source assets/colors.sh


##################################################################
# SELECT

function selectEmoji()
{
  echo -e "\n\n $COLOR_LIGHT_CYAN List of available Emojis  $COLOR_NONE\n"

  COUNTER=0
  while [[  ${COUNTER} -lt 42 ]]; do

    echo -en "\t 1  🐛$COLOR_DARK_THIN_GREEN Fixing a bug$COLOR_NONE"
    echo -e "\t\t\t\t 2  💬$COLOR_DARK_THIN_GREEN Updating text and literals$COLOR_NONE"
    echo -en "\t 3  ✨$COLOR_DARK_THIN_GREEN Introducing new features$COLOR_NONE"
    echo -e "\t\t\t 4  📝$COLOR_DARK_THIN_GREEN Writing docs$COLOR_NONE"
    echo -en "\t 5  💄$COLOR_DARK_THIN_GREEN Updating the UI and style files$COLOR_NONE"
    echo -e "\t\t 6  🚧$COLOR_DARK_THIN_GREEN Work in progress$COLOR_NONE"
    echo -en "\t 7  💚$COLOR_DARK_THIN_GREEN Fixing CI Build$COLOR_NONE"
    echo -e "\t\t\t\t 8  🎨$COLOR_DARK_THIN_GREEN Improving structure / format of the code$COLOR_NONE"
    echo -en "\t 9  🚚$COLOR_DARK_THIN_GREEN Moving or renaming files$COLOR_NONE"
    echo -e "\t\t\t 10 🚸$COLOR_DARK_THIN_GREEN Improving user experience / usability$COLOR_NONE"
    echo -en "\t 11 🗃 $COLOR_DARK_THIN_GREEN Performing database related changes$COLOR_NONE"
    echo -e "\t 12 🔥$COLOR_DARK_THIN_GREEN Removing code or files$COLOR_NONE"
    echo -en "\t 13 ♻️ $COLOR_DARK_THIN_GREEN Refactoring code$COLOR_NONE"
    echo -e "\t\t\t\t 14 🍱$COLOR_DARK_THIN_GREEN Adding or updating assets$COLOR_NONE"
    echo -en "\t 15 💡$COLOR_DARK_THIN_GREEN Documenting source code$COLOR_NONE"
    echo -e "\t\t\t 16 🌐$COLOR_DARK_THIN_GREEN Internationalization and localization$COLOR_NONE"
    echo -en "\t 17 🙈$COLOR_DARK_THIN_GREEN Adding or updating a .gitignore file$COLOR_NONE"
    echo -e "\t 18 ⚗️ $COLOR_DARK_THIN_GREEN Experimenting new things$COLOR_NONE"
    echo -en "\t 19 🔒$COLOR_DARK_THIN_GREEN Fixing security issues$COLOR_NONE"
    echo -e "\t\t\t 20 📈$COLOR_DARK_THIN_GREEN Adding analytics or tracking code$COLOR_NONE"
    echo -en "\t 21 👷$COLOR_DARK_THIN_GREEN Adding CI build system$COLOR_NONE"
    echo -e "\t\t\t 22 👽$COLOR_DARK_THIN_GREEN Updating code due to external API changes$COLOR_NONE"
    echo -en "\t 23 👌$COLOR_DARK_THIN_GREEN Updating code due to code review changes$COLOR_NONE"
    echo -e "\t 24 🏗 $COLOR_DARK_THIN_GREEN Making architectural changes$COLOR_NONE"
    echo -e "\t 25 🚀$COLOR_DARK_THIN_GREEN Deploying stuff$COLOR_NONE"

    echo -e "\t x \033[0;2mNone$COLOR_NONE"

    echo -ne "\n \033[0;37m ☺︎ Number of emoji ➣ $COLOR_NONE"
    read opt

    case "$opt" in
      1 )
        selectedEmoji=':bug:'
        return 0
        ;;
      2 )
        selectedEmoji=':speech_balloon:'
        return 0
        ;;
      3 )
        selectedEmoji=':sparkles:'
        return 0
        ;;
      4 )
        selectedEmoji=':memo:'
        return 0
        ;;
      5 )
        selectedEmoji=':lipstick:'
        return 0
        ;;
      6 )
        selectedEmoji=':construction:'
        return 0
        ;;
      7 )
        selectedEmoji=':green_heart:'
        return 0
        ;;
      8 )
        selectedEmoji=':art:'
        return 0
        ;;
      9 )
        selectedEmoji=':truck:'
        return 0
        ;;
      10 )
        selectedEmoji=':children_crossing:'
        return 0
        ;;
      11 )
        selectedEmoji=':card_file_box:'
        return 0
        ;;
      12 )
        selectedEmoji=':fire:'
        return 0
        ;;
      13 )
        selectedEmoji=':recycle:'
        return 0
        ;;
      14 )
        selectedEmoji=':bento:'
        return 0
        ;;
      15 )
        selectedEmoji=':bulb:'
        return 0
        ;;
      16 )
        selectedEmoji=':globe_with_meridians:'
        return 0
        ;;
      17 )
        selectedEmoji=':see_no_evil:'
        return 0
        ;;
      18 )
        selectedEmoji=':alembic:'
        return 0
        ;;
      19 )
        selectedEmoji=":lock:"
        return 0
        ;;
      20 )
        selectedEmoji=":chart_with_upwards_trend:"
        return 0
        ;;
      21 )
        selectedEmoji=":construction_worker:"
        return 0
        ;;
      22 )
        selectedEmoji=":alien:"
        return 0
        ;;
      23 )
        selectedEmoji=":ok_hand:"
        return 0
        ;;
      24 )
        selectedEmoji=":building_construction:"
        return 0
        ;;
      25 )
        selectedEmoji=":rocket:"
        return 0
        ;;
      x )
        selectedEmoji=''
        return 0
        ;;
      * )
        echo -e "\n $ORANGE This option doesn't exists...$YELLOW Banana!$COLOR_NONE\n"
        ;;
    esac
  done
}
