//
//  HttpRequesterDelegate.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/2/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation

protocol HttpRequesterDelegate {
    func didReceiveData(data: Any)
    func didReceiveError(error: HttpError)
    func didDeleteData()
}

extension HttpRequesterDelegate {
    func didReceiveData(data: Any) {
        
    }
    
    func didReceiveError(error: HttpError) {
        
    }
    
    func didDeleteData() {
        
    }
}
