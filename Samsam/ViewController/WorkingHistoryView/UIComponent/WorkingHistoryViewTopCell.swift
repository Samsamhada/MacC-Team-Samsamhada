//
//  WorkingHistoryViewFirstCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/31.
//

import UIKit

class WorkingHistoryViewTopCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "workingHistoryTopCell"
    
    // MARK: - View
    
    let viewAll: UIButton = {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.titleLabel?.textAlignment = .right
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.tintColor = .gray
        return $0
    }(UIButton())
    
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
