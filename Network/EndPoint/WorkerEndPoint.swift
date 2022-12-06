//
//  WorkerEndPoint.swift
//  Samsam
//
//  Created by creohwan on 2022/11/30.
//

import Foundation

enum WorkerEndPoint: EndPointable {
    case loadWorkerDataByWorkerID(workerID: Int)
    case modifyWorkerData(workerID: Int, workerDTO: WorkerDTO)
    
    var requestTimeOut: Float {
        return 10
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loadWorkerDataByWorkerID:
            return .get
        case .modifyWorkerData:
            return .put
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .modifyWorkerData(_, let body):
            return body.encode()
        default:
            return nil
        }
    }
    
    func getURL(baseURL: String) -> String {
        switch self {
        case .loadWorkerDataByWorkerID(let workerID), .modifyWorkerData(let workerID, _):
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
