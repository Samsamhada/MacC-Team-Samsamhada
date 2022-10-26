//
//  ImageCell.swift
//  Samsam
//
//  Created by creohwan on 2022/10/24.
//

import UIKit

class PostingImageCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "PostingImageCell"

    // MARK: - View
    
    var preview: UIImageView = {
        $0.image = UIImage(named: "Test01")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
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
        self.addSubview(preview)
        
        preview.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
