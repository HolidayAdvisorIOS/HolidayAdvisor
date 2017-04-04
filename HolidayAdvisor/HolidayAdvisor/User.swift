//
//  User.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/4/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation

class User {
    var _id: String?
    var userName: String?
    var gender: String?
    var image: String?
    var age: Int?
        
    init(withId id: String, name: String, imageUrl: String?, gender: String?, andAge age: Int?){
        self._id = id
        self.userName = name
        self.image = imageUrl
        self.gender = gender
        self.age = age
    }
}
