#!/usr/bin/env ash

ps aux | egrep "[n]ginx" || exit 1
ps aux | egrep "[s]shd" || exit 1
