//
//  DictUser.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/4/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation

extension User {
    convenience init(withDict dict: Dictionary<String, Any>){
        let id = dict["_id"] as! String
        let name = dict["username"] as! String
        let image = dict["image"] as? String
        let gender = dict["gender"] as? String
        let age = dict["age"] as! Int
        self.init(withId :id, name: name, imageUrl: image, gender: gender, andAge : age)
    }
    
    static func fromDict(_ dict: Dictionary<String, Any>) -> User {
        return User(withDict: dict)
    }
    
//    func toDict() -> Dictionary<String, Any> {
//        return [
//            "name": self.name!,
//            "info": self.info!,
//            "img": self.imageUrl!,
//            "owner": self.owner!,
//            "rating": self.rating!
//        ]
//    }
}
