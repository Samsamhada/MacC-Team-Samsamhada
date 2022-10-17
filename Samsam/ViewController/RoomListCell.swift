//
//  RoomListCell.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class RoomListCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "RoomListCell"
    
    // MARK: - View
    
    private let cellStack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let roomStack: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 16
        return $0
    }(UIStackView())
    
    private lazy var roomTitle: UILabel = {
        $0.text = "방 이름"
        return $0
    }(UILabel())
    
    private let detailStack: UIStackView = {
        $0.axis = .vertical
        $0.setWidth(width: 200)
        return $0
    }(UIStackView())
    
//    private let endDateTitle: UILabel = {
//        $0.text = "준공예정일"
//        return $0
//    }(UILabel())
    
    private lazy var endDate: UILabel = {
        $0.text = "준공예정일 " + "2022.10.17"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
//    private let warrantyTimeTitle: UILabel = {
//        $0.text = "AS기간"
//        return $0
//    }(UILabel())
    
    private lazy var warrantyTime: UILabel = {
        $0.text = "AS기간 " + "12개월"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupCell() {
        addSubview(cellStack)
        
        cellStack.addArrangedSubview(roomStack)
        
        roomStack.addArrangedSubview(roomTitle)
        roomStack.addArrangedSubview(detailStack)
        
        detailStack.addArrangedSubview(endDate)
        detailStack.addArrangedSubview(warrantyTime)
        
        cellStack.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        roomStack.anchor(
            top: cellStack.topAnchor,
            left: cellStack.leftAnchor,
            bottom: cellStack.bottomAnchor,
            right: cellStack.rightAnchor
        )

        roomTitle.anchor(
            top: roomStack.topAnchor,
            left: roomStack.leftAnchor,
            bottom: roomStack.bottomAnchor,
            right: detailStack.leftAnchor,
            paddingLeft: 16
        )

        detailStack.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: roomStack.rightAnchor,
            paddingRight: 16
        )

        endDate.anchor(
            top: detailStack.topAnchor,
            left: detailStack.leftAnchor,
            bottom: warrantyTime.topAnchor,
            right: detailStack.rightAnchor
        )

        warrantyTime.anchor(
            left: detailStack.leftAnchor,
            bottom: detailStack.bottomAnchor,
            right: detailStack.rightAnchor
        )
    }
}
