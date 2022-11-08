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
        $0.textColor = .black
        return $0
    }(UILabel())
    
    let dateButton: UILabel = {
        $0.text = "2022.11.11."
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
    
    private func layout() {
        self.addSubview(dateView)
        dateView.addSubview(dateLabel)
        dateView.addSubview(dateButton)
        
        dateLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor
        )
        
        dateButton.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
