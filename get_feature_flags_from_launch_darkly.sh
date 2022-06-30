#!/usr/bin/env sh

# Generates a simplified version of the feature flag info pulled from Launch Darkly: creates a file
# feature_flags.csv in the same directory, listing the flag names and whether they are on or off.


# joins strings, e.g.
# $ join ', ' a b c   # returns 'a, b, c'
join(){
    # If no arguments, do nothing.
    # This avoids confusing errors in some shells.
    if [ $# -eq 0 ]; then
        return
    fi

    local joiner="$1"
    shift

    while [ $# -gt 1 ]; do
        printf "%s%s" "$1" "$joiner"
        shift
    done

    printf '%s\n' "$1"
}

# grab the key from .env
LD_SDK=$(grep LAUNCH_DARKLY_SDK_KEY .env | xargs)

# IFS (Internal Field Separator) is used by the shell to set the delimiter between tokens (i.e. to find word boundaries)
IFS='=' read -ra LD_SDK <<< "$LD_SDK"

LD_SDK=${LD_SDK[1]}

echo "LD_SDK is $LD_SDK"

# construct CSV
curl -H "Authorization: $LD_SDK" https://app.launchdarkly.com/sdk/latest-all | jq -r '.flags[] | .key + "," + (.on|tostring)' > feature_flags.csv
