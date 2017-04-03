//
//  DictPlace.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/2/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation

extension Place {
    convenience init(withDict dict: Dictionary<String, Any>){
        let id = dict["_id"] as! String
        let name = dict["name"] as! String
        let info = dict["info"] as? String
        let imageUrl = dict["img"] as! String
        let owner = dict["owner"] as? String
        let rating = dict["rating"] as! Int
        self.init(withId :id, name: name,imageUrl:imageUrl, owner:owner, rating:rating, andInfo: info)
    }
    
    static func fromDict(_ dict: Dictionary<String, Any>) -> Place {
        return Place(withDict: dict)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "name": self.name!,
            "info": self.info!,
            "img": self.imageUrl!,
            "owner": self.owner!,
            "rating": self.rating!
        ]
    }
}
