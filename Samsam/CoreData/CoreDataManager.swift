//
//  CoreDataManager.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/23.
//

import CoreData
import Foundation
import UIKit

enum Category: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case thirteen = 13
    case fourteen = 14
    case fifteen = 15
    
    func categoryName() -> String {
        switch self {
        case .zero:
            return "실측"
        case .one:
            return "철거"
        case .two:
            return "설비"
        case .three:
            return "새시"
        case .four:
            return "목공"
        case .five:
            return "전기"
        case .six:
            return "페인트"
        case .seven:
            return "필름"
        case .eight:
            return "타일"
        case .nine:
            return "욕실"
        case .ten:
            return "마루"
        case .eleven:
            return "도배"
        case .twelve:
            return "주방"
        case .thirteen:
            return "폴딩도어"
        case .fourteen:
            return "조명"
        case .fifteen:
            return "기타"
        }
    }
}

class CoreDataManager {
    
    // MARK: - Property
    
    @Published var rooms = [RoomEntity]()
    @Published var workingStatuses = [WorkingStatusEntity]()
    @Published var postings = [PostingEntity]()
    @Published var photos = [PhotoEntity]()
    
    @Published var oneRoom: RoomEntity?
    
    // MARK: - Create Method
    
    func createRoomData(clientName: String, startDate: Date, endDate: Date, warrantyTime: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let roomEntity = NSEntityDescription.entity(forEntityName: "RoomEntity", in: context)
        
        if let roomEntity = roomEntity {
            let room = NSManagedObject(entity: roomEntity, insertInto: context)
            room.setValue(coreDataManager.countData(dataType: "room"), forKey: "roomID")
            room.setValue(clientName, forKey: "clientName")
            room.setValue(startDate, forKey: "startDate")
            room.setValue(endDate, forKey: "endDate")
            room.setValue(warrantyTime, forKey: "warrantyTime")
            // 방상태 어떻게 하더라?
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createWorkingStatusData(roomID: Int, categoryID: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let workingStatusEntity = NSEntityDescription.entity(forEntityName: "WorkingStatusEntity", in: context)
        
        if let workingStatusEntity = workingStatusEntity {
            let workingStatus = NSManagedObject(entity: workingStatusEntity, insertInto: context)
            workingStatus.setValue(coreDataManager.countData(dataType: "workingStatus"), forKey: "statusID")
            workingStatus.setValue(roomID, forKey: "roomID")
            workingStatus.setValue(categoryID, forKey: "categoryID")
            workingStatus.setValue(0, forKey: "status")
            // 0: 시작안함, 1: 진행중, 2: 완료, 3: 삭제
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createPostingData(roomID: Int, categoryID: Int, explanation: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let postingEntity = NSEntityDescription.entity(forEntityName: "PostingEntity", in: context)
        
        if let postingEntity = postingEntity {
            let posting = NSManagedObject(entity: postingEntity, insertInto: context)
            posting.setValue(coreDataManager.countData(dataType: "posting"), forKey: "postingID")
            posting.setValue(roomID, forKey: "roomID")
            posting.setValue(categoryID, forKey: "categoryID")
            posting.setValue(explanation, forKey: "explanation")
            posting.setValue(Date(), forKey: "createDate")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createPhotoData(postingID: Int, photoPath: Data) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let photoEntity = NSEntityDescription.entity(forEntityName: "PhotoEntity", in: context)
        
        if let photoEntity = photoEntity {
            let photo = NSManagedObject(entity: photoEntity, insertInto: context)
            photo.setValue(coreDataManager.countData(dataType: "photo"), forKey: "photoID")
            photo.setValue(postingID, forKey: "postingID")
            photo.setValue(photoPath, forKey: "photoPath")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Update Method
    
    func updateRoomData(room: RoomEntity, clientName: String, startDate: Date, endDate: Date, warrantyTime: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        room.clientName = clientName
        room.startDate = startDate
        room.endDate = endDate
        room.warrantyTime = Int32(warrantyTime)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - Load Method
    
    
    // MARK: - Count Method
    
}
