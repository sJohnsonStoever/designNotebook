#!/bin/sh

dnbpath="." #This should be changed if calling this script from outside its parent dir.
editor="emacs"

filename=$(date +"%Y-%m-%d--%H-%M.md")

cd $dnbpath
# Output to file
bareEntry () {
    echo 'Title: '
    echo 'Date: '$(date +"%B %d, %Y")
    echo ' '
    echo ' '
}

bareEntry > entries/$filename
$editor entries/$filename
