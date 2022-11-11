//
//  LoginAPI.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

struct LoginAPI: LoginProtocol {
    private let apiService: Requestable
    
    init(apiService: Requestable) {
        self.apiService = apiService
    }
    
    func startAppleLogin(content: LoginDTO) async throws -> Login? {
        let request = LoginEndPoint
            .startAppleLogin(content: content)
            .createRequest()
        return try await apiService.request(request)
    }
}
