//
//  ImageCell.swift
//  Samsam
//
//  Created by creohwan on 2022/10/24.
//

import UIKit

class PostingImageCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "ImageCell"
    
    // MARK: - View
    
    var cellImage: UIImageView = {
        $0.image = UIImage(named: "Test01")
        $0.contentMode = .scaleAspectFit
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
        self.addSubview(cellImage)
        
        cellImage.anchor(
            left: leftAnchor,
            right: rightAnchor
        )
    }
}
