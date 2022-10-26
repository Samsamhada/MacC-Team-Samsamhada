//
//  RoomCreationViewContoller.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/21.
//

import UIKit

class RoomCreationViewController: UIViewController {
    
    // MARK: - Property
    
    private lazy var warrantyCount = 12
    
    // MARK: - View
    
    private let uiView: UIView = {
        return $0
    }(UIView())
    
    private let titleHstack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let closeButton: UIButton = {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.tintColor = .black
        $0.setWidth(width: (UIScreen.main.bounds.width - 32) / 3)
        return $0
    }(UIButton())
    
    private let viewTitle: UILabel = {
        $0.text = "방 생성"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setWidth(width: (UIScreen.main.bounds.width - 32) / 3)
        return $0
    }(UILabel())
    
    private let spacer: UIView = {
        $0.setWidth(width: (UIScreen.main.bounds.width - 32) / 3)
        return $0
    }(UIView())
    
    private let customerTitle: UILabel = {
        $0.text = "고객명/주소"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let customerTextField: UITextField = {
        $0.placeholder = "고객의 별칭을 작성해주세요."
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UITextField())
    
    private let textUnderLine: UIView = {
        $0.backgroundColor = .black
        $0.setHeight(height: 1)
        return $0
    }(UITextField())
    
    private let startDateHstack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let startDateLabel: UILabel = {
        $0.text = "시공일"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var startDate: UIDatePicker = {
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.preferredDatePickerStyle = .compact
        return $0
    }(UIDatePicker())
    
    private let endDateHstack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let endDateLabel: UILabel = {
        $0.text = "준공일"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private var endDate: UIDatePicker = {
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.preferredDatePickerStyle = .compact
        return $0
    }(UIDatePicker())
    
    private let warrantyHstack: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let warrantyLabel: UILabel = {
        $0.text = "AS기간"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())

    private var warrantyText: UILabel = {
        $0.text = "12개월"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return $0
    }(UILabel())
    
    private let warrantyStepper: UIStepper = {
        $0.value = 12
        $0.maximumValue = 24
        $0.minimumValue = 0
        $0.wraps = true
        $0.autorepeat = true
        $0.addTarget(self, action: #selector(tapStepper), for: .touchUpInside)
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
        
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        
        navigationItem.title = "방 생성"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(tapCloseButton)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(uiView)
        
        uiView.addSubview(customerTitle)
        uiView.addSubview(customerTextField)
        uiView.addSubview(textUnderLine)
        
        uiView.addSubview(startDateHstack)
        startDateHstack.addArrangedSubview(startDateLabel)
        startDateHstack.addArrangedSubview(startDate)
        
        uiView.addSubview(endDateHstack)
        endDateHstack.addArrangedSubview(endDateLabel)
        endDateHstack.addArrangedSubview(endDate)
        
        uiView.addSubview(warrantyHstack)
        warrantyHstack.addArrangedSubview(warrantyLabel)
        warrantyHstack.addArrangedSubview(warrantyText)
        warrantyHstack.addArrangedSubview(warrantyStepper)
        
        uiView.addSubview(nextButton)
        
        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        customerTextField.anchor(
            top: uiView.topAnchor,
            left: uiView.leftAnchor,
            bottom: textUnderLine.topAnchor,
            right: uiView.rightAnchor,
            paddingTop: 40,
            paddingLeft: 4,
            paddingBottom: 4
        )
        
        textUnderLine.anchor(
            left: uiView.leftAnchor,
            bottom: startDateHstack.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 20
        )
        
        startDateHstack.anchor(
            left: uiView.leftAnchor,
            bottom: endDateHstack.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 20
        )

        endDateHstack.anchor(
            left: uiView.leftAnchor,
            bottom: warrantyHstack.topAnchor,
            right: uiView.rightAnchor,
            paddingBottom: 20
        )
        
        warrantyHstack.anchor(
            left: uiView.leftAnchor,
            right: uiView.rightAnchor
        )
        
        warrantyText.anchor(
            right: warrantyStepper.leftAnchor,
            paddingRight: 10
        )

        nextButton.anchor(
            left: uiView.leftAnchor,
            bottom: uiView.bottomAnchor,
            right: uiView.rightAnchor,
            height: 50
        )
    }
    
    @objc private func tapStepper() {
        warrantyCount = Int(warrantyStepper.value)
        warrantyText.text = "\(warrantyCount)개월"
    }
    
    // TODO: - 방생성카테고리 뷰로 수정 예정.
    
    @objc private func tapNextButton() {
        let roomCategoryViewController = RoomCategoryViewController()
        navigationController?.pushViewController(roomCategoryViewController, animated: true)
    }
    
    @objc private func tapCloseButton() {
        self.dismiss(animated: true)
    }
}
