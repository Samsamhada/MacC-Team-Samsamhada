//
//  Photo.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/22.
//

import Foundation

struct Photo: Codable {
    let photoID: Int
    let photoPath: String
}

struct PhotoElement: Codable {
    let postID, roomID, category, type: Int
    let description, createDate: String
    let photos: [Photo]
}
