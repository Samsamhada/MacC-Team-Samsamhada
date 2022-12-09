//
//  CategoryCell.swift
//  Samsam
//
//  Created by creohwan on 2022/10/17.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "categoryCell"

    enum ImageLiteral {
        static var noCheck = "category1"
        static var Check = "category2"
        
        static var planDrawing = "Plan"
        static var homeEntrance = "HomeEntrance"
        static var bathRoom = "Bathroom"
        static var masterBedroom = "MasterBedroom"
        static var bigRoom = "BigRoom"
        static var smallRoom = "SmallRoom"
        static var livingRoom = "LivingRoom"
        static var veranda = "Veranda"
        static var kitchen = "Kitchen"
        static var utilityRoom = "UtilityRoom"
        static var etc = "ETC"
    }

    override var isSelected: Bool{
        didSet {
            if isSelected {
                self.categoryImage.image = UIImage(named: ImageLiteral.Check)
            } else {
                self.categoryImage.image = UIImage(named: ImageLiteral.noCheck)
            }
        }
    }

    // MARK: - View

    var categoryImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.noCheck)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    let categoryTitle: UILabel = {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    let vStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())

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
        self.addSubview(vStackView)

        vStackView.addArrangedSubview(categoryImage)
        vStackView.addArrangedSubview(categoryTitle)

        vStackView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )

        categoryImage.anchor(
            top: vStackView.topAnchor,
            left: vStackView.leftAnchor,
            bottom: categoryTitle.topAnchor,
            right: vStackView.rightAnchor
        )

        categoryTitle.anchor(
            left: vStackView.leftAnchor,
            bottom: vStackView.bottomAnchor,
            right: vStackView.rightAnchor
        )
    }
}
