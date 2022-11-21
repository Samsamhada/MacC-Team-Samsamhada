//
//  PostingImageButtonCell.swift
//  Samsam
//
//  Created by creohwan on 2022/11/03.
//

import UIKit

class PostingImageButtonCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "PostingImageButtonCell"

    // MARK: - View

    private var buttomImage: UIImageView = {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .light)
        $0.image = UIImage(systemName: "plus.circle", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        $0.clipsToBounds = true
        $0.contentMode = .center
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
        return $0
    }(UIImageView())

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method

    private func setupCell() {
        self.addSubview(buttomImage)

        buttomImage.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
