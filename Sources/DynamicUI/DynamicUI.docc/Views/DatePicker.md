# DatePicker Example

```json
[
    {
        "type": "DatePicker",
        "title": "Starts",
        "identifier": "startDate",
        "defaultValue": "2026-08-20T09:00:00Z",
        "minimum": "2026-01-01T00:00:00Z",
        "maximum": "2026-12-31T23:59:59Z",
        "parameters": {
            "displayedComponents": "dateAndTime"
        }
    }
]
```

Dates use ISO 8601 strings. A numeric `defaultValue` is interpreted as seconds since 1970. Changes
emit an ISO 8601 string in `state`. DatePicker is unavailable on tvOS and requires watchOS 10.

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible picker label. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | String or Number | Initial ISO 8601 date or Unix timestamp. |
| `minimum`, `maximum` | String | Optional inclusive ISO 8601 bounds. |
| `parameters.displayedComponents` | String | `date`, `hourAndMinute`, or `dateAndTime` (default). |
| `modifiers` | Object | Visual and behavioral modifiers. |
