![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# 4d-tips-print-black

When you assign the colour "automatic" to a system object on Mac, its fill or stroke is typically not `black` or `#000000`.

[`OBJECT GET RGB COLORS`](https://developer.4d.com/docs/commands/object-get-rgb-colors) may indeed return the hexadecimal value `#000000` in light mode, but on print or PDF, the colour is actually "very dark grey" (`#242424` according to [`OPEN COLOR PICKER`](https://developer.4d.com/docs/commands/open-color-picker)), not pure black.

```4d
var $fg; $bg; $ag : Text
OBJECT GET RGB COLORS(*; $object; $fg; $bg; $ag)
```

In the example below, the objects on the top page have a lighter hue because their stroke colours are set to `automatic`.

By contrast, the objects on the bottom page have a darker hue because their stroke colours are set to `black`.

<img src="https://github.com/user-attachments/assets/b7438125-a77b-4c37-84df-78d5a570bef0" width=516 height=auto >

According to the colour picker, what seems like black is actually `#272727`, or very dark grey. 

<img src="https://github.com/user-attachments/assets/6f579815-5dc3-41e6-81a1-348ed8518e44" width=217 height=auto >
<img src="https://github.com/user-attachments/assets/96c98077-a30b-42e3-b6a0-c4abf875618c" width=217 height=auto >

## How to use black instead of automatic 

In HTML, it is common practice to use [media queries](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_media_queries/Using_media_queries) to apply different styles depending on a device's media. 

4D also has CSS [media queries](https://developer.4d.com/docs/FormEditor/stylesheets#media-queries) but it only supports the the media feature `prefers-color-scheme`.

The following CSS does not throw any errors but it has no effect in 4D

```css
@media print {
	text.normal  {
		stroke: red;		
	}
	input.normal {
		stroke: red;
	}	
	line.normal  {
		stroke: red;
	}
}
```

As a workaround, you can switch stylesheets by first loading the form in an object and changing the `css` property.

For example, given the 2 css files in `/SOURCES/`

* screen.css

```css
@media (prefers-color-scheme: light){
	text.normal  {
		stroke: automatic;		
	}
	input.normal {
		stroke: automatic;
	}	
	line.normal  {
		stroke: automatic;	
	}
}

@media (prefers-color-scheme: dark){
	text.normal  {
		stroke: automatic;		
	}
	input.normal {
		stroke: automatic;
	}	
	line.normal  {
		stroke: automatic;	
	}
}
```

* print.css

```css
text.normal  {
	stroke: black;		
}
input.normal {
	stroke: black;
}	
line.normal  {
	stroke: black;
}
```

and the form JSON

```json
{
	"$4d": {
		"version": "1",
		"kind": "form"
	},
	"css": [
		"/SOURCES/screen.css"
	]
}
```

```4d
FORM LOAD("black")
```

will use the default CSS for screen, whereas

```4d
$form:=JSON Parse(File("/SOURCES/Forms/black/form.4DForm").getText(); Is object)
$form.css:=["/SOURCES/print.css"] 
FORM LOAD($form)
```

will use the alternative CSS for print.

Of course, if the form is designed exclusively used for print then you may systematically use black instead of automatic.
