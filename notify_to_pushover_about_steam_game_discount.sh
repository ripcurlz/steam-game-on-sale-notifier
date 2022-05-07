#!/bin/bash

function help {

        printf "ERROR! you have to use this script like:\n"
        printf "bash notify_to_pushover_about_steam_game_discount.sh -i <steam appid of the game, e.g. 35720>\n"
        printf "will exit now...\n"

        exit 1
}

if [ "$1" != "-i" ]; then
        help;
fi

STEAM_APPID="${2}"


USER_KEY=$(jq -r .pushover_user_key conf.json)
APP_TOKEN=$(jq -r .pushover_token conf.json)

curl_result="$(curl https://store.steampowered.com/api/appdetails?appids=${STEAM_APPID})"

game_name=$( jq -r ".\"$STEAM_APPID\".data.name" <<< "${curl_result}" ) 

discount_percent=$( jq -r ".\"$STEAM_APPID\".data.price_overview.discount_percent" <<< "${curl_result}" ) 

printf "discount_percent for game '$game_name' with appid '$STEAM_APPID' is currently '$discount_percent'\n"

if [ "$discount_percent" != "0" ]; then
        curl -s --form-string "token=${APP_TOKEN}" --form-string "user=${USER_KEY}" --form-string "message=discount_percent for '${game_name}' is currently '${discount_percent}'" https://api.pushover.net/1/messages.json
fi

