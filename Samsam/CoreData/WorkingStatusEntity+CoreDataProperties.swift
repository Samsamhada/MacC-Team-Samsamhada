//
//  WorkingStatusEntity+CoreDataProperties.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/21.
//
//

import Foundation
import CoreData


extension WorkingStatusEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkingStatusEntity> {
        return NSFetchRequest<WorkingStatusEntity>(entityName: "WorkingStatusEntity")
    }

    @NSManaged public var categoryID: Int32
    @NSManaged public var roomID: Int32
    @NSManaged public var status: Int32
    @NSManaged public var statusID: Int32
    @NSManaged public var workingStatusToCategory: CategoryEntity?
    @NSManaged public var workingStatusToRoom: RoomEntity?

}

extension WorkingStatusEntity : Identifiable {

}
