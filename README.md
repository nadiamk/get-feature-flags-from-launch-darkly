Generates a simplified version of the feature flag info pulled from Launch Darkly, setting all to false.

This was useful in another project, but the functionality of note is being able to `curl` a list of feature flags and their properties.  See Figure 1 below for the `curl`'s results before it's parsed.

0. `cp .env.sample .env` and fill out the value
1. `$ ./get_feature_flags_from_launch_darkly.sh`
2. This will create a file `mock_feature_flags.json` in same directory.  See the file `mock_feature_flags_example.json` for an example, also reproduced here:
    ```json
    {
      "flagValues": {
        "service-1-enabled": false,
        "postgres-enabled": false
      }
    }
    ```


*Figure 1*: Partial result of `$ curl -H "Authorization: $LD_SDK" https://app.launchdarkly.com/sdk/latest-all`
```json
{
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
  }
}
```
