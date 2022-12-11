//
//  CategoryCell.swift
//  Samsam
//
//  Created by creohwan on 2022/10/17.
//

import UIKit

enum ImageLiteral {
    static var planDrawing = "Plan"
    static var homeEntrance = "HomeEntrance"
    static var bathroom = "Bathroom"
    static var masterBedroom = "MasterBedroom"
    static var bigRoom = "BigRoom"
    static var smallRoom = "SmallRoom"
    static var livingRoom = "LivingRoom"
    static var veranda = "Veranda"
    static var kitchen = "Kitchen"
    static var utilityRoom = "UtilityRoom"
    static var etc = "ETC"
}

class CategoryCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "categoryCell"

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

    let categoryImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.planDrawing)
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())

    let gradientBackground: UIView = {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.4
        return $0
    }(UIView())

    let categoryName: UILabel = {
        $0.text = ""
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

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
        addSubview(categoryImage)
        addSubview(gradientBackground)
        addSubview(categoryName)
        
        categoryImage.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )

        gradientBackground.anchor(
            left: categoryImage.leftAnchor,
            bottom: categoryImage.bottomAnchor,
            right: categoryImage.rightAnchor,
            height: 32
        )

        categoryName.anchor(
            top: gradientBackground.topAnchor,
            left: gradientBackground.leftAnchor,
            bottom: gradientBackground.bottomAnchor,
            right: gradientBackground.rightAnchor
        )
    }
}
