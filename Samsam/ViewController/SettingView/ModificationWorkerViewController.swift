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
    var workerData: Login?
    private let workerService: WorkerAPI = WorkerAPI(apiService: APIService())
    
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
    
    private let customerTitle: UILabel = {
        $0.text = "성함"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = AppColor.mainBlack
        return $0
    }(UILabel())

    private lazy var customerTextField: UITextField = {
        $0.placeholder = "성함을 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.addTarget(self, action: #selector(nameAttributeChanged), for: .editingChanged)
        return $0
    }(UITextField())

    private let textUnderLine: UIView = {
        $0.backgroundColor = AppColor.mainBlack
        $0.setHeight(height: 1)
        return $0
    }(UITextField())
    
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
        $0.addTarget(self, action: #selector(numberAttributeChanged), for: .editingChanged)
        return $0
    }(CustomUITextField())

    private let numberUnderLine: UIView = {
        $0.backgroundColor = AppColor.mainBlack
        $0.setHeight(height: 1)
        return $0
    }(UIView())
    
    private lazy var modificationButton: UIButton = {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapModificationButton), for: .touchUpInside)
        return $0
    }(UIButton())

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidekeyboardWhenTappedAround()
        attribute()
        layout()
        print(workerData)
    }
    
    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white
        
        setupNotificationCenter()
        setupNavigationTitle()
        
        customerTextField.text = workerData?.name
        
        numberInput.text = String((workerData?.number)!.dropFirst(6))
        phoneNum = (numberInput.text?.replacingOccurrences(of: " - ", with: ""))!
        checkText(textField: numberInput, phoneNum: phoneNum)
    }
    
    private func layout() {
        view.addSubview(uiView)
        uiView.addSubview(nameUiView)
        uiView.addSubview(numberUiView)
        
        nameUiView.addSubview(customerTitle)
        nameUiView.addSubview(customerTextField)
        nameUiView.addSubview(textUnderLine)
        
        numberUiView.addSubview(numberLabel)
        numberUiView.addSubview(hStack)
        hStack.addArrangedSubview(startNumber)
        hStack.addArrangedSubview(numberInput)
        numberUiView.addSubview(numberUnderLine)
        
        uiView.addSubview(modificationButton)
        
        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        nameUiView.anchor(
            top: uiView.topAnchor,
            left: uiView.leftAnchor,
            right: uiView.rightAnchor,
            paddingTop: 10,
            height: 80
        )
        
        customerTitle.anchor(
            top: nameUiView.topAnchor,
            left: nameUiView.leftAnchor,
            right: nameUiView.rightAnchor
        )

        customerTextField.anchor(
            top: customerTitle.bottomAnchor,
            left: nameUiView.leftAnchor,
            right: nameUiView.rightAnchor,
            paddingTop: 15,
            paddingLeft: 4
        )

        textUnderLine.anchor(
            top: customerTextField.bottomAnchor,
            left: nameUiView.leftAnchor,
            right: nameUiView.rightAnchor,
            paddingTop: 4
        )
        
        numberUiView.anchor(
            top: nameUiView.bottomAnchor,
            left: uiView.leftAnchor,
            right: uiView.rightAnchor,
            paddingTop: 10,
            height: 80
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
    
    private func setupNavigationTitle() {
        navigationItem.title = "개인 정보 수정"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func nameAttributeChanged() {
        if customerTextField.text != workerData?.name {
            modificationButton.isEnabled = true
            modificationButton.backgroundColor = AppColor.campanulaBlue
        } else {
            modificationButton.isEnabled = false
            modificationButton.backgroundColor = .gray
        }
    }
    
    @objc private func numberAttributeChanged() {
        phoneNum = (numberInput.text?.replacingOccurrences(of: " - ", with: ""))!
        if phoneNum.count >= 8 && phoneNum != String((workerData?.number)!.dropFirst(6)).replacingOccurrences(of: " - ", with: "")  {
            modificationButton.isEnabled = true
            modificationButton.backgroundColor = AppColor.campanulaBlue
            checkText(textField: numberInput, phoneNum: phoneNum)
        } else {
            modificationButton.isEnabled = false
            modificationButton.backgroundColor = .gray
        }
    }
    
    private func checkText(textField: UITextField, phoneNum: String) {
            let endIndex = phoneNum.index(phoneNum.startIndex, offsetBy: 8)
            let fixedText = phoneNum[phoneNum.startIndex..<endIndex]
            self.phoneNum = String(fixedText)
            textField.text = String(fixedText).phoneNumberStyle()
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.modificationButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.modificationButton.transform = .identity
        })
    }
    
    @objc private func tapModificationButton() {
        let number = "+82010" + phoneNum
        let workerDTO = WorkerDTO(userIdentifier: (workerData?.userIdentifier)!, name: customerTextField.text, number: number)
        requestPut(workerID: (workerData?.workerID)!, workerDTO: workerDTO)
    }
    
    private func requestPut(workerID: Int , workerDTO: WorkerDTO) {
        Task{
            do {
                let response = try await self.workerService.modifyWorkerData(workerID: workerID, workerDTO: workerDTO)
                if let data = response {
                    self.navigationController?.popViewController(animated: true)
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}
