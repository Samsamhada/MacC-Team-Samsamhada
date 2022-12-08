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
                view.backgroundColor = .white
            } else {
                view.backgroundColor = .black
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
        detailImage.centerY(inView: scrollView)
    }

    private func attribute() {
        view.backgroundColor = .white
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
        view.backgroundColor = .black
        self.scrollView.moveToCenter()
    }
}

extension UIScrollView {
    func moveToCenter(){
        let contentWidth = self.contentSize.width;
        let x = self.bounds.width - contentWidth;
        
        let contentHeight = self.contentSize.height;
        let y = self.bounds.height - contentHeight;
        
        guard x > 0 || y > 0 else{
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            return;
        }
        
        self.contentInset = UIEdgeInsets(top: y / 2, left: x / 2, bottom: 0, right: 0);
    }
}
