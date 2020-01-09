#!/bin/bash

## This script is called to copy all ressources
## Destination is basicly the output/ module
## The output module is the document-root of what is served on deployment

mkdir -p output/img
mkdir -p output/fonts

## app files
cp sources/ressources/fonts/* output/fonts/
cp sources/ressources/img/* output/img/

cp sources/ressources/favicons/* output/
cp sources/ressources/manifests/* output/

echo 0
