#!/usr/bin/env bash

set -e

VERSION="${1:?}"
TARGET=master

git checkout -b "$VERSION" || git checkout "$VERSION"
git fetch origin
git reset --hard origin/"$TARGET"

for file in {mvn_dependencies_project,mvn_dependencies_tools,com.ckardaris.Klisi}.yml
do
    curl -LOJ --clobber https://gitlab.com/ckardaris/klisi/-/releases/$VERSION/downloads/$file
    git add $file
done

git commit -m "Update: $VERSION"
git push origin
gh pr new -B "$TARGET" -t "Update: $VERSION" -b "Release page: https://gitlab.com/ckardaris/klisi/-/releases/$VERSION"
