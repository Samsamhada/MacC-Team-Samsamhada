//
//  RoomEndPoint.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

enum RoomEndPoint: EndPointable {
    case startAppleLogin(body: LoginDTO)
    case loadRoomByWorkerID(workerID: Int)
    
    var requestTimeOut: Float {
        return 10
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .startAppleLogin:
            return .post
        case .loadRoomByWorkerID:
            return .get
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .startAppleLogin(let body):
            return body.encode()
        default:
            return nil
        }
    }
    
    func getURL(baseURL: String) -> String {
        switch self {
        case .startAppleLogin:
            return "\(baseURL)/workers"
        case .loadRoomByWorkerID(let workerID):
            return "\(baseURL)/rooms/worker/\(workerID)"
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
