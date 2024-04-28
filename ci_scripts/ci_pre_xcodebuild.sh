#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "



cd ../yekaterinburg/

plutil -replace TOKEN_FD -string $token_footballdata Info.plist
plutil -replace TOKEN_BDL -string $token_balldontlie Info.plist

plutil -p Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
