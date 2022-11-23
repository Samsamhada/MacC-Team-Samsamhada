//
//  Protocol.swift
//  Samsam
//
//  Created by creohwan on 2022/11/11.
//

import Foundation

protocol LoginProtocol {
    func startAppleLogin(LoginDTO: LoginDTO) async throws -> Login?
    func addPhoneNumber(workerID: Int, LoginDTO: LoginDTO) async throws -> Message?
}
