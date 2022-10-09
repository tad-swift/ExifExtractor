//
//  ExifExtractorTests.swift
//  ExifExtractorTests
//
//  Created by Tadreik Campbell on 10/7/22.
//

import XCTest
@testable import ExifExtractor
import Photos

final class ExifExtractorTests: XCTestCase {
    
    let sut = ExifExtractor()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // test should fail if the data returned is nil
    func testExtractInfoFromImage() throws {
        // metadata of the image being tested
        
        /*
         ["{Exif}": {
         ColorSpace = 65535;
         PixelXDimension = 828;
         PixelYDimension = 1472;
         }, "Depth": 8, "ColorModel": RGB, "PixelHeight": 1472, "ProfileName": Display P3, "{TIFF}": {
         Orientation = 1;
         }, "PixelWidth": 828, "{JFIF}": {
         DensityUnit = 0;
         JFIFVersion =     (
         1,
         0,
         1
         );
         XDensity = 72;
         YDensity = 72;
         }, "Orientation": 1]
         */
        
        
        let fileImg = UIImage(named: "testImage", in: Bundle(for: ExifExtractorTests.self), compatibleWith: nil)
        let mediaFileData = fileImg?.jpegData(compressionQuality: 1)
        
        sut.extractInfoFromImage(data: mediaFileData!) { tiff, exif, info, errors in
            XCTAssertNotNil(tiff)
            XCTAssertNotNil(exif)
            XCTAssertNotNil(info)
        }
    }

}
