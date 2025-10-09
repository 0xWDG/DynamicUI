# Form Example

This example demonstrates how to define a `Form` using DynamicUI's JSON schema.  
The form includes a section with three toggles, each illustrating different configuration options.

```json
[
    {
        "type": "Form",
        "children": [
            {
                "type": "Section",
                "title": "Form example",
                "children": [
                    {
                        "type": "Toggle",
                        "title": "Toggle"
                    },
                    {
                        "type": "Toggle",
                        "title": "Toggle",
                        "defaultValue": true
                    },
                    {
                        "type": "Toggle",
                        "title": "Toggle",
                        "defaultValue": true,
                        "disabled": true
                    }
                ]
            }
        ]
    }
]
```