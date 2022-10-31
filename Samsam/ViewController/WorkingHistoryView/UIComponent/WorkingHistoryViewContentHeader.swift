//
//  WorkingHistoryViewSecondHeader.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/31.
//

import UIKit

class WorkingHistoryViewContentHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "workingHistorySecondHeader"
    
    // MARK: - View
    
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
        
        self.addSubview(leftLine)
        self.addSubview(uploadDate)
        self.addSubview(rightLine)
        
        leftLine.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: uploadDate.leftAnchor,
            paddingTop: 34.5,
            paddingBottom: 34.5,
            width: UIScreen.main.bounds.width/3
        )
        
        uploadDate.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            width: UIScreen.main.bounds.width/3
        )
        
        rightLine.anchor(
            top: topAnchor,
            left: uploadDate.rightAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 34.5,
            paddingBottom: 34.5,
            width: UIScreen.main.bounds.width/3
        )
    }
}

