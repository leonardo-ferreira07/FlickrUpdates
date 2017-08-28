//
//  JSONLoader.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct MockJSONLoader {
    
    public static func loadJSONFrom(file: String, usingClass: NSObject) -> [String: AnyObject]? {
        let testBundle = Bundle(for: type(of: usingClass))
        if let path = testBundle.path(forResource: file, ofType: "json") {
            do {
                let jsonData = try? NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    return try! JSONSerialization.jsonObject(
                        with: jsonData! as Data,
                        options: JSONSerialization.ReadingOptions.mutableContainers
                        ) as! [String: AnyObject]
                }
            }
        }
        return nil
    }
    
}
