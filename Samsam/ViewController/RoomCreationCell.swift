//
//  RoomCreationCell.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/19.
//

import UIKit

class RoomCreationCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "RoomCreationCell"
    
    // MARK: - View
    
    let creationButton: UIButton = {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .black
        $0.setTitle("고객 추가하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowRadius = 15
        return $0
    }(UIButton())
    
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
        addSubview(creationButton)
        
        creationButton.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
