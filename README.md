# ExifExtractor

Allows you to extract EXIF and TIFF information about an image

## Usage

Use this framework once you have fetched the PHAsset from the user. If you have not already converted the PHAsset into an image, this framework will do it for you.

Let the user choose their image from photos library, then use the extractData function with your PHAsset

```swift
var tiffData: TIFF?
var exifData: EXIF?
var photoInfo: [String: Any]?

// You can also pass in a `Data` representation of an image instead of a `PHAsset`
ExifExtractor().extractInfo(from: myAsset) { tiff, exif, info, errors in
    // assign to vars so you can use them elsewhere in your code
    tiffData = tiff
    exifData = exif
}
// access the properties
exifData?.shutterSpeedValue
exifData?.isoValue
```

The extractInfo function returns three values, the tiff, exif and a dictionary containing all the info of the image. You can use the dictionary if there is some custom info in the image that is not a part of the standard TIFF/EXIF info.


