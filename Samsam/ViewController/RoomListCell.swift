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

    let roomStack: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowRadius = 15
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

    var roomTitle: UILabel = {
        $0.text = "방 이름"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())

    let chipText: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let startDate: UILabel = {
        $0.text = "2022.10.17"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    let endDate: UILabel = {
        $0.text = "2022.11.17"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private let arrowImage: UIImageView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
        $0.image = UIImage(systemName: "chevron.right", withConfiguration: imageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return $0
    }(UIImageView())

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
        roomStack.addArrangedSubview(arrowImage)
        roomStack.addArrangedSubview(rightSpacer)

        titleView.addSubview(roomTitle)
        titleView.addSubview(chipText)

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
            left: leftSpacer.rightAnchor,
            bottom: roomStack.bottomAnchor
        )
        
        arrowImage.anchor(
            top: roomStack.topAnchor,
            left: titleView.rightAnchor,
            bottom: roomStack.bottomAnchor,
            paddingTop: 36,
            paddingBottom: 36,
            width: 10
        )
        
        rightSpacer.anchor(
            top: roomStack.topAnchor,
            left: arrowImage.rightAnchor,
            bottom: roomStack.bottomAnchor,
            right: roomStack.rightAnchor
        )

        roomTitle.anchor(
            left: titleView.leftAnchor,
            bottom: chipText.topAnchor,
            right: titleView.rightAnchor,
            paddingBottom: 10
        )

        chipText.anchor(
            left: titleView.leftAnchor,
            bottom: titleView.bottomAnchor,
            right: titleView.rightAnchor,
            paddingBottom: 10
        )

        chipText.rightAnchor.constraint(lessThanOrEqualTo: titleView.rightAnchor, constant: 0).isActive = true
    }
}
