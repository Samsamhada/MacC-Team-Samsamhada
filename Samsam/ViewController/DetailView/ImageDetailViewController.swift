//
//  ImageDetailViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/25.
//

import UIKit

class ImageDetailViewController: UIViewController {

    // MARK: - Property
    
    var isCheckColor = true {
        didSet {
            if isCheckColor {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = .white
            }
        }
    }
    
    // MARK: - View

    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())

    var detailImage: UIImageView = {
        $0.image = UIImage(named: "GrayBox")
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
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )

        detailImage.anchor(
            top: scrollView.contentLayoutGuide.topAnchor,
            left: scrollView.contentLayoutGuide.leftAnchor,
            bottom: scrollView.contentLayoutGuide.bottomAnchor,
            right: scrollView.contentLayoutGuide.rightAnchor
        )
        detailImage.centerX(inView: scrollView)
    }

    private func attribute() {
        view.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(tapCloseButton)
        )
        
        let changedViewColorGesture = UITapGestureRecognizer(target: self, action: #selector(changedViewColor))
        scrollView.addGestureRecognizer(changedViewColorGesture)

        scrollView.delegate = self
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        
        detailImage.isUserInteractionEnabled = true
    }
    
    @objc func tapCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc func changedViewColor() {
        isCheckColor.toggle()
    }
}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let image = detailImage.image {

            view.backgroundColor = .black
            
            let changedWidth = detailImage.frame.width
            let changedHeight = detailImage.frame.height
            let fixedWidth = image.size.width
            let fixedHeight = image.size.height
            
            let ratioWidth = changedWidth / fixedWidth
            let ratioHeight = changedHeight / fixedHeight
            let ratio = (ratioWidth < ratioHeight) ? ratioWidth : ratioHeight
            
            let newWidth = fixedWidth * ratio
            let newHeight = fixedHeight * ratio
            
            let horizontalSide = 0.5 * (newWidth * scrollView.zoomScale > changedWidth ? (newWidth - changedWidth) : (scrollView.frame.width - scrollView.contentSize.width))
            let verticalSide = 0.5 * (newHeight * scrollView.zoomScale > changedHeight ? (newHeight - changedHeight) : (scrollView.frame.height - scrollView.contentSize.height))
            
            scrollView.contentInset = UIEdgeInsets(top: verticalSide, left: horizontalSide, bottom: verticalSide, right: horizontalSide)
        }
    }
}
