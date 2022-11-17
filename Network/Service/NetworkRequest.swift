//
//  NetworkRequest.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod

    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Data? = nil,
         reqTimeout: Float? = nil,
         httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }

    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(APIEnvironment.apiKey, forHTTPHeaderField: "API-Key")
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}
