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
        $0.backgroundColor = .blue
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(uiView)
        
        uiView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
}
