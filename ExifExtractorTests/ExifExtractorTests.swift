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
        // need to get a proper image to finish this test
        let data = Data()
        sut.extractInfoFromImage(data: data) { tiff, exif, info, errors in
            XCTAssertNotNil(tiff)
            XCTAssertNotNil(exif)
            XCTAssertNotNil(info)
        }
    }

}
