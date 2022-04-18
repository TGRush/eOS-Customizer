#!/bin/bash

# Ansi color code variables
# shellcheck disable=SC2034
red="\e[0;91m"
# shellcheck disable=SC2034
blue="\e[0;94m"
# shellcheck disable=SC2034
green="\e[0;92m"
# shellcheck disable=SC2034
white="\e[0;97m"
# shellcheck disable=SC2034
bold="\e[1m"
# shellcheck disable=SC2034
uline="\e[4m"
# shellcheck disable=SC2034
reset="\e[0m"

help() {
    echo -e "${bold}Elementary Customizer${reset}"
    echo "A Script to do plenty of common customization on ElementaryOS easily"
    echo ""
    echo "Syntax:"
    echo -e "$0 --help          Show a help page"
    echo -e "$0 --eostweaks     Install Elementary Tweaks"
    echo -e "$0 --nr            Install Namarupa (Classic Appindicators)"
    echo -e "$0 --enable-PPAs   Enable/Install PPA support"
    echo -e "$0 --icons         Install additional icon packs to fit the ElementaryOS Stylesheet"
}

eostweaks() {
    echo -e "${green}Checking ElementaryOS version..."
    if [ $(lsb_release -sc) == "odin" ] || [ $(lsb_release -sc) == "jolnir" ];then
        sudo apt install -y software-properties-common
        sudo add-apt-repository -y ppa:philip.scott/pantheon-tweaks
        sudo apt install -y pantheon-tweaks
        echo -e "${green}Installed Pantheon/Elementary Tweaks successfully!"
    else
        echo -e "${red}You are not running ElementaryOS Odin/Jólnir!${reset}"
    fi
}

namarupa() {
    echo -e "${green}Editing autostart..."
    mkdir -p ~/.config/autostart
    cp /etc/xdg/autostart/indicator-application.desktop ~/.config/autostart/
    sed -i 's/^OnlyShowIn.*/OnlyShowIn=Unity;GNOME;Pantheon;/' ~/.config/autostart/indicator-application.desktop
    echo -e "${green}Downloading Namarupa...${reset}"
    wget "https://github.com/Lafydev/wingpanel-indicator-namarupa/raw/master/com.github.donadigo.wingpanel-indicator-namarupa_1.0.2_odin.deb" -O namarupa.deb
    sudo apt install indicator-application -y
    sudo apt install ./namarupa.deb
    echo -e "${red}If the indicators don't appear, make sure ~/.config/autostart/indicator-application.desktop exists, if it does, then re-log (logout then login)${reset}"
    echo -e "${green}Done!${reset}"
}

ppa() {
    echo -e "${green}Enabling PPA support...${reset}"
    sudo apt install -y software-properties-common
    echo -e "${green}Done!${reset}"
}

icons() {

}

if [ -n "$1" ]; then
    case "$1" in
    --help)
    help
    ;;
    --eostweaks)
    eostweaks
    ;;
    --nr)
    namarupa
    ;;
    --icons)
    icons
    ;;
    --enable-ppas)
    ppa
    ;;
    *)
    echo "$1 is not an option!"
    esac
    shift
else
    echo "No Option Supplied!"
fi
