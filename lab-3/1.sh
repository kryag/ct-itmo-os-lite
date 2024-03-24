#!/bin/bash

function get_current_time() {
    date +"%F_%R"
}

host="www.net_nikogo.ru"
mkdir ~/test && { echo "catalog test was created successfully" > ~/report; touch ~/test/$(get_current_time)_Script_Run; }
ping -c 1 $host || echo "$(get_current_time) $host was inaccessible." >> ~/report
