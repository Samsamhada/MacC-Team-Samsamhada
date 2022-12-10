//
//  RoomAPI.swift
//  Samsam
//
//  Created by 김민택 on 2022/11/21.
//

import Foundation

struct RoomAPI {
    private let apiService: Requestable

    init(apiService: Requestable) {
        self.apiService = apiService
    }

    func startAppleLogin(LoginDTO: LoginDTO) async throws -> Login? {
        let request = LoginEndPoint
            .startAppleLogin(body: LoginDTO)
            .createRequest()
        return try await apiService.request(request)
    }

    func createRoom(RoomDTO: RoomDTO) async throws -> Room? {
        let request = RoomEndPoint
            .createRoom(body: RoomDTO)
            .createRequest()
        return try await apiService.request(request)
    }

    func loadRoomByWorkerID(workerID: Int) async throws -> [Room]? {
        let request = RoomEndPoint
            .loadRoomByWorkerID(workerID: workerID)
            .createRequest()
        return try await apiService.request(request)
    }

    func createStatus(StatusDTO: StatusDTO) async throws -> Status? {
        let request = RoomEndPoint
            .createStatus(body: StatusDTO)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func loadStatusesByRoomID(roomID: Int) async throws -> [Status]? {
        let request = RoomEndPoint
            .loadStatusesByRoomID(roomID: roomID)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func createPost(PostDTO: PostDTO) async throws -> Post? {
        let request = RoomEndPoint
            .createPost(body: PostDTO)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func modifyPost(PostDTO: PostDTO, postID: Int) async throws -> Message? {
        let request = RoomEndPoint
            .modifyPost(body: PostDTO, postID: postID)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func loadPostByRoomID(roomID: Int) async throws -> [Post]? {
        let request = RoomEndPoint
            .loadPostsByRoomID(roomID: roomID)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func createPhoto(PhotoDTO: PhotoDTO) async throws -> Photo? {
        let request = RoomEndPoint
            .createPhoto(body: PhotoDTO)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func modifyRoom(roomID: Int, RoomDTO: RoomDTO) async throws -> Message? {
        let request = RoomEndPoint
            .modifyRoom(roomID: roomID, body: RoomDTO)
            .createRequest()
        return try await apiService.request(request)
    }
    
    func loadRoom(roomID: Int) async throws -> Room? {
        let request = RoomEndPoint
            .loadRoom(roomID: roomID)
            .createRequest()
        return try await apiService.request(request)
    }
}
