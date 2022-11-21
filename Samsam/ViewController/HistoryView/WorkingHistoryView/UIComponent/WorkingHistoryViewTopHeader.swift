//
//  WorkingHistoryViewTopHeader.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewTopHeader: UICollectionReusableView {

    // MARK: - Property

    static let identifier = "workingHistoryTopHeader"

    // MARK: - View

    private let progressMetro: MetroViewController = {
        $0.view.backgroundColor = AppColor.unSelectedGray
        return $0
    }(MetroViewController())

    let progressDuration: UILabel = {
        $0.text = "진행상황(10.11 ~ 11.12)"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .gray
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
        self.addSubview(progressMetro.view)
        progressMetro.view.addSubview(progressDuration)

        progressMetro.view.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )

        progressDuration.anchor(
            top: progressMetro.view.topAnchor,
            left: progressMetro.view.leftAnchor,
            paddingTop: 16,
            paddingLeft: 16
        )
    }
}
