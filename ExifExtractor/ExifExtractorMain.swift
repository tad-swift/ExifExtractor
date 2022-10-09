//
//  File.swift
//  ExifExtractor
//
//  Created by Tadreik Campbell on 10/7/22.
//

import Foundation
import Photos

public class ExifExtractor {
    
    private var queue: OperationQueue
    
    public init(operationQueueName: String? = "ExifExtractorMain") {
        queue = OperationQueue()
        queue.qualityOfService = .utility
        queue.name = operationQueueName
    }
    
    /// Input a PHAsset and recives back its info
    public func extractInfo(from asset: PHAsset, completion: @escaping (TIFF?, EXIF?, [String: Any]?, [Error]) -> Void) {
        queue.addOperation { [weak self] in
            self?.requestImageData(for: asset) { data in
                if let data = data {
                    self?.extractInfo(from: data) { tiff, exif, info, errors in
                        completion(tiff, exif, info, errors)
                    }
                } else {
                    completion(nil, nil, nil, [])
                }
            }
        }
    }
    
    /// Grabs the entire image data and returns it back to you
    func requestImageData(for asset: PHAsset, completion: @escaping (Data?) -> Void) {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .fastFormat
        requestOptions.isNetworkAccessAllowed = true
        
        manager.requestImageDataAndOrientation(for: asset, options: requestOptions) { data, fileName, orientation, info in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    /// Initializes tiff and exif objects and returns them along with any errors
    public func extractInfo(from data: Data, completion: (TIFF?, EXIF?, [String: Any]?, [Error]) -> Void) {
        var errors: [Error] = []
        guard let image = CIImage(data: data) else {
            errors.append(ExtractionError.intializeImageFailed)
            completion(nil, nil, nil, errors)
            return
        }
        
        let exifData = image.properties["{Exif}"] as? [String: Any]
        let tiffData = image.properties["{TIFF}"] as? [String: Any]
        
        var tiffObject: TIFF?
        var exifObject: EXIF?
        
        if let tiffData = tiffData {
            tiffObject = TIFF(dictionary: tiffData)
        } else {
            errors.append(DataNotFoundError.dataNotFound("No TIFF data available"))
        }
        
        if let exifData = exifData {
            exifObject = EXIF(dictionary: exifData, cameraModel: tiffObject?.cameraModel)
        } else {
            errors.append(DataNotFoundError.dataNotFound("No EXIF data available"))
        }
        
        completion(tiffObject, exifObject, image.properties, errors)
    }
    
}
