//
//  Gradient+.swift
//  Samsam
//
//  Created by 지준용 on 2022/12/10.
//

import UIKit

extension UIView {
    func setColorsGradient(startColor: UIColor, mediumColor: UIColor, lastColor: UIColor) {
        clipsToBounds = true
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [startColor.cgColor, mediumColor.cgColor, lastColor.cgColor]
        gradient.locations = [0.0, 0.2, 0.5]
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
