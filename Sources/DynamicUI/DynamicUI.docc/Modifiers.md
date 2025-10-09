# Supported Modifiers

DynamicUI supports a variety of modifiers that can be applied to components to customize their appearance and behavior. Here are some examples:

## Color Modifiers

You can change the foreground and background colors of a component using the `foregroundColor` and `backgroundColor` modifiers.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "foregroundColor": "purple",
       "backgroundColor": "yellow"
   }
}
```

## fontWeight Modifier

You can change the font weight of a component using the `fontWeight` modifier.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "fontWeight": "bold"
   }
}
```
## Font Modifiers

[TODO] You can customize the font of a component using the `font` modifier.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "font": {
           "size": 16,
           "weight": "bold"
       }
   }
}
```

## Frame Modifier

You can set the frame of a component using the `frame` modifier.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "frame": {
           "width": 200,
           "height": 50,
           "alignment": "center"
       }
   }
}
```

#### Supported modifiers for the Frame Modifier:

| Modifier     | Type   | Description                   |
|--------------|--------|-------------------------------|
| `width`      | float  | The width of the frame        |
| `height`     | float  | The height of the frame       |
| `minWidth`   | float  | The minimum width of the frame |
| `idealWidth` | float  | The ideal width of the frame   |
| `maxWidth`   | float  | The maximum width of the frame |
| `minHeight`  | float  | The minimum height of the frame |
| `idealHeight`| float  | The ideal height of the frame   |
| `maxHeight`  | float  | The maximum height of the frame |
| `alignment`  | string | The alignment of the frame      |

#### Supported Values for `alignment`:

| Value          | Description                     |
|----------------|---------------------------------|
| `leading`      | Aligns the content to the leading edge (left in LTR, right in RTL) |
| `trailing`     | Aligns the content to the trailing edge (right in LTR, left in RTL) |
| `center`       | Centers the content within the frame |
| `top`          | Aligns the content to the top of the frame |
| `bottom`       | Aligns the content to the bottom of the frame |

## Padding Modifier

You can add padding to a component using the `padding` modifier.

To use the default padding:

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "padding": true
   }
}
```

A custom value:

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "padding": 10
   }
}
```

[TODO] You can specify padding for specific edges:

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "padding": {
           "top": 10,
           "bottom": 5,
           "leading": 15,
           "trailing": 20
       }
   }
}
```

## Padding and Margins

[TODO] You can add padding and margins to components using the `padding` and `margin` modifiers.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "padding": {
           "top": 10,
           "bottom": 10,
           "leading": 10,
           "trailing": 10
       },
       "margin": {
           "top": 10,
           "bottom": 10,
           "leading": 10,
           "trailing": 10
       }
   }
}
```

## Shadow

[TODO] You can add a shadow effect to components using the `shadow` modifier.

```json
{
   "type": "Text",
   "title": "Title",
   "modifiers": {
       "shadow": {
           "color": "black",
           "radius": 5,
           "x": 0,
           "y": 2
       }
   }
}
```

## Opacity

You can change the opacity of a component using the `opacity` modifier.

```json
[
    {
        "type": "Text",
        "title": "Title",
        "modifiers": {
            "opacity": 0.5
        }
    }
]
```

## Disabled modifier

You can disable user interaction for a component using the `disabled` modifier.

```json
{
   "type": "Button",
   "title": "Submit",
   "modifiers": {
       "disabled": true
   }
}