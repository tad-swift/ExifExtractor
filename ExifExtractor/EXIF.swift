//
//  EXIF.swift
//  ExifExtractor
//
//  Created by Tadreik Campbell on 10/7/22.
//

import Foundation

public class EXIF {
    
    public var aperture: String?
    public var focalLength: String?
    public var isoValue: String?
    public var lensModel: String?
    public var shutterSpeedValue: String?
    
    public init(dictionary: [String: Any], cameraModel: String?) {
        if let aperture = dictionary["FNumber"] {
            self.aperture = "ƒ/\(aperture)"
        }
        if let focalLength = dictionary["FocalLenIn35mmFilm"] {
            self.focalLength = "\(focalLength)mm"
        }
        if let isoValue = dictionary["ISOSpeedRatings"] {
            let isoArray = (isoValue as! Array<Any>)
            let isoInt = isoArray.first as! Int
            self.isoValue = "ISO \(isoInt)"
        }
        if let lensModel = dictionary["LensModel"] {
            let lensString = lensModel as! String
            if lensString.contains("iPhone") && lensString.contains("back") {
                self.lensModel = "\(cameraModel ?? "iPhone") rear camera"
            } else {
                self.lensModel = lensString
            }
        }
        if let shutterSpeedValue = dictionary["ShutterSpeedValue"] {
            let shutterSpeed = ceil(pow(2.0, Double(truncating: shutterSpeedValue as! NSNumber)))
            self.shutterSpeedValue = "1/\(Int(shutterSpeed)) sec"
        }
    }
    
}
