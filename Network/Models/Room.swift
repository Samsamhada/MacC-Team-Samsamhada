//
//  Room.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct Room: Decodable {
    let roomID: Int
    let workerID: Int
    let clientName: String
    let clientNumber: String?
    let startDate: String
    let endDate: String
    let warrantyTime: Int
    let inviteCode: String
}
