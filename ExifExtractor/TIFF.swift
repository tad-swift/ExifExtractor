//
//  TIFF.swift
//  ExifExtractor
//
//  Created by Tadreik Campbell on 10/7/22.
//

import Foundation

public class TIFF: Codable {
    
    public var cameraModel: String?
    public var cameraSoftware: String?
    public var make: String?
    
    
    public init(dictionary: [String: Any]) {
        cameraModel = dictionary["Model"] as? String
        cameraSoftware = dictionary["Software"] as? String
        make = dictionary["Make"] as? String
        if make == "Apple" {
            cameraSoftware = "iOS \(cameraSoftware ?? "")"
        }
    }
    
}
