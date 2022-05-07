# steam-game-on-sale-notifier

simple bash script to notify via pushover if a certain game is on sale on steam. for it to work, you have to find out the appid of the game first, e.g. by browsing onto steam.
the script is using the steam api to parse a http response as json with jq and looking at the field "discount_percent". if it is unequal to "0", a notification is sent to pushover.
the file "conf.json" holds your pushover credentials. you could easily adapt the script to curl to any other notification api which supports http requests.

## how to run it

```
bash notify_to_pushover_about_steam_game_discount.sh -i <steam appid of the game, e.g. 35720>
```

put it into crontab to make it run on a schedule.

