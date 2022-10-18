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
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 10
        return $0
    }(UIStackView())
    
    private let leftSpacer: UIView = {
        $0.setWidth(width: 16)
        return $0
    }(UIView())
    
    private let rightSpacer: UIView = {
        $0.setWidth(width: 16)
        return $0
    }(UIView())
    
    private lazy var roomTitle: UILabel = {
        $0.text = "방 이름"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let detailStack: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let detailTopSpacer: UIView = {
        $0.setHeight(height: 20)
        return $0
    }(UIView())
    
    private let detailBottomSpacer: UIView = {
        $0.setHeight(height: 20)
        return $0
    }(UIView())
    
    private let detailCenterSpacer: UIView = {
        $0.setWidth(width: 10)
        return $0
    }(UIView())
    
    private let detailInfoStack: UIStackView = {
        $0.axis = .horizontal
        $0.setHeight(height: 50)
        return $0
    }(UIStackView())
    
    private let detailTitleStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .trailing
        $0.alignment = .bottom
        return $0
    }(UIStackView())
    
    private let detailContentStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .trailing
        return $0
    }(UIStackView())
    
    private let endDateTitle: UILabel = {
        $0.text = "시공일자"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private lazy var endDate: UILabel = {
        $0.text = "2022.10.17"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private let warrantyTimeTitle: UILabel = {
        $0.text = "준공예정"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private lazy var warrantyTime: UILabel = {
        $0.text = "2022.11.17"
        $0.font = UIFont.systemFont(ofSize: 16)
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
        
        roomStack.addArrangedSubview(leftSpacer)
        roomStack.addArrangedSubview(roomTitle)
        roomStack.addArrangedSubview(detailStack)
        roomStack.addArrangedSubview(rightSpacer)
        
        detailStack.addArrangedSubview(detailTopSpacer)
        detailStack.addArrangedSubview(detailInfoStack)
        detailStack.addArrangedSubview(detailBottomSpacer)
        
        detailInfoStack.addArrangedSubview(detailTitleStack)
        detailInfoStack.addArrangedSubview(detailCenterSpacer)
        detailInfoStack.addArrangedSubview(detailContentStack)
        
        detailTitleStack.addArrangedSubview(endDateTitle)
        detailTitleStack.addArrangedSubview(warrantyTimeTitle)
        
        detailContentStack.addArrangedSubview(endDate)
        detailContentStack.addArrangedSubview(warrantyTime)
        
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
        
        leftSpacer.anchor(
            top: roomStack.topAnchor,
            left: roomStack.leftAnchor,
            bottom: roomStack.bottomAnchor,
            right: roomTitle.leftAnchor
        )

        roomTitle.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: detailStack.leftAnchor
        )

        detailStack.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: rightSpacer.leftAnchor
        )
        
        rightSpacer.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: roomStack.rightAnchor
        )
        
        detailTopSpacer.anchor(
            top: detailStack.topAnchor,
            left: detailStack.leftAnchor,
            bottom: detailInfoStack.topAnchor,
            right: detailStack.rightAnchor
        )
        
        detailInfoStack.anchor(
            left: detailStack.leftAnchor,
            bottom: detailBottomSpacer.topAnchor,
            right: detailStack.rightAnchor
        )
        
        detailBottomSpacer.anchor(
            left: detailStack.leftAnchor,
            bottom: detailStack.bottomAnchor,
            right: detailStack.rightAnchor
        )
        
        detailTitleStack.anchor(
            top: detailInfoStack.topAnchor,
            left: detailInfoStack.leftAnchor,
            bottom: detailInfoStack.bottomAnchor,
            right: detailCenterSpacer.leftAnchor
        )
        
        detailCenterSpacer.anchor(
            top: detailInfoStack.topAnchor,
            bottom: detailInfoStack.bottomAnchor,
            right: detailContentStack.leftAnchor
        )
        
        detailContentStack.anchor(
            top: detailInfoStack.topAnchor,
            bottom: detailInfoStack.bottomAnchor,
            right: detailInfoStack.rightAnchor
        )
    }
}
