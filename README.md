![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-tips-print-black)](LICENSE)

# 4d-tips-print-black

When you assign the colour "automatic" to a system object on Mac, its fill or stroke is  is typically not `#000000`.

`OBJECT GET RGB COLORS` may indeed return the hexadecimal value `#000000` in light mode, but on print and PDF, the colour is actually "very dark grey", not pure black.

```4d
var $fg; $bg; $ag : Text
OBJECT GET RGB COLORS(*; $object; $fg; $bg; $ag)
```

In the example below, the objects on the page on top are not pure black because their stroke colours are set to `automatic`.

By contrast, the objects on the page below have a darker hue because their stroke colours are set to `black`.

<img src="https://github.com/user-attachments/assets/b7438125-a77b-4c37-84df-78d5a570bef0" width=516 height=auto >

According to the colour picker, what seems like black is actually `#272727`. 

<img src="https://github.com/user-attachments/assets/6f579815-5dc3-41e6-81a1-348ed8518e44" width=217 height=auto >
<img src="https://github.com/user-attachments/assets/96c98077-a30b-42e3-b6a0-c4abf875618c" width=217 height=auto >
