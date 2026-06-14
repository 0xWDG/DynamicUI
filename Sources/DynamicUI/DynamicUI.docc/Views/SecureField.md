# SecureField

Use a `SecureField` to collect obscured text. When the value changes, DynamicUI emits the
component with its string `state` updated.

```json
[
    {
       "type": "SecureField",
       "title": "Password",
       "identifier": "password"
    }
]
```

### Parameters

| Parameter    | Type        | Description                                   |
| ------------ | ----------- | --------------------------------------------- |
| `title` | String | Placeholder for the secure field. |
| `identifier` | String | Key used for updates and conditional expressions. |
| `defaultValue` | String | Initial text value. |
| `modifiers` | Object | Visual and behavioral modifiers. |
