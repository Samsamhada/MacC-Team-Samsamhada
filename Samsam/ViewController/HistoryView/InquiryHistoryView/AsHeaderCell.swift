//
//  AsHeaderCell.swift
//  Samsam
//
//  Created by creohwan on 2022/11/15.
//

import UIKit

class AsHeaderCell: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "ASHeaderCell"
    
    // MARK: - View
    
    private let contentView: UIView = {
        $0.backgroundColor = AppColor.unSelectedGray
        return $0
    }(UIView())
    
    private let progressDuration: UILabel = {
        $0.text = "AS 기간(~23. 11.12)"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private let remainingView: UIView = UIView()

    let remainingDay: UILabel = {
        $0.text = "152일"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = AppColor.campanulaBlue
        return $0
    }(UILabel())
    
    private let remainingText: UILabel = {
        $0.text = "남았어요"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }
    
    private func layout() {
        
        self.addSubview(contentView)
        contentView.addSubview(progressDuration)
        contentView.addSubview(remainingView)
        remainingView.addSubview(remainingDay)
        remainingView.addSubview(remainingText)
        
        contentView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        progressDuration.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            paddingTop: 15,
            paddingLeft: 15
        )
        
        remainingView.anchor(
            top: progressDuration.bottomAnchor,
            paddingTop: 15,
            width: 130,
            height: 25
        )
        remainingView.centerX(inView: contentView)
        
        remainingDay.anchor(
            left: remainingView.leftAnchor
        )
        remainingDay.centerY(inView: remainingView)
        
        remainingText.anchor(
            right: remainingView.rightAnchor
        )
        remainingText.centerY(inView: remainingView)
    }
}
