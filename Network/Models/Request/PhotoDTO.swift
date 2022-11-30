//
//  PhotoDTO.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/27.
//

import Foundation

struct PhotoDTO: Encodable {
    let postID: Int
    let photo: Data
    
    init(postID: Int, photo: Data) {
        self.postID = postID
        self.photo = photo
    }
}
