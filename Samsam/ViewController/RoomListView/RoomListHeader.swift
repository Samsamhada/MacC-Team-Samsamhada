//
//  RoomListHeader.swift
//  Samsam
//
//  Created by creohwan on 2022/12/08.
//

import UIKit

class RoomListHeader: UICollectionReusableView {
    
    // MARK: - Property

    static let identifier = "RoomListHeader"

    // MARK: - View
    
    let mainText: UILabel = {
        $0.text = "시공 중인 고객"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
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
        self.addSubview(mainText)
        
        mainText.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 16
        )
    }
}
