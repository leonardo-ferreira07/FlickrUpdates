//
//  PhotoTests.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import XCTest
@testable import FlickrUpdates

class PhotoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_SetsAllProperties() {
        let photo = Photo(urlMedium: "Foo", ownerName: "Bar")
        
        XCTAssertEqual(photo.urlMedium, "Foo")
        XCTAssertEqual(photo.ownerName, "Bar")
    }
    
    func test_InitWithDictionary_SetsAllProperties() {
        let dictPhoto = MockJSONLoader.loadJSONFrom(file: "photo", usingClass: self)
        
        guard let dict = dictPhoto else {
            XCTFail("a photo.json file is needed to proceed with this test.")
            return
        }
        
        let photo = Photo(dict: dict)
        
        XCTAssertEqual(photo.urlMedium, "https://farm5.staticflickr.com/4438/35891687574_08ee950eef.jpg")
        XCTAssertEqual(photo.ownerName, "VirtualFtness")
    }
}
