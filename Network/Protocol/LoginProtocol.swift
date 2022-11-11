//
//  Protocol.swift
//  Samsam
//
//  Created by creohwan on 2022/11/11.
//

import Foundation

protocol LoginProtocol {
    func startAppleLogin(content: LoginDTO) async throws -> Login?
}
