//
//  ImageDetailViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/25.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    private var isTapped = false
    
    // MARK: - View
    
    private let uiView: UIView = {
        return $0
    }(UIView())
    
    private let detailImage: UIImageView = {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    // MARK: - Method
    
    private func layout() {
        view.addSubview(detailImage)

        detailImage.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func attribute() {
        view.backgroundColor = .white
        navigationItem.title = "화장실"

        detailImage.isUserInteractionEnabled = true

        let didPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchGesture))
        detailImage.addGestureRecognizer(didPinchGesture)

        let didDoubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapGesture))
        didDoubleTapGesture.numberOfTapsRequired = 2
        detailImage.addGestureRecognizer(didDoubleTapGesture)

        let didPanGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanGesture))
        detailImage.addGestureRecognizer(didPanGesture)
    }
    
    @objc private func didPinchGesture(_ sender: UIPinchGestureRecognizer) {
        detailImage.transform = detailImage.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
        detailImage.center = view.center
    }
    
    @objc private func didDoubleTapGesture() {
        isTapped.toggle()

        if isTapped {
            detailImage.contentMode = .scaleAspectFill
        } else {
            detailImage.contentMode = .scaleAspectFit
        }
        detailImage.center = view.center
    }
    
    @objc private func didPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
}
