//
//  Requestable.swift
//  Manito
//
//  Created by creohwan on 2022/11/10.
//


import Foundation

protocol Requestable {
    var requestTimeOut: Float { get }
    
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}
