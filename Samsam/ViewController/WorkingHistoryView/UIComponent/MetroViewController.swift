//
//  MetroViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/04.
//

import UIKit

class MetroViewController: UIViewController {
    
    let bezierPath = UIBezierPath()
    let data = [CGPoint(x: 30 + 330/6.5 * 0, y: 50),
                CGPoint(x: 30 + 330/6.5 * 1, y: 50),
                CGPoint(x: 30 + 330/6.5 * 2, y: 50),
                CGPoint(x: 30 + 330/6.5 * 3, y: 50),
                CGPoint(x: 30 + 330/6.5 * 4, y: 50),
                CGPoint(x: 30 + 330/6.5 * 5, y: 50),
                CGPoint(x: 30 + 330/6.5 * 6, y: 50),
                CGPoint(x: 30 + 330/6.5 * 6, y: 50),
                CGPoint(x: 30 + 330/7 * 7, y: 65),
                CGPoint(x: 30 + 330/6.5 * 6, y: 80),
                CGPoint(x: 30 + 330/6.5 * 6, y: 80),
                CGPoint(x: 30 + 330/6.5 * 5, y: 80),
                CGPoint(x: 30 + 330/6.5 * 4, y: 80),
                CGPoint(x: 30 + 330/6.5 * 3, y: 80),
                CGPoint(x: 30 + 330/6.5 * 2, y: 80),
                CGPoint(x: 30 + 330/6.5 * 1, y: 80),
                CGPoint(x: 30 + 330/6.5 * 0, y: 80) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = BezierConfiguration()
        let controlPoints = config.configureControlPoints(data: data)
        
        for i in 0..<data.count {
            let point = data[i]
            if i == 0 {
                bezierPath.move(to: point)
            }else {
                let segment = controlPoints[i - 1]
                bezierPath.addCurve(to: point, controlPoint1: segment.firstControlPoint, controlPoint2: segment.secondControlPoint)
            }
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = AppColor.campanulaBlue?.cgColor
        shapeLayer.fillColor = .none
        shapeLayer.lineCap = .round
        view.layer.addSublayer(shapeLayer)
        
        createPoints()
    }
    
    func createPoints() {
        for point in data {
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = UIColor.yellow.cgColor
            circleLayer.position = point
            view.layer.addSublayer(circleLayer)
        }
    }
}

