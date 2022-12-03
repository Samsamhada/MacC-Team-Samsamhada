//
//  ModificationWorkerViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/12/02.
//

import UIKit

class ModificationWorkerViewController: UIViewController {
    
    // MARK: - Property

    private var phoneNum = ""
    private var name = ""
    
    // MARK: - View

    private let uiView: UIView = {
        return $0
    }(UIView())
    
    private let numberUiView: UIView = {
        return $0
    }(UIView())
    
    private let nameUiView: UIView = {
        return $0
    }(UIView())
    
    private let numberLabel: UILabel = {
        $0.text = "연락처"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
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
//        $0.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
        return $0
    }(CustomUITextField())

    private let numberUnderLine: UIView = {
        $0.backgroundColor = AppColor.mainBlack
        $0.setHeight(height: 1)
        return $0
    }(UIView())
    
    private let customerTitle: UILabel = {
        $0.text = "고객명/주소"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
        return $0
    }(UILabel())

    private let customerTextField: UITextField = {
        $0.placeholder = "고객의 별칭을 작성해주세요."
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        $0.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
        return $0
    }(UITextField())

    private lazy var customerTextLimit : UILabel = {
        $0.text = "0/10"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .gray
        return $0
    }(UILabel())

    private let textUnderLine: UIView = {
        $0.backgroundColor = AppColor.mainBlack
        $0.setHeight(height: 1)
        return $0
    }(UITextField())
    
    private lazy var modificationButton: UIButton = {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
//        $0.addTarget(self, action: #selector(tapModificationButton), for: .touchUpInside)
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
        uiView.addSubview(nameUiView)
        uiView.addSubview(numberUiView)
        
        nameUiView.addSubview(customerTitle)
        nameUiView.addSubview(customerTextField)
        nameUiView.addSubview(customerTextLimit)
        nameUiView.addSubview(textUnderLine)
        
        nameUiView.addSubview(numberLabel)
        nameUiView.addSubview(hStack)
        hStack.addArrangedSubview(startNumber)
        hStack.addArrangedSubview(numberInput)
        nameUiView.addSubview(numberUnderLine)
        
        uiView.addSubview(modificationButton)
        
        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        nameUiView.anchor(
            left: uiView.leftAnchor,
            bottom: uiView.centerYAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 45,
            height: 30
        )
        
        customerTitle.anchor(
            top: nameUiView.topAnchor,
            left: nameUiView.leftAnchor,
            right: nameUiView.rightAnchor
        )

        customerTextField.anchor(
            top: customerTitle.bottomAnchor,
            left: nameUiView.leftAnchor,
            bottom: textUnderLine.topAnchor,
            right: customerTextLimit.leftAnchor,
            paddingTop: 15,
            paddingLeft: 4,
            paddingBottom: 4
        )

        customerTextLimit.anchor(
            top: customerTitle.bottomAnchor,
            bottom: textUnderLine.topAnchor,
            right: nameUiView.rightAnchor,
            paddingTop: 15,
            paddingBottom: 4,
            paddingRight: 4
        )

        textUnderLine.anchor(
            left: nameUiView.leftAnchor,
            right: nameUiView.rightAnchor
        )
        
        numberUiView.anchor(
            top: uiView.centerYAnchor,
            left: uiView.leftAnchor,
            right: uiView.rightAnchor,
            paddingTop: 45,
            height: 30
        )
        
        numberLabel.anchor(
            left: uiView.leftAnchor,
            bottom: hStack.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 15
        )

        hStack.anchor(
            left: numberUiView.leftAnchor,
            bottom: numberUnderLine.topAnchor,
            right: numberUiView.rightAnchor
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

        numberUnderLine.anchor(
            left: numberUiView.leftAnchor,
            bottom: numberUiView.bottomAnchor,
            right: numberUiView.rightAnchor
        )
        
        modificationButton.anchor(
            left: uiView.leftAnchor,
            bottom: uiView.bottomAnchor,
            right: uiView.rightAnchor,
            height: 50
        )
    }
}
