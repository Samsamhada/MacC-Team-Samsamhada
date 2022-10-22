//
//  CategoryEntity+CoreDataProperties.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/21.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var categoryID: Int32
    @NSManaged public var categoryName: String?
    @NSManaged public var categoryToWorkingStatus: NSSet?
    @NSManaged public var categoryToPosting: NSSet?

}

// MARK: Generated accessors for categoryToWorkingStatus
extension CategoryEntity {

    @objc(addCategoryToWorkingStatusObject:)
    @NSManaged public func addToCategoryToWorkingStatus(_ value: WorkingStatusEntity)

    @objc(removeCategoryToWorkingStatusObject:)
    @NSManaged public func removeFromCategoryToWorkingStatus(_ value: WorkingStatusEntity)

    @objc(addCategoryToWorkingStatus:)
    @NSManaged public func addToCategoryToWorkingStatus(_ values: NSSet)

    @objc(removeCategoryToWorkingStatus:)
    @NSManaged public func removeFromCategoryToWorkingStatus(_ values: NSSet)

}

// MARK: Generated accessors for categoryToPosting
extension CategoryEntity {

    @objc(addCategoryToPostingObject:)
    @NSManaged public func addToCategoryToPosting(_ value: PostingEntity)

    @objc(removeCategoryToPostingObject:)
    @NSManaged public func removeFromCategoryToPosting(_ value: PostingEntity)

    @objc(addCategoryToPosting:)
    @NSManaged public func addToCategoryToPosting(_ values: NSSet)

    @objc(removeCategoryToPosting:)
    @NSManaged public func removeFromCategoryToPosting(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
