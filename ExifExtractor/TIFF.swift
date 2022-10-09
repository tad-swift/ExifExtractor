//
//  TIFF.swift
//  ExifExtractor
//
//  Created by Tadreik Campbell on 10/7/22.
//

import Foundation

public class TIFF {
    
    public private(set) var cameraModel: String?
    public private(set) var cameraSoftware: String?
    public private(set) var make: String?
    
    
    public init(dictionary: [String: Any]) {
        cameraModel = dictionary["Model"] as? String
        cameraSoftware = dictionary["Software"] as? String
        make = dictionary["Make"] as? String
        if make == "Apple" {
            cameraSoftware = "iOS \(cameraSoftware ?? "")"
        }
    }
    
}
