//
//  InquiryHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/01.
//

import UIKit

class InquiryHistoryViewController: UIViewController {
    
    // MARK: - View
    
    private let uiView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
    }
    
    // MARK: - Layout
    
    private func layout() {
        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}
