#!/usr/bin/env bash

VERSION_PREFIX=$(git config --get gitflow.prefix.versiontag)

if [ ! -z "$VERSION_PREFIX" ]; then
    VERSION=${VERSION#$VERSION_PREFIX}
fi

if [ -z "$VERSION_BUMP_MESSAGE" ]; then
    VERSION_BUMP_MESSAGE="Bump version to %version%"
fi

VERSION_CURRENT=$(__get_project_version)
PROJ_FILE=$(__set_project_version $VERSION_CURRENT $VERSION)

git add $PROJ_FILE && \
    git commit -m "$(echo "$VERSION_BUMP_MESSAGE" | sed s/%version%/$VERSION/g)"

if [ $? -ne 0 ]; then
    __print_fail "Unable to write version to $PROJ_FILE."
    return 1
else
    return 0
fi
