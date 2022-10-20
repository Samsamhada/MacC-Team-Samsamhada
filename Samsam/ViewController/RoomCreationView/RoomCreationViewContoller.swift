//
//  RoomCreationViewContoller.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/21.
//

import UIKit

class RoomCreationViewController: UIViewController {

    // MARK: - View
    
    private let customerTitle: UILabel = {
        $0.text = "고객명/주소"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let customerTextField: UITextField = {
        $0.placeholder = "고객의 별칭을 작성해주세요."
        return $0
    }(UITextField())
    
    private let textUnderLine: UIView = {
        $0.backgroundColor = .black
        $0.setHeight(height: 1)
        return $0
    }(UITextField())
    
    private let startDateHstack: UIStackView = {
        return $0
    }(UIStackView())
    
    private let startDateLabel: UILabel = {
        $0.text = "시공일"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var startDate: UITextView = {
        $0.textColor = .black
        return $0
    }(UITextView())
    
    private let endDateHstack: UIStackView = {
        return $0
    }(UIStackView())
    
    private let endDateLabel: UILabel = {
        $0.text = "준공일"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var endDate: UITextView = {
        $0.textColor = .black
        return $0
    }(UITextView())
    
    private let warrantyHstack: UIStackView = {
        return $0
    }(UIStackView())
    
    private let warrantyLabel: UILabel = {
        $0.text = "AS기간"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var warrantyText: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.backgroundColor = .black
        return $0
    }(UILabel())
    
    private let warrantyStepper: UIStepper = {
        $0.maximumValue = 60
        $0.minimumValue = 0
        $0.wraps = true // 무슨 기능일까?
        $0.autorepeat = true
        return $0
    }(UIStepper())
    
    
    private let nextButton: UIButton = {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .yellow
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        view.addSubview(customerTitle)
        view.addSubview(customerTextField)
        view.addSubview(textUnderLine)
        view.addSubview(startDateHstack)
        startDateHstack.addArrangedSubview(startDateLabel)
        startDateHstack.addArrangedSubview(startDate)
        view.addSubview(endDateHstack)
        endDateHstack.addArrangedSubview(endDateLabel)
        endDateHstack.addArrangedSubview(endDate)
        view.addSubview(warrantyHstack)
        warrantyHstack.addArrangedSubview(warrantyLabel)
        warrantyHstack.addArrangedSubview(warrantyText)
        warrantyHstack.addArrangedSubview(warrantyStepper)
        view.addSubview(nextButton)
        
        
        customerTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: customerTextField.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 40,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        customerTextField.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: startDateHstack.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 18,
            paddingBottom: 20,
            paddingRight: 16
        )
        
        textUnderLine.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: startDateHstack.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16
        )
        
        startDateHstack.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: endDateHstack.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16
        )

        endDateHstack.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: warrantyHstack.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingBottom: 20,
            paddingRight: 16
        )
        
        warrantyHstack.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        nextButton.anchor(
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

