//
//  LoginDTO.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

struct LoginDTO: Encodable {
    var userIdentifier: String
    var name: String?
    var email: String?
    
    init(userIdentifier: String, name: String? = nil, email: String? = nil) {
        self.userIdentifier = userIdentifier
        self.name = name
        self.email = email
    }
}
