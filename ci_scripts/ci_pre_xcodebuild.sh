#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
##cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a JSON File containing all the environment variables and secrets.
##printf "{\"STRIPE_KEY\":\"%s\",\"GOOGLE_MAPS_KEY\":\"%s\",\"GOOGLE_PLACES_KEY\":\"%s\",\"BASE_URL\":\"%s\"}" "$STRIPE_KEY" "$GOOGLE_MAPS_KEY" "$GOOGLE_PLACES_KEY" "$BASE_URL" >> ../Dream\ Energy/SupportingFiles/Secrets.json

##echo "Wrote Secrets.json file."

cd ../yekaterinburg/

plutil -replace TOKEN_FD -string $token_footballdata Info.plist
plutil -replace TOKEN_BDL -string $token_balldontlie Info.plist

plutil -p Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
