//
//  CoreDataManager.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/23.
//

import CoreData
import Foundation
import UIKit

enum Category: Int, CaseIterable {
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
            return "도면"
        case .one:
            return "현관"
        case .two:
            return "화장실"
        case .three:
            return "배란다"
        case .four:
            return "거실"
        case .five:
            return "안방"
        case .six:
            return "큰방"
        case .seven:
            return "작은방"
        case .eight:
            return "부엌"
        case .nine:
            return "다용도실"
        case .ten:
            return "기타"
        case .eleven:
            return "a"
        case .twelve:
            return "b"
        case .thirteen:
            return "c"
        case .fourteen:
            return "d"
        case .fifteen:
            return "e"
        }
    }
}

        }
    }
    
    // MARK: - Count Method
    
    func countData(dataType: String) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            switch(dataType) {
            case "room":
                return try context.fetch(RoomEntity.fetchRequest()).count
            case "workingStatus":
                return try context.fetch(WorkingStatusEntity.fetchRequest()).count
            case "posting":
                return try context.fetch(PostingEntity.fetchRequest()).count
            case "photo":
                return try context.fetch(PhotoEntity.fetchRequest()).count
            default:
                return 0
            }
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
}
