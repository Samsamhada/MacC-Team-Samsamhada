//
//  ImageDetailViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/25.
//

import UIKit

class ImageDetailViewController: UIViewController {

    // MARK: - View

    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())

    let detailImage: UIImageView = {
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
        view.addSubview(scrollView)
        scrollView.addSubview(detailImage)

        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )

        detailImage.anchor(
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor
        )
        detailImage.centerX(inView: scrollView)
    }

    private func attribute() {
        view.backgroundColor = .white
        navigationItem.title = "화장실"

        scrollView.delegate = self
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false

        detailImage.isUserInteractionEnabled = true
        let didPanGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanGesture))
        detailImage.addGestureRecognizer(didPanGesture)
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

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImage
    }
}
