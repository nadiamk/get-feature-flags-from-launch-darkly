#!/usr/bin/env sh

# Generates a simplified version of the feature flag info pulled from Launch Darkly, setting all to false
#  will create a file mock_feature_flags.json in same directory


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
#LD_SDK=$(grep LD_SDK ../../.env | xargs)
LD_SDK=$(grep LAUNCH_DARKLY_SDK_KEY .env | xargs)
IFS='=' read -ra LD_SDK <<< "$LD_SDK"
LD_SDK=${LD_SDK[1]}
echo "LD_SDK is $LD_SDK"

# construct JSON
echo '{ "flagValues": {' \
$(join , $(for i in $(curl -H "Authorization: $LD_SDK" https://app.launchdarkly.com/sdk/latest-all | jq '.flags' | jq 'to_entries[].value.key'); do i=$i:false; echo $i'\n'; done)) \
' } }' | jq > mock_feature_flags.json
