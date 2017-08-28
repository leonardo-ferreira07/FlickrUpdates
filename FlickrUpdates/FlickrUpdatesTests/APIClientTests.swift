//
//  APIClientTests.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import XCTest
@testable import FlickrUpdates

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // 1
    func test_apiClient_Uses_Proper_Flickr_URL() {
        
        let sut = APIClient()
        
        let mockURLSession = MockURLSession.init(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        let page = 1
        
        let completion = {(photos: Photos?, error: Error?) in }
        sut.loadPage(page, completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail(); return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "api.flickr.com")
        
        XCTAssertEqual(urlComponents?.path, "/services/rest")
        
        let jsonItem = URLQueryItem.init(name: "format", value: "json")
        let apiKeyItem = URLQueryItem.init(name: "api_key", value: Constants.flickr_user_api_key)
        let methodItem = URLQueryItem.init(name: "method", value: Constants.flickr_service_getRecent)
        let noJsonCallbackItem = URLQueryItem.init(name: "nojsoncallback", value: "1")
        let extrasItem = URLQueryItem.init(name: "extras", value: "url_m,url_o,owner_name,views,date_taken")
        let pageItem = URLQueryItem.init(name: "page", value: "\(page)")
        
        XCTAssertTrue(urlComponents?.queryItems?.contains(jsonItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(apiKeyItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(methodItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(noJsonCallbackItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(extrasItem) ?? false)
        XCTAssertTrue(urlComponents?.queryItems?.contains(pageItem) ?? false)
        
        // https://api.flickr.com/services/rest/?
        // format=json&
        // nojsoncallback=1&
        // api_key=e642c34c6ac8532ef77a7ec1c221babc
        // &method=flickr.photos.getRecent&
        // extras=url_m,url_o,owner_name,views,date_taken
        // &page=2
        // &per_page=30
        
    }
    
}


extension APIClientTests {
    
    class MockURLSession : SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask.init(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
        
        var completionHandler: completionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
    
}
