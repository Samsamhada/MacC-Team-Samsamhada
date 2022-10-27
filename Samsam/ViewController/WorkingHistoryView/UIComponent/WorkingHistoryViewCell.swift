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
    
    let uiImageView: UIImageView = {
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
    
    private let workTypeView: UIView = {
        $0.backgroundColor = .purple
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    let workType: UILabel = {
        $0.text = "철거"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .white
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
        uiImageView.addSubview(workTypeView)
        workTypeView.addSubview(workType)
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
        
        workTypeView.anchor(
            top: uiImageView.topAnchor,
            left: uiImageView.leftAnchor,
            paddingTop: 8,
            paddingLeft: 8
        )
        
        workType.anchor(
            top: workTypeView.topAnchor,
            left: workTypeView.leftAnchor,
            bottom: workTypeView.bottomAnchor,
            right: workTypeView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 12,
            paddingBottom: 8,
            paddingRight: 12
        )
        
        imageDescription.anchor(
            left: vStack.leftAnchor,
            bottom: vStack.bottomAnchor,
            right: vStack.rightAnchor
        )
    }
}
