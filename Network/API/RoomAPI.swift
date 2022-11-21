//
//  RoomAPI.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct RoomAPI {
    private let apiService: Requestable
    
    init(apiService: Requestable) {
        self.apiService = apiService
    }
    
    func startAppleLogin(LoginDTO: LoginDTO) async throws -> Login? {
        let request = LoginEndPoint
            .startAppleLogin(body: LoginDTO)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func loadRoomByWorkerID(workerID: Int) async throws -> [Room]? {
        let request = RoomEndPoint.loadRoomByWorkerID(workerID: workerID).createRequest()
        return try await apiService.request(request)
    }
}
