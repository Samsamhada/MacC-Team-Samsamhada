//
//  LoginViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/18.
//

import AuthenticationServices
import UIKit

class LoginViewController: UIViewController {

    // MARK: = Property
    
    private let loginService: LoginAPI = LoginAPI(apiService: APIService())
    
    // MARK: - View
    
    private let appLogo: UIImageView = {
        $0.image = UIImage(named: "AppIcon")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private lazy var authorizationButton: ASAuthorizationAppleIDButton = {
        $0.addTarget(self, action: #selector(tapAppleLoginButton), for: .touchUpInside)
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
        view.backgroundColor = AppColor.giwazipBlue
    }

    private func layout() {
        self.view.addSubview(appLogo)
        self.view.addSubview(authorizationButton)
        
        appLogo.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 50,
            height: UIScreen.main.bounds.width
        )

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

    @objc private func tapAppleLoginButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    private func requestLogin(LoginDTO: LoginDTO) {
        Task{
            do {
                let response = try await self.loginService.startAppleLogin(LoginDTO: LoginDTO)
                if let data = response {
                    guard let userIdentifier = data.userIdentifier,
                          let workerID = data.workerID
                    else {return}
                    UserDefaults.standard.setValue(userIdentifier, forKey: "userIdentifier")
                    UserDefaults.standard.setValue(workerID, forKey: "workerID")
                    if let number = data.number {
                        UserDefaults.standard.setValue(number, forKey: "number")
                    }
                }
                if UserDefaults.standard.string(forKey: "number") == nil {
                    self.navigationController?.pushViewController(PhoneNumViewController(), animated: true)
                } else {
                    self.navigationController?.pushViewController(RoomListViewController(), animated: true)
                }
                print(UserDefaults.standard.string(forKey: "number"))
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let personNameComponentsFormatter = PersonNameComponentsFormatter()

            let userIdentifier = appleIDCredential.user
            let name = personNameComponentsFormatter.string(from: appleIDCredential.fullName!)
            let userEmail = appleIDCredential.email
            let token = appleIDCredential.identityToken
            let code = appleIDCredential.authorizationCode
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    DispatchQueue.main.async {
                        let loginDTO = LoginDTO(code: code,
                                                token: token,
                                                name: name
                        )
                        self.requestLogin(LoginDTO: loginDTO)

                        UserDefaults.standard.setValue(token, forKey: "idToken")
                    }
                    break
                case .revoked:
                    // TODO: - UserIdentifier와 앱의 연결이 취소 되었을 때 처리
                    break
                case .notFound:
                    // TODO: - UserIdentifier와 앱의 연결을 찾을 수 없을 때 처리
                    break
                default:
                    break
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: - Error Handling
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
