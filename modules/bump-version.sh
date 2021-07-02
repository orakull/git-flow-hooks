#!/usr/bin/env bash

if [ -z "$VERSION" ]; then
    if [ "$1" == "hotfix" ]; then
        VERSION=$(__get_hotfix_version_bumplevel)
    elif [ "$1" == "release" ]; then
        VERSION=$(__get_release_version_bumplevel)
    else
        VERSION="PATCH"
    fi
fi

VERSION_PROJECT=$(__get_project_version)
VERSION=$($HOOKS_DIR/modules/semverbump.sh "$VERSION" "$VERSION_PROJECT" "$VERSION_SORT")

if [ $? -ne 0 ]; then
    __print_fail "Unable to bump version."
    return 1
else
    return 0
fi
