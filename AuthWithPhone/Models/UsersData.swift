//
//  UsersData.swift
//  UAS
//
//  Created by Евгений Григоренко on 10.05.22.
//  Copyright © 2022 Admin. All rights reserved.
//

import Foundation

class User {
    var userId: [String:String]?
    
    init(userId: [String:String]?){
        self.userId = userId
    }
}
