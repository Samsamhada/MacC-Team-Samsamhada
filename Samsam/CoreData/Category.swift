//
//  Category.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/23.
//

import Foundation

enum Category: Int, CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
    case thirteen
    case fourteen
    case fifteen
    case sixteen
    
    func categoryName() -> String {
        switch self {
        case .one:
            return "도면"
        case .two:
            return "현관"
        case .three:
            return "욕실"
        case .four:
            return "안방"
        case .five:
            return "큰방"
        case .six:
            return "작은방"
        case .seven:
            return "거실"
        case .eight:
            return "베란다"
        case .nine:
            return "주방"
        case .ten:
            return "다용도실"
        case .eleven:
            return "기타"
        default:
            return "삭제예정"
        }
    }
    
    func categoryImage() -> String {
        switch self {
        case .one:
            return ImageLiteral.planDrawing
        case .two:
            return ImageLiteral.homeEntrance
        case .three:
            return ImageLiteral.bathroom
        case .four:
            return ImageLiteral.masterBedroom
        case .five:
            return ImageLiteral.bigRoom
        case .six:
            return ImageLiteral.smallRoom
        case .seven:
            return ImageLiteral.livingRoom
        case .eight:
            return ImageLiteral.veranda
        case .nine:
            return ImageLiteral.kitchen
        case .ten:
            return ImageLiteral.utilityRoom
        case .eleven:
            return ImageLiteral.etc
        default:
            return ImageLiteral.etc
        }
    }
}
