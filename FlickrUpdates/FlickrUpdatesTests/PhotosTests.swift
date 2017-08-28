//
//  PhotosTests.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import XCTest
@testable import FlickrUpdates

class PhotosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_InitGivenAndJSONDictionary_ReturnsPhotosModel_ProperlySet() {
        let dictFile = MockJSONLoader.loadJSONFrom(file: "photo_array", usingClass: self)
        
        guard let dict = dictFile else {
            XCTFail("a photo.json file is needed to proceed with this test.")
            return
        }
        
        let dictPhotos = dict["photos"] as! [String : AnyObject]
        let photos = Photos(usingDict: dictPhotos)
        
        XCTAssertEqual(photos.page, 2)
        XCTAssertEqual(photos.perpage, 30)
        XCTAssertEqual(photos.photo.count, 30)
        
    }
    
}
