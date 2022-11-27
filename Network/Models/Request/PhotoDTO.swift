//
//  PhotoDTO.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/27.
//

import Foundation

struct PhotoDTO: Encodable {
    let photoPath: String
    
    init(photoPath: String) {
        self.photoPath = photoPath
    }
}
