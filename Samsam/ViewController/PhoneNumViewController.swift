//
//  PhoneNumViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/18.
//

import UIKit

class PhoneNumViewController: UIViewController {
    
    // MARK: - View
    
    private let vStack: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
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
    
    private lazy var numberInput: UITextField = {
        $0.placeholder = "1234-5678"
        $0.font = UIFont.systemFont(ofSize: 16)
        return $0
    }(UITextField())
    
    private let inputUnderLine: UIView = {
        $0.setHeight(height: 1)
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    private let submitButton: UIButton = {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = .blue
        $0.setHeight(height: 50)
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())
    
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
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(numberLabel)
        vStack.addArrangedSubview(hStack)
        hStack.addArrangedSubview(startNumber)
        hStack.addArrangedSubview(numberInput)
        vStack.addArrangedSubview(inputUnderLine)
        vStack.addArrangedSubview(submitButton)
        
        vStack.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        numberLabel.anchor(
            left: vStack.leftAnchor,
            bottom: hStack.topAnchor,
            right: vStack.rightAnchor
        )
        
        hStack.anchor(
            left: vStack.leftAnchor,
            bottom: inputUnderLine.topAnchor,
            right: vStack.rightAnchor
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
            left: vStack.leftAnchor,
            bottom: submitButton.topAnchor,
            right: vStack.rightAnchor,
            paddingBottom: 30
        )
        
        submitButton.anchor(
            left: vStack.leftAnchor,
            bottom: vStack.bottomAnchor,
            right: vStack.rightAnchor
        )
    }
}
