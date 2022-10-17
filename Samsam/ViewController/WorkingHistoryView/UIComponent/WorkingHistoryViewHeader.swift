//
//  WorkingHistoryViewHeader.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "workingHistoryHeader"
    
    // MARK: - View
    
    let uploadDate: UILabel = {
        $0.text = "0월 0일"
        $0.textAlignment = .center
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
        addSubview(uploadDate)
        
        uploadDate.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
