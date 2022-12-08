//
//  RoomCreationViewWarrantyCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/08.
//

import UIKit

protocol RoomCreationViewWarrantyCellDelegate: AnyObject {
    func warrantyTimeChanged(warrantyTime: Int)
}

class RoomCreationViewWarrantyCell: UITableViewCell {

    // MARK: - Property

    weak var warrantyTimeDelegate: RoomCreationViewWarrantyCellDelegate?
    static let identifier = "roomCreationViewWarrantyCell"

    // MARK: - View

    let warrantyView: UIView = {
        return $0
    }(UIView())

    private let warrantyLabel: UILabel = {
        $0.text = "AS기간"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
        return $0
    }(UILabel())

    let warrantyText: UILabel = {
        $0.text = "12개월"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())

    let warrantyStepper: UIStepper = {
        $0.value = 12
        $0.maximumValue = 24
        $0.minimumValue = 0
        $0.wraps = true
        $0.autorepeat = true
        $0.addTarget(self, action: #selector(tapStepper), for: .touchUpInside)
        $0.addTarget(self, action: #selector(changeWarrantyTime), for: .touchUpInside)
        return $0
    }(UIStepper())

    var spacer: UIView = {
        return $0
    }(UIView())

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }

    // MARK: - Method

    private func layout() {
        self.addSubview(warrantyView)
        warrantyView.addSubview(warrantyLabel)
        warrantyView.addSubview(warrantyText)
        warrantyView.addSubview(warrantyStepper)
        warrantyView.addSubview(spacer)

        warrantyView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        warrantyView.setHeight(height: 50)

        warrantyLabel.anchor(
            top: warrantyView.topAnchor,
            left: warrantyView.leftAnchor,
            bottom: spacer.topAnchor
        )

        warrantyText.anchor(
            top: warrantyView.topAnchor,
            bottom: spacer.topAnchor,
            right: warrantyStepper.leftAnchor,
            paddingRight: 10
        )

        warrantyStepper.anchor(
            bottom: spacer.topAnchor,
            right: warrantyView.rightAnchor
        )

        spacer.anchor(
            left: warrantyView.leftAnchor,
            bottom: warrantyView.bottomAnchor,
            right: warrantyView.rightAnchor
        )
        spacer.setHeight(height: 18)
    }

    @objc private func tapStepper() {
        warrantyText.text = "\(Int(warrantyStepper.value))개월"
    }
    
    @objc private func changeWarrantyTime() {
        warrantyTimeDelegate?.warrantyTimeChanged(warrantyTime: Int(warrantyStepper.value))
    }
}
