#!/bin/sh

if [ ! -d vendor ]; then
    echo 'This script must be run from your kwerc root, i.e. ./vendor/update.sh'
    exit
fi

for v in $(git remote show | sed '/\(origin\|upstream\)/d'); do
    git fetch $v master
    git subtree pull --prefix vendor/$v $v master --squash
done
