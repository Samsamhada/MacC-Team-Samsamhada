//
//  PostingEntity+CoreDataProperties.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/21.
//
//

import Foundation
import CoreData


extension PostingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostingEntity> {
        return NSFetchRequest<PostingEntity>(entityName: "PostingEntity")
    }

    @NSManaged public var categoryID: Int32
    @NSManaged public var createDate: Date?
    @NSManaged public var explanation: String?
    @NSManaged public var postingID: Int32
    @NSManaged public var roomID: Int32
    @NSManaged public var postingToCategory: CategoryEntity?
    @NSManaged public var postingToRoom: RoomEntity?
    @NSManaged public var postingToPhoto: NSSet?

}

// MARK: Generated accessors for postingToPhoto
extension PostingEntity {

    @objc(addPostingToPhotoObject:)
    @NSManaged public func addToPostingToPhoto(_ value: PhotoEntity)

    @objc(removePostingToPhotoObject:)
    @NSManaged public func removeFromPostingToPhoto(_ value: PhotoEntity)

    @objc(addPostingToPhoto:)
    @NSManaged public func addToPostingToPhoto(_ values: NSSet)

    @objc(removePostingToPhoto:)
    @NSManaged public func removeFromPostingToPhoto(_ values: NSSet)

}

extension PostingEntity : Identifiable {

}
