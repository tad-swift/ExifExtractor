//
//  Errors.swift
//  ExifExtractor
//
//  Created by Tadreik Campbell on 10/7/22.
//

import Foundation

enum DataNotFoundError: Error {
    case dataNotFound(String)
}

enum ExtractionError: String, Error {
    case intializeImageFailed = "Failed to initialize a CIImage instance with the data provided"
}
