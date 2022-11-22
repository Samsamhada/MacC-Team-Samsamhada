//
//  Post.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/22.
//

import Foundation

struct Post: Codable {
    let postID, roomID, category, type: Int
    let description, createDate: String
}
