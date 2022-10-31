//
//  WorkingHistoryViewHeader.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewTopHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "workingHistoryTopHeader"
    
    // MARK: - View
    
    let progressMetro: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    
    let progressDuration: UILabel = {
        $0.text = "진행상황(10.11 ~ 11.12)"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    let uploadDate: UILabel = {
        $0.text = "0월 0일"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
        return $0
    }(UILabel())

    let leftLine: UIView = {
        $0.backgroundColor = .gray
        $0.setHeight(height: 1)
        return $0
    }(UIView())
    
    let rightLine: UIView = {
        $0.backgroundColor = .gray
        $0.setHeight(height: 1)
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }
    
    private func layout() {
        
        self.addSubview(progressMetro)
        progressMetro.addSubview(progressDuration)
        self.addSubview(leftLine)
        self.addSubview(uploadDate)
        self.addSubview(rightLine)
        
        progressMetro.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        progressDuration.anchor(
            top: progressMetro.topAnchor,
            left: progressMetro.leftAnchor,
            paddingTop: 16,
            paddingLeft: 16
        )
    }
}
