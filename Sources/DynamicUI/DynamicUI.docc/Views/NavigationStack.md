# NavigationStack Example

```json
[
    {
        "type": "NavigationStack",
        "children": [
            {
                "type": "NavigationLink",
                "title": "Details",
                "children": [
                    { "type": "Text", "title": "Detail content" }
                ]
            }
        ]
    }
]
```

NavigationStack falls back to NavigationView before iOS 16, macOS 13, tvOS 16, and watchOS 9.

| Parameter | Type | Description |
| --- | --- | --- |
| `children` | Array | Root navigation content. |
| `modifiers` | Object | Visual and behavioral modifiers. |
