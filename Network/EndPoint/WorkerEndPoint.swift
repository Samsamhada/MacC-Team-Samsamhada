//
//  WorkerEndPoint.swift
//  Samsam
//
//  Created by creohwan on 2022/11/30.
//

import Foundation

enum WorkerEndPoint: EndPointable {
    case loadWorkerDataByWorkerID(workerID: Int)
    
    var requestTimeOut: Float {
        return 10
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loadWorkerDataByWorkerID:
            return .get
        }
    }
    
    var requestBody: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    func getURL(baseURL: String) -> String {
        switch self {
        case .loadWorkerDataByWorkerID(let workerID):
            return "\(APIEnvironment.workersURL)/\(workerID)"
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
