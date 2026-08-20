# ShareLink Example

```json
[
    {
        "type": "ShareLink",
        "title": "Share DynamicUI",
        "url": "https://github.com/0xWDG/DynamicUI",
        "parameters": {
            "systemImage": "square.and.arrow.up"
        }
    }
]
```

ShareLink requires iOS 16, macOS 13, or watchOS 9. Earlier systems and tvOS render a normal Link.

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessible share action label. |
| `url` | String | URL to share. |
| `parameters.systemImage` | String | Optional SF Symbol shown beside the title. |
| `modifiers` | Object | Visual and behavioral modifiers. |
