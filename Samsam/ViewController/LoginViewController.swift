//
//  LoginViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/18.
//

import AuthenticationServices
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - URL Session
    
    func requestPOSTWithURL(url: String, parameters: [String: Any]) {
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        let requestBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestBody
        
        let defaultSession = URLSession(configuration: .default)
        
        defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                print("Error occur: error calling POST - \(String(describing: error))")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                print("json")
                print(json)
            }
        }.resume()
    }
    
    func setLoginParameters(userIdentifier: String, name: String, email: String) -> [String: Any] {
        return [ "userIdentifier": "\(userIdentifier)", "name": "\(name)", "email": "\(email)"]
    }

    // MARK: - View
    
    private lazy var authorizationButton: ASAuthorizationAppleIDButton = {
        $0.addTarget(self, action: #selector(login), for: .touchUpInside)
        return $0
    }(ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline))
    
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
    
    @objc private func login() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    DispatchQueue.main.async {
                        self.requestPOSTWithURL(url: "http://3.39.76.231:3000/giwazip/workers", parameters: self.setLoginParameters(userIdentifier: userIdentifier, name: userLastName!+userFirstName!, email: userEmail!))
                        
                        // TODO: - get -> post : token 받아오기!!!
                        self.navigationController?.pushViewController(PhoneNumViewController(), animated: true)
                    }
                    break
                case .revoked:
                    break
                case .notFound:
                    break
                default:
                    break
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
