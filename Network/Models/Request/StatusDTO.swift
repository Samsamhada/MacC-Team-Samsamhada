//
//  StatusDTO.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct StatusDTO: Encodable {
    var roomID: Int
    var category: Int
    var status: Int?

    init(roomID: Int, category: Int, status: Int? = 0) {
        self.roomID = roomID
        self.category = category
        self.status = status
    }
}
