//
//  PhotoEntity+CoreDataProperties.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/21.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var photoID: Int32
    @NSManaged public var photoPath: Data?
    @NSManaged public var postingID: Int32
    @NSManaged public var photoToPosting: PostingEntity?

}

extension PhotoEntity : Identifiable {

}
