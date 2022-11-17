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
    
    func startAppleLogin(LoginDTO: LoginDTO) async throws -> Login? {
        let request = LoginEndPoint
            .startAppleLogin(body: LoginDTO)
            .createRequest()
        return try await apiService.request(request)
    }
}
