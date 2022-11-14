//
//  InquiryCell.swift
//  Samsam
//
//  Created by creohwan on 2022/11/14.
//

import UIKit

class InquiryCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "InquiryCell"
    
    // MARK: - View
    
    let uiImageView: UIImageView = {
        $0.image = UIImage(named: "TestImage")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    let imageDescription: UILabel = {
        $0.text = "애플, 동아시아 최초 '디벨로퍼 아카데미' 한국서 운영"
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return $0
    }(UILabel())
    
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
    
    private let descriptionCoverView: UIView = {
        return $0
    }(UIView())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) 가 실행되지 않았습니다.")
    }
    
    // MARK: - Method
    
    private func layout() {
        addSubview(vStack)
        vStack.addArrangedSubview(uiImageView)
        vStack.addArrangedSubview(descriptionCoverView)
        descriptionCoverView.addSubview(imageDescription)
        
        vStack.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        uiImageView.anchor(
            top: vStack.topAnchor,
            left: vStack.leftAnchor,
            right: vStack.rightAnchor
        )
        
        uiImageView.heightAnchor.constraint(lessThanOrEqualToConstant: (UIScreen.main.bounds.width - 32) / 4 * 3).isActive = true
        
        descriptionCoverView.anchor(
            top: uiImageView.bottomAnchor,
            left: vStack.leftAnchor,
            bottom: vStack.bottomAnchor,
            right: vStack.rightAnchor
        )
        
        imageDescription.anchor(
            top: descriptionCoverView.topAnchor,
            left: descriptionCoverView.leftAnchor,
            bottom: descriptionCoverView.bottomAnchor,
            right: descriptionCoverView.rightAnchor,
            paddingTop: 6,
            paddingLeft: 6,
            paddingBottom: 6,
            paddingRight: 6
        )
        descriptionCoverView.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        imageDescription.setContentCompressionResistancePriority(UILayoutPriority(752), for: .vertical)
    }
}
