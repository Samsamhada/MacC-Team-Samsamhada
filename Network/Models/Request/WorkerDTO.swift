//
//  WorkerDTO.swift
//  Samsam
//
//  Created by creohwan on 2022/12/04.
//

import Foundation

struct WorkerDTO: Encodable {
    var userIdentifier: String
    var name: String?
    var email: String?
    var number: String?
    
    init(userIdentifier: String,
         name: String? = nil,
         email: String? = nil,
         number: String? = nil) {
        self.userIdentifier = userIdentifier
        self.name = name
        self.email = email
        self.number = number
    }
}

