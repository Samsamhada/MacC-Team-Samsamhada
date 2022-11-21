//
//  RoomDTO.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct RoomDTO: Encodable {
    var workerID: Int
    var clientName: String
    var startDate: String
    var endDate: String
    var warrantyTime: Int

    init(workerID: Int, clientName: String, startDate: String, endDate: String, warrantyTime: Int) {
        self.workerID = workerID
        self.clientName = clientName
        self.startDate = startDate
        self.endDate = endDate
        self.warrantyTime = warrantyTime
    }
}
