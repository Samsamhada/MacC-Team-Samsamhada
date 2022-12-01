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
    case loadRoomByWorkerID(workerID: Int)
    case createStatus(body: StatusDTO)
    case createPost(body: PostDTO)
    case loadPostsByRoomID(roomID: Int)
    case createPhoto(body: PhotoDTO)
    case loadStatusesByRoomID(roomID: Int)
    case modifyRoom(roomID: Int, body: RoomDTO)
    case loadRoom(roomID: Int)

    var requestTimeOut: Float {
        return 10
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .startAppleLogin, .createRoom, .createPost, .createPhoto, .createStatus:
            return .post
        case .loadRoomByWorkerID, .loadPostsByRoomID, .loadStatusesByRoomID, .loadRoom:
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
        case .createPost(let body):
            return body.encode()
        case .createPhoto(let body):
            return body.encode()
        case .createStatus(let body):
            return body.encode()
        case .modifyRoom(_, let body):
                return body.encode()
        default:
            return nil
        }
    }

    func getURL(baseURL: String) -> String {
        switch self {
        case .startAppleLogin:
            return APIEnvironment.workersURL
        case .createRoom:
            return APIEnvironment.roomsURL
        case .loadRoomByWorkerID(let workerID):
            return "\(APIEnvironment.roomsURL)/worker/\(workerID)"
        case .createStatus:
            return APIEnvironment.statusesURL
        case .loadStatusesByRoomID(let roomID):
            return "\(APIEnvironment.statusesURL)/room/\(roomID)"
        case .createPost:
            return APIEnvironment.postsURL
        case .loadPostsByRoomID(let roomID):
            return "\(APIEnvironment.postsURL)/photo/room/\(roomID)"
        case .createPhoto:
            return APIEnvironment.photosURL
        case .modifyRoom(let roomID, _):
            return "\(APIEnvironment.roomsURL)/\(roomID)"
        case .loadRoom(let roomID):
            return "\(APIEnvironment.roomsURL)/\(roomID)"
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
