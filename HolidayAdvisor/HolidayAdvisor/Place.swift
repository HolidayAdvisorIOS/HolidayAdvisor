//
//  Place.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/2/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation

class Place {
    var _id: String?
    var name: String?
    var info: String?
    var imageUrl: String?
    var owner: String?
    var rating: Int?
    
    convenience init(withName name: String, imageUrl: String?, andInfo info: String?){
        self.init(withId: "", name: name,imageUrl: "", owner:"iPhoner", rating:0, andInfo: info)
    }
    
    init(withId id: String, name: String, imageUrl: String?, owner: String?, rating: Int?, andInfo info: String?){
        self._id = id
        self.name = name
        self.info = info
        self.imageUrl = imageUrl
        self.owner = owner
        self.rating = rating
    }
}
