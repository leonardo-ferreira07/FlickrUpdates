//
//  Photos.swift
//  FlickrUpdates
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/08/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

struct Photos {
    
    let page: Int
    let perpage: Int
    let photo: [Photo]
    
    init(usingDict dict: [String: AnyObject]) {
        self.page = dict["page"] as! Int
        self.perpage = dict["perpage"] as! Int
        self.photo = JSONParserHelper.parsePhotos(dict)
    }
    
}
