#!/bin/bash

. goodmorning.env

N="GOODMORNING: "

#$STOP_PORTAL

cd "$PORTAL_SOURCE_DIR"
pwd

isChange=$(git status --porcelain)

if [ "$isChange" != "" ]; then
    echo "$N stash"
    git stash
fi;

git branch|grep -q '\* *master'
if [ "$?" == "0" ]; then
    echo "$N master branch"
    git pull upstream master
    git push origin master
else
    echo "$N not on master"
    echo "$N FETCH"
    git fetch --no-tags upstream master:master
    echo "$N PUSH"
    git push origin master:master
    echo "$N REBASE"
    git rebase master
fi;

ant all

if [ "$isChange" != "" ]; then
    echo "$N STASH POP"
    git stash pop
fi;

echo "$N DONE"
