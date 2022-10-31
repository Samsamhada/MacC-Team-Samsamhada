//
//  WorkingHistoryViewFirstCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/31.
//

import UIKit

class WorkingHistoryViewTopCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "workingHistoryFirstCell"
    
    // MARK: - View
    
    let viewAll: UILabel = {
        $0.text = "전체보기"
        $0.textColor = .gray
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
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
        addSubview(viewAll)
        
        viewAll.anchor(
            top: topAnchor,
            right: rightAnchor,
            paddingTop: 16,
            paddingRight: 16
        )
    }
}
