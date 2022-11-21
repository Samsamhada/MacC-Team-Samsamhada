//
//  Status.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct Status: Decodable {
    let statusID: Int
    let roomID: Int
    let category: Int
    let status: Int
}
