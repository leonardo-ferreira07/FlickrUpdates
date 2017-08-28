//
//  Photo.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct Photo {
    let urlMedium: String
    let ownerName: String
    
    init(urlMedium: String, ownerName: String) {
        self.urlMedium = urlMedium
        self.ownerName = ownerName
    }
    
    init(dict: [String: AnyObject]) {
        self.urlMedium = JSONParserHelper.parseString(dict["url_m"])
        self.ownerName = JSONParserHelper.parseString(dict["ownername"])
    }
}
