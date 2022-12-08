//
//  WorkingHistoryViewContentCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewContentCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "workingHistoryContentCell"

    // MARK: - View

    let uiImageView: UIImageView = {
        $0.image = UIImage(named: "GrayBox")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    let workTypeView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderColor = AppColor.campanulaBlue?.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())

    let workType: UILabel = {
        $0.text = "철거"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = AppColor.campanulaBlue
        return $0
    }(UILabel())

    private let descriptionCoverView: UIView = {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.7
        return $0
    }(UIView())
    
    let imageDescription: UILabel = {
        $0.text = ""
        $0.textColor = .white
        $0.textAlignment = .left
        $0.numberOfLines = 2
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
        addSubview(uiImageView)
        uiImageView.addSubview(workTypeView)
        workTypeView.addSubview(workType)
        uiImageView.addSubview(descriptionCoverView)
        addSubview(imageDescription)

        uiImageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )

        workTypeView.anchor(
            top: uiImageView.topAnchor,
            left: uiImageView.leftAnchor,
            paddingTop: 8,
            paddingLeft: 8
        )

        workType.anchor(
            top: workTypeView.topAnchor,
            left: workTypeView.leftAnchor,
            bottom: workTypeView.bottomAnchor,
            right: workTypeView.rightAnchor,
            paddingTop: 8,
            paddingLeft: 12,
            paddingBottom: 8,
            paddingRight: 12
        )

        descriptionCoverView.anchor(
            left: uiImageView.leftAnchor,
            bottom: uiImageView.bottomAnchor,
            right: uiImageView.rightAnchor
        )

        imageDescription.anchor(
            top: descriptionCoverView.topAnchor,
            left: descriptionCoverView.leftAnchor,
            bottom: descriptionCoverView.bottomAnchor,
            right: descriptionCoverView.rightAnchor,
            paddingTop: 12,
            paddingLeft: 12,
            paddingBottom: 12,
            paddingRight: 12
        )
    }
}
