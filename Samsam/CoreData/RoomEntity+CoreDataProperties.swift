//
//  RoomEntity+CoreDataProperties.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/21.
//
//

import Foundation
import CoreData


extension RoomEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoomEntity> {
        return NSFetchRequest<RoomEntity>(entityName: "RoomEntity")
    }

    @NSManaged public var clientName: String?
    @NSManaged public var endDate: Date?
    @NSManaged public var roomID: Int32
    @NSManaged public var startDate: Date?
    @NSManaged public var warrantyTime: Int32
    @NSManaged public var roomToWorkingStatus: NSSet?
    @NSManaged public var roomToPosting: NSSet?

}

// MARK: Generated accessors for roomToWorkingStatus
extension RoomEntity {

    @objc(addRoomToWorkingStatusObject:)
    @NSManaged public func addToRoomToWorkingStatus(_ value: WorkingStatusEntity)

    @objc(removeRoomToWorkingStatusObject:)
    @NSManaged public func removeFromRoomToWorkingStatus(_ value: WorkingStatusEntity)

    @objc(addRoomToWorkingStatus:)
    @NSManaged public func addToRoomToWorkingStatus(_ values: NSSet)

    @objc(removeRoomToWorkingStatus:)
    @NSManaged public func removeFromRoomToWorkingStatus(_ values: NSSet)

}

// MARK: Generated accessors for roomToPosting
extension RoomEntity {

    @objc(addRoomToPostingObject:)
    @NSManaged public func addToRoomToPosting(_ value: PostingEntity)

    @objc(removeRoomToPostingObject:)
    @NSManaged public func removeFromRoomToPosting(_ value: PostingEntity)

    @objc(addRoomToPosting:)
    @NSManaged public func addToRoomToPosting(_ values: NSSet)

    @objc(removeRoomToPosting:)
    @NSManaged public func removeFromRoomToPosting(_ values: NSSet)

}

extension RoomEntity : Identifiable {

}
