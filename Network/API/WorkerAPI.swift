//
//  WorkerAPI.swift
//  Samsam
//
//  Created by creohwan on 2022/11/30.
//

import Foundation

struct WorkerAPI {
    private let apiService: Requestable
    
    init(apiService: Requestable) {
        self.apiService = apiService
    }
    
    func loadWorkerDataByWorkerID(workerID: Int) async throws -> Login? {
        let request = WorkerEndPoint
            .loadWorkerDataByWorkerID(workerID: workerID)
            .createRequest()
        return try await apiService.request(request)
    }
}

