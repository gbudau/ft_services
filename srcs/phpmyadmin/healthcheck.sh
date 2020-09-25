#!/usr/bin/env ash

ps aux | egrep "[n]ginx" || exit 1
ps aux | egrep "[p]hp-fpm7" || exit 1
