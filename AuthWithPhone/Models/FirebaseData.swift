//
//  Firebase.swift
//  AuthWithPhone
//
//  Created by Евгений Григоренко on 29.03.22.
//  Copyright © 2022 Admin. All rights reserved.
//

import Foundation

class Direction {
    let trainingType:String?
    let couch: String?
    let time: String?
    let countPeople: Int?
    let id: String?
    let user: User?
    
    init(trainingType: String,couch: String?, time: String?, countPeople: Int?, id: String?, user: User?) {
        self.trainingType = trainingType
        self.couch = couch
        self.time = time
        self.countPeople = countPeople
        self.id = id
        self.user = user
    }
}



