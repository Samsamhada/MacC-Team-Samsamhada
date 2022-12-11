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

    // MARK: - View
    
    private let backgroundUIView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    private let titleView: UIView = {
        return $0
    }(UIView())

    let roomTitle: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())

    let chipText: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .left
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
        
        addSubview(backgroundUIView)
        backgroundUIView.addSubview(titleView)
        titleView.addSubview(roomTitle)
        titleView.addSubview(chipText)
        backgroundUIView.addSubview(arrowImage)
        
        backgroundUIView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        titleView.anchor(
            top: backgroundUIView.topAnchor,
            left: backgroundUIView.leftAnchor,
            bottom: backgroundUIView.bottomAnchor,
            paddingLeft: 16
        )
        
        arrowImage.anchor(
            top: backgroundUIView.topAnchor,
            bottom: backgroundUIView.bottomAnchor,
            right: backgroundUIView.rightAnchor,
            paddingTop: 36,
            paddingBottom: 36,
            paddingRight: 16,
            width: 10
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
