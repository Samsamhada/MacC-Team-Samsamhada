//
//  LoginDTO.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

struct LoginDTO: Encodable {
    var userIdentifier: String
    var lastName: String?
    var firstName: String?
    var email: String?
    var number: String?
    
    init(userIdentifier: String,
         lastName: String? = nil,
         firstName: String? = nil,
         email: String? = nil,
         number: String? = nil) {
        self.userIdentifier = userIdentifier
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.number = number
    }
}
