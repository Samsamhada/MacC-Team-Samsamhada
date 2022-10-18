//
//  LoginViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/18.
//

import AuthenticationServices
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - View
    
    private let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
    }
    
    private func layout() {
        self.view.addSubview(authorizationButton)
        
        authorizationButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16,
            height: 50
        )
    }
}
