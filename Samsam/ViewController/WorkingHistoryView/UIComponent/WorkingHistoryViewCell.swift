//
//  WorkingHistoryViewCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "workingHistory"
    
    // MARK: - View
    
    private let uiImageView: UIImageView = {
        $0.image = UIImage(named: "TestImage")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return $0
    }(UIImageView())
    
    let imageDescription: UILabel = {
        $0.text = "애플, 동아시아 최초 '디벨로퍼 아카데미' 한국서 운영"
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let workType: UIView = {
        return $0
    }(UIView())
    
    private let vStack: UIStackView = {
        $0.backgroundColor = .white
        $0.axis = .vertical
        $0.layer.masksToBounds = false
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 20
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) 가 실행되지 않았습니다.")
    }
    
    private func layout() {
        addSubview(vStack)
        vStack.addArrangedSubview(uiImageView)
        vStack.addArrangedSubview(imageDescription)
        
        vStack.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        uiImageView.anchor(
            top: vStack.topAnchor,
            left: vStack.leftAnchor,
            bottom: imageDescription.topAnchor,
            right: vStack.rightAnchor
        )
        
        imageDescription.anchor(
            left: vStack.leftAnchor,
            bottom: vStack.bottomAnchor,
            right: vStack.rightAnchor
        )
    }
}
