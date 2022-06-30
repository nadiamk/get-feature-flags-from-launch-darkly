Generates a CSV of abbreviated feature flag info pulled from Launch Darkly, setting all to false.

This was useful in another project, but the functionality of note is being able to `curl` a list of feature flags and their properties.  See Figure 1 below for the `curl`'s results before it's parsed.

0. `cp .env.sample .env` and fill out the value
1. `$ ./get_feature_flags_from_launch_darkly.sh`
2. This will create a file `feature_flags.csv` in the same directory containing abbreviated FF info (the name of the flag and whether it's on or off).  See the file `feature_flags__example.csv` for an example, also reproduced here:
    ```csv
    service-1-enabled, false
    postgres-enabled, true
    ```


*Figure 1*: Result of `$ curl -H "Authorization: $LD_SDK" https://app.launchdarkly.com/sdk/latest-all`
```json
{
  "segments": {},
  "flags": {
    "service-1-enabled": {
      "key": "service-1-enabled",
      "on": false,
      "prerequisites": [],
      "targets": [],
      "rules": [],
      "fallthrough": {
        "variation": 0
      },
      "offVariation": 0,
      "variations": [
        true,
        false
      ],
      "clientSideAvailability": {
        "usingMobileKey": false,
        "usingEnvironmentId": false
      },
      "clientSide": false,
      "salt": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      "trackEvents": false,
      "trackEventsFallthrough": false,
      "debugEventsUntilDate": null,
      "version": 7,
      "deleted": false
    },
    "postgres-enabled": {
      "key": "postgres-enabled",
      "on": true,
      "prerequisites": [],
      "targets": [],
      "rules": [],
      "fallthrough": {
        "variation": 0
      },
      "offVariation": 0,
      "variations": [
        true,
        false
      ],
      "clientSideAvailability": {
        "usingMobileKey": false,
        "usingEnvironmentId": false
      },
      "clientSide": false,
      "salt": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
      "trackEvents": false,
      "trackEventsFallthrough": false,
      "debugEventsUntilDate": null,
      "version": 7,
      "deleted": false
    }
  }
}
```
