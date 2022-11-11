//
//  Endpointable.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//


import Foundation

protocol EndPointable {
    var requestTimeOut: Float { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
    func getURL(baseURL: String) -> String
}
