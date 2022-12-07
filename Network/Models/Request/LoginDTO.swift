//
//  LoginDTO.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

struct LoginDTO: Encodable {
    var code: Data?
    var token: Data?
    var name: String?
    var number: String?
    
    init(code: Data? = nil,
         token: Data? = nil,
         name: String? = nil,
         number: String? = nil) {
        self.code = code
        self.token = token
        self.name = name
        self.number = number
    }
}
