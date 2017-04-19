# macOS App Icon Resizer
**Bash script** which generates all power-of-2 sized images down to `16x16` (default) from an input image. This is useful if you need to frequently convert a high-resolution image into multiple half-sized variants. In particular, it can be used to quickly generate draft icon files for **macOS** applications.

## Example
The script takes two arguments:
1. The **size** for the largest image you want to create (should be a power of 2 bigger than 16)
2. The **path** to the full-size image file. The input image should be a raster format with a 1:1 aspect ratio.

`./AppIconResizer.sh 1024 MyFullSizeIcon.png`

Would generate all power-of-2 size images from _MyFullSizeIcon.png_ starting with 1024x1024 down to 16x16px. New images will be placed alongside the original, with the dimension appended to the name.

![MacOSAppIconResizerTerminalDemo](/README_Images/MacOSAppIconResizerTerminalDemo.gif?raw=true "MacOSAppIconResizerTerminalDemo")

### Before:
![demoBefore](/README_Images/demoBefore.png?raw=true "demoBefore")

### After:
![demoAfter](/README_Images/demoAfter.png?raw=true "demoAfter")

## Notes

This is a general-purpose script which is intended for working with draft icons or other developer resizing needs. When shipping the final icons for your polished macOS application, you should be customizing the icon visually for each size and for retina or non-retina displays. More info: [https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/OSXHIGuidelines/Designing.html](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/OSXHIGuidelines/Designing.html)

## Author

**Matt Reagan** - Website: [http://sound-of-silence.com/](http://sound-of-silence.com/) - Twitter: [@hmblebee](https://twitter.com/hmblebee)

## License

Source code and related resources are Copyright (C) Matthew Reagan 2016. The source code is released under the [MIT License](https://opensource.org/licenses/MIT).
