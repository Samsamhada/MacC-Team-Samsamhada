//
//  RoomEndPoint.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

enum RoomEndPoint: EndPointable {
    case startAppleLogin(body: LoginDTO)
    case createRoom(body: RoomDTO)
    case modifyRoom(roomID: Int, body: RoomDTO)
    case loadRoomByWorkerID(workerID: Int)
    case loadRoom(roomID: Int)
    case createStatus(body: StatusDTO)
    case loadPostsByRoom(roomID: Int)

    var requestTimeOut: Float {
        return 10
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .startAppleLogin, .createRoom, .createStatus:
            return .post
        case .loadRoomByWorkerID, .loadRoom, .loadPostsByRoom:
            return .get
        case .modifyRoom:
            return .put
        }
    }

    var requestBody: Data? {
        switch self {
        case .startAppleLogin(let body):
            return body.encode()
        case .createRoom(let body):
            return body.encode()
        case .modifyRoom(_, let body):
            return body.encode()
        case .createStatus(let body):
            return body.encode()
        default:
            return nil
        }
    }

    func getURL(baseURL: String) -> String {
        switch self {
        case .startAppleLogin:
            return "\(APIEnvironment.workersURL)"
        case .createRoom:
            return "\(APIEnvironment.roomsURL)"
        case .modifyRoom(let roomID, _):
            return "\(APIEnvironment.roomsURL)/\(roomID)"
        case .loadRoomByWorkerID(let workerID):
            return "\(APIEnvironment.roomsURL)/worker/\(workerID)"
        case .loadRoom(let roomID):
            return "\(APIEnvironment.roomsURL)/\(roomID)"
        case .createStatus:
            return "\(APIEnvironment.statusesURL)"
        case .loadPostsByRoom(let roomID):
            return "\(APIEnvironment.postsURL)/photo/room/\(roomID)"
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
