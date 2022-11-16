//
//  LoginEndPoint.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

enum LoginEndPoint: EndPointable {
    case startAppleLogin(LoginDTO: LoginDTO)
    
    var requestTimeOut: Float {
        return 10
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .startAppleLogin:
            return .post
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .startAppleLogin(let body):
            return body.encode()
        }
    }
    
    func getURL(baseURL: String) -> String {
        switch self {
        case .startAppleLogin:
            return "\(baseURL)/workers"
        }
    }
    
    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(baseURL: APIEnvironment.baseURL),
                              headers: headers,
                              reqBody: requestBody,
                              reqTimeout: requestTimeOut,
                              httpMethod: httpMethod
        )
    }
    
    
}
