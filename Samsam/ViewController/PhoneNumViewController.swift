//
//  PhoneNumViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/18.
//

import UIKit

class PhoneNumViewController: UIViewController {
    
    // MARK: - Property

    private var phoneNum = ""
    private let loginService: LoginAPI = LoginAPI(apiService: APIService())

    // MARK: - View

    private let uiView: UIView = {
        return $0
    }(UIView())

    private let numberLabel: UILabel = {
        $0.text = "담당자 연락처를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())

    private let hStack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())

    private let startNumber: UILabel = {
        $0.text = "010 - "
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())

    private lazy var numberInput: CustomUITextField = {
        $0.placeholder = "1234 - 5678"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.keyboardType = .numberPad
        $0.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
        return $0
    }(CustomUITextField())

    private let inputUnderLine: UIView = {
        $0.setHeight(height: 1)
        $0.backgroundColor = .gray
        return $0
    }(UIView())

    private lazy var submitButton: UIButton = {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setHeight(height: 50)
        $0.layer.cornerRadius = 16
        $0.isEnabled = false
        $0.backgroundColor = .gray
        $0.addTarget(self, action: #selector(tapSubmitButton), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidekeyboardWhenTappedAround()
        attribute()
        layout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white
    }

    private func layout() {
        view.addSubview(uiView)

        uiView.addSubview(numberLabel)
        uiView.addSubview(hStack)
        hStack.addArrangedSubview(startNumber)
        hStack.addArrangedSubview(numberInput)
        uiView.addSubview(inputUnderLine)
        uiView.addSubview(submitButton)

        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )

        numberLabel.anchor(
            left: uiView.leftAnchor,
            bottom: hStack.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 20
        )

        hStack.anchor(
            left: uiView.leftAnchor,
            bottom: inputUnderLine.topAnchor,
            right: uiView.rightAnchor
        )

        startNumber.anchor(
            top: hStack.topAnchor,
            left: hStack.leftAnchor,
            bottom: hStack.bottomAnchor,
            right: numberInput.leftAnchor
        )

        numberInput.anchor(
            top: hStack.topAnchor,
            bottom: hStack.bottomAnchor,
            right: hStack.rightAnchor
        )

        inputUnderLine.anchor(
            left: uiView.leftAnchor,
            bottom: submitButton.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 30
        )

        submitButton.anchor(
            left: uiView.leftAnchor,
            bottom: view.keyboardLayoutGuide.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 20
        )
    }
    
    @objc private func buttonAttributeChanged() {
        phoneNum = (numberInput.text?.replacingOccurrences(of: " - ", with: ""))!
        if phoneNum.count >= 8 {
            submitButton.backgroundColor = .blue
            submitButton.isEnabled = true
            checkText(textField: numberInput, phoneNum: phoneNum)
        } else {
            submitButton.backgroundColor = .gray
            submitButton.isEnabled = false
        }
    }
    
    private func checkText(textField: UITextField, phoneNum: String) {
            let endIndex = phoneNum.index(phoneNum.startIndex, offsetBy: 8)
            let fixedText = phoneNum[phoneNum.startIndex..<endIndex]
            self.phoneNum = String(fixedText)
            textField.text = String(fixedText).phoneNumberStyle()
    }

    @objc private func tapSubmitButton() {
        let number = "+82010" + phoneNum
        let roomListViewController = RoomListViewController()
        navigationController?.pushViewController(roomListViewController, animated: true)
    }
    
    private func requestPutPhoneNumber(workerID: Int ,LoginDTO: LoginDTO) {
        Task{
            do {
                let response = try await self.loginService.addPhoneNumber(workerID: workerID, LoginDTO: LoginDTO)
                self.navigationController?.pushViewController(PhoneNumViewController(), animated: true)
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
