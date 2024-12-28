#!/bin/sh

set -e

rojo sourcemap default.project.json -o sourcemap.json

rm -rf dist
mkdir dist

cp -r src dist/src
cp README.md dist/README.md
cp LICENSE dist/LICENSE
cp pesde.toml dist/pesde.toml
cp pesde.lock dist/pesde.lock

cp build.project.json dist/default.project.json
sed -i 's/dist\/src/src/' dist/default.project.json

cd ./dist

if [ "$1" = "--publish" ]; then
    pesde publish
else
    pesde publish -d
fi