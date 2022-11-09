//
//  RoomCreationViewStartDateHeader.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/08.
//

import UIKit

class RoomCreationViewDateHeader: UITableViewCell {
    
    // MARK: - Property
    
    static let identifier = "roomCreationViewDateHeader"
    
    // MARK: - View
    
    let dateView: UIView = {
        return $0
    }(UIView())
    
    let dateLabel: UILabel = {
        $0.text = "시공일"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
        return $0
    }(UILabel())
    
    private let dateFrame: UIView = {
        $0.backgroundColor = AppColor.buttonGray
        $0.layer.cornerRadius = 8
        return $0
    }(UIView())
    
    lazy var dateButton: UILabel = {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }
    
    // MARK: - Method
    
    private func layout() {
        self.addSubview(dateView)
        dateView.addSubview(dateLabel)
        dateView.addSubview(dateFrame)
        dateFrame.addSubview(dateButton)
        
        dateView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        dateLabel.anchor(
            top: dateView.topAnchor,
            left: dateView.leftAnchor,
            bottom: dateView.bottomAnchor
        )
        
        dateFrame.anchor(
            top: dateView.topAnchor,
            bottom: dateView.bottomAnchor,
            right: dateView.rightAnchor
        )
        
        dateButton.anchor(
            left: dateFrame.leftAnchor,
            right: dateFrame.rightAnchor,
            paddingLeft: 10,
            paddingRight: 10
        )
        dateButton.centerY(inView: dateFrame)
    }
}
