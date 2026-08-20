# AsyncImage Example

Load a remote image with a progress placeholder and an accessible failure state.

```json
[
    {
        "type": "AsyncImage",
        "title": "DynamicUI logo",
        "url": "https://example.com/image.png",
        "parameters": {
            "contentMode": "fit"
        }
    }
]
```

| Parameter | Type | Description |
| --- | --- | --- |
| `title` | String | Accessibility label and loading description. |
| `url` | String | Remote HTTP or HTTPS image URL. |
| `parameters.contentMode` | String | `fit` (default) or `fill`. |
| `modifiers` | Object | Visual and behavioral modifiers. |
