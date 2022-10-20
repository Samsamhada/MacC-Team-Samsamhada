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
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowRadius = 15
        $0.layer.borderColor = UIColor.blue.cgColor
        $0.layer.borderWidth = 1
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
    
    private let titleView: UIView = {
        return $0
    }(UIView())
    
    private lazy var roomTitle: UILabel = {
        $0.text = "방 이름"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel())
    
    private let chipShape: UIView = {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .blue
        return $0
    }(UIView())
    
    private lazy var chipText: UILabel = {
        $0.text = "AS기간"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let dateStack: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let dateTopSpacer: UIView = {
        $0.setHeight(height: 20)
        return $0
    }(UIView())
    
    private let dateBottomSpacer: UIView = {
        $0.setHeight(height: 20)
        return $0
    }(UIView())
    
    private let dateCenterSpacer: UIView = {
        $0.setWidth(width: 10)
        return $0
    }(UIView())
    
    private let dateInfoStack: UIStackView = {
        $0.axis = .horizontal
        $0.setHeight(height: 50)
        return $0
    }(UIStackView())
    
    private let dateTitleStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .trailing
        return $0
    }(UIStackView())
    
    private let dateContentStack: UIStackView = {
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
        roomStack.addArrangedSubview(titleView)
        roomStack.addArrangedSubview(dateStack)
        roomStack.addArrangedSubview(rightSpacer)
        
        titleView.addSubview(roomTitle)
        titleView.addSubview(chipShape)
        
        chipShape.addSubview(chipText)
        
        dateStack.addArrangedSubview(dateTopSpacer)
        dateStack.addArrangedSubview(dateInfoStack)
        dateStack.addArrangedSubview(dateBottomSpacer)
        
        dateInfoStack.addArrangedSubview(dateTitleStack)
        dateInfoStack.addArrangedSubview(dateCenterSpacer)
        dateInfoStack.addArrangedSubview(dateContentStack)
        
        dateTitleStack.addArrangedSubview(endDateTitle)
        dateTitleStack.addArrangedSubview(warrantyTimeTitle)
        
        dateContentStack.addArrangedSubview(endDate)
        dateContentStack.addArrangedSubview(warrantyTime)
        
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
            right: titleView.leftAnchor
        )
        
        titleView.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: dateStack.leftAnchor
        )

        roomTitle.anchor(
            left: titleView.leftAnchor,
            bottom: chipShape.topAnchor,
            right: titleView.rightAnchor,
            paddingBottom: 10
        )
        
        chipShape.anchor(
            left: titleView.leftAnchor,
            bottom: titleView.bottomAnchor,
            right: titleView.rightAnchor,
            paddingBottom: 10
        )
        
        chipText.anchor(
            top: chipShape.topAnchor,
            left: chipShape.leftAnchor,
            bottom: chipShape.bottomAnchor,
            right: chipShape.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )

        dateStack.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: rightSpacer.leftAnchor
        )
        
        rightSpacer.anchor(
            top: roomStack.topAnchor,
            bottom: roomStack.bottomAnchor,
            right: roomStack.rightAnchor
        )
        
        dateTopSpacer.anchor(
            top: dateStack.topAnchor,
            left: dateStack.leftAnchor,
            bottom: dateInfoStack.topAnchor,
            right: dateStack.rightAnchor
        )
        
        dateInfoStack.anchor(
            left: dateStack.leftAnchor,
            bottom: dateBottomSpacer.topAnchor,
            right: dateStack.rightAnchor
        )
        
        dateBottomSpacer.anchor(
            left: dateStack.leftAnchor,
            bottom: dateStack.bottomAnchor,
            right: dateStack.rightAnchor
        )
        
        dateTitleStack.anchor(
            top: dateInfoStack.topAnchor,
            left: dateInfoStack.leftAnchor,
            bottom: dateInfoStack.bottomAnchor,
            right: dateCenterSpacer.leftAnchor
        )
        
        dateCenterSpacer.anchor(
            top: dateInfoStack.topAnchor,
            bottom: dateInfoStack.bottomAnchor,
            right: dateContentStack.leftAnchor
        )
        
        dateContentStack.anchor(
            top: dateInfoStack.topAnchor,
            bottom: dateInfoStack.bottomAnchor,
            right: dateInfoStack.rightAnchor
        )
    }
}
