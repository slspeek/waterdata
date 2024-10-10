#!/bin/bash
#
# usage: create-tag.sh [-M|-m|-p]
# defaults to -m
# -M creates new major version
# -m creates new minor version
# -p creates new patch version
#
OPTION=${1:-"-m"}

LAST_TAG=$(git for-each-ref --sort=creatordate --format '%(refname:lstrip=2)' refs/tags|tail -1)

# if no tags where found assume v0.0.0
LAST_TAG=${LAST_TAG:-"v0.0.0"}

MAJOR=$(echo ${LAST_TAG}|cut -d'.' -f1|sed -e 's/v//'|xargs echo -n)
MINOR=$(echo ${LAST_TAG}|cut -d'.' -f2|xargs echo -n)
PATCH=$(echo ${LAST_TAG}|cut -d'.' -f3|xargs echo -n)

increment() {
  echo ${1}+1|bc
}

echo ------------------------------------------
echo Latest tag: $LAST_TAG

case $OPTION in
  "-m" )
    MINOR=$(increment $MINOR)
    PATCH=0
    ;;
  "-M" )
    MAJOR=$(increment $MAJOR)
    MINOR=0
    PATCH=0
    ;;
  "-p" )
    PATCH=$(increment $PATCH)
    ;;
esac
NEW_TAG=v${MAJOR}.${MINOR}.${PATCH}
NEW_DESC=$(echo $NEW_TAG|sed -e 's/v/version /')
echo Creating new tag: $NEW_TAG annotation: $NEW_DESC
echo ------------------------------------------

git tag -m "$NEW_DESC" $NEW_TAG
