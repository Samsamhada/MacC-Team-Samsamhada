//
//  RoomCreationViewContoller.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/21.
//

import UIKit

struct cellData {
    var isOpend = Bool()
    var title = UIView()
    var sectionData = UIView()
}

class RoomCreationViewController: UIViewController{
    
    // MARK: - Property
    var tableViewData = [cellData]()
//    var isOpend = false
//    private lazy var warrantyCount = 12
    let roomCategoryViewController = RoomCategoryViewController()
    let roomCreationViewDateCell = RoomCreationViewDateCell()
//    let roomCreaitonViewWarrantyCell = RoomCreationViewWarrantyCell()

    // MARK: - View
    
    private let uiView: UIView = {
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
    
//    private let startDateHstack: UIStackView = {
//        $0.axis = .horizontal
//        return $0
//    }(UIStackView())
    
//    private let startDateLabel: UILabel = {
//        $0.text = "시공일"
//        $0.textAlignment = .left
//        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        $0.textColor = .black
//        return $0
//    }(UILabel())
    
    private var tableView: UITableView = {
        return $0
    }(UITableView())
//
//    var tableView = UITableView()
//    private var startDate: UIDatePicker = {
//        $0.datePickerMode = .date
//        $0.locale = Locale(identifier: "ko-KR")
//        $0.timeZone = .autoupdatingCurrent
//        $0.preferredDatePickerStyle = .compact
//        $0.tintColor = AppColor.campanulaBlue
//        return $0
//    }(UIDatePicker())
    
//    private let endDateHstack: UIStackView = {
//        $0.axis = .horizontal
//        return $0
//    }(UIStackView())
//
//    private let endDateLabel: UILabel = {
//        $0.text = "준공일"
//        $0.textAlignment = .left
//        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        $0.textColor = .black
//        return $0
//    }(UILabel())
//
//    private var endDate: UIDatePicker = {
//        $0.datePickerMode = .date
//        $0.locale = Locale(identifier: "ko-KR")
//        $0.timeZone = .autoupdatingCurrent
//        $0.preferredDatePickerStyle = .compact
//        $0.tintColor = AppColor.campanulaBlue
//        return $0
//    }(UIDatePicker())
    
//    private let warrantyHstack: UIStackView = {
//        $0.axis = .horizontal
//        return $0
//    }(UIStackView())
    
//    private let warrantyLabel: UILabel = {
//        $0.text = "AS기간"
//        $0.textAlignment = .left
//        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        $0.textColor = .black
//        return $0
//    }(UILabel())
//
//    private var warrantyText: UILabel = {
//        $0.text = "12개월"
//        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        return $0
//    }(UILabel())
//
//    private let warrantyStepper: UIStepper = {
//        $0.value = 12
//        $0.maximumValue = 24
//        $0.minimumValue = 0
//        $0.wraps = true
//        $0.autorepeat = true
//        $0.addTarget(self, action: #selector(tapStepper), for: .touchUpInside)
//        return $0
//    }(UIStepper())
    
    private let nextButton: UIButton = {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = AppColor.campanulaBlue
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
        $0.isEnabled = false
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        endDate.minimumDate = startDate.date
//        startDate.addTarget(self, action: #selector(setDate), for: .valueChanged)
//        endDate.addTarget(self, action: #selector(setDate), for: .valueChanged)
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white

        self.tableView.register(RoomCreationViewDateHeader.self, forCellReuseIdentifier: RoomCreationViewDateHeader.identifier)
        self.tableView.register(RoomCreationViewDateCell.self, forCellReuseIdentifier: RoomCreationViewDateCell.identifier)
        self.tableView.register(RoomCreationViewWarrantyCell.self, forCellReuseIdentifier: RoomCreationViewWarrantyCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewData = [cellData(isOpend: false,
                                  title: RoomCreationViewDateHeader().dateView,
                                  sectionData: RoomCreationViewDateCell().datePicker),
                         cellData(isOpend: false,
                                  title: RoomCreationViewDateHeader().dateView,
                                  sectionData: RoomCreationViewDateCell().datePicker),
                         cellData(sectionData: RoomCreationViewWarrantyCell())
        ]
        
        setNavigation()
        hidekeyboardWhenTappedAround()

        customerTextField.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
    }
    
    private func layout() {
        view.addSubview(uiView)
        
        uiView.addSubview(customerTitle)
        uiView.addSubview(customerTextField)
        uiView.addSubview(textUnderLine)
        uiView.addSubview(tableView)
        
//        uiView.addSubview(startDateHstack)
//        startDateHstack.addArrangedSubview(startDateLabel)
//        startDateHstack.addArrangedSubview(startDate)
        
//        uiView.addSubview(endDateHstack)
//        endDateHstack.addArrangedSubview(endDateLabel)
//        endDateHstack.addArrangedSubview(endDate)
        
//        uiView.addSubview(warrantyHstack)
//        warrantyHstack.addArrangedSubview(warrantyLabel)
//        warrantyHstack.addArrangedSubview(warrantyText)
//        warrantyHstack.addArrangedSubview(warrantyStepper)
        
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
        
        customerTitle.anchor(
            top: uiView.topAnchor,
            left: uiView.leftAnchor,
            right: uiView.rightAnchor,
            paddingTop: 40
        )
        
        customerTextField.anchor(
            top: customerTitle.bottomAnchor,
            left: uiView.leftAnchor,
            bottom: textUnderLine.topAnchor,
            right: uiView.rightAnchor,
            paddingTop: 15,
            paddingLeft: 4,
            paddingBottom: 4
        )
        
        textUnderLine.anchor(
            left: uiView.leftAnchor,
//            bottom: tableView.topAnchor,
            right: uiView.rightAnchor
//            paddingBottom: 20
        )
        
        tableView.anchor(
            top: textUnderLine.bottomAnchor,
            left: uiView.leftAnchor,
            bottom: nextButton.topAnchor,
            right: uiView.rightAnchor,
            paddingTop: 20,
            paddingBottom: 20
        )
        
//        startDateHstack.anchor(
//            left: uiView.leftAnchor,
//            bottom: endDateHstack.topAnchor,
//            right: uiView.rightAnchor,
//            paddingBottom: 20
//        )
//
//        endDateHstack.anchor(
//            left: uiView.leftAnchor,
//            bottom: warrantyHstack.topAnchor,
//            right: uiView.rightAnchor,
//            paddingBottom: 20
//        )
        
//        warrantyHstack.anchor(
//            top: tableView.bottomAnchor,
//            left: uiView.leftAnchor,
//            right: uiView.rightAnchor
//        )
//
//        warrantyText.anchor(
//            right: warrantyStepper.leftAnchor,
//            paddingRight: 10
//        )

        nextButton.anchor(
            left: uiView.leftAnchor,
            bottom: uiView.bottomAnchor,
            right: uiView.rightAnchor,
            height: 50
        )
    }
    
    private func setNavigation() {
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
    }
    
//    @objc func setDate() {
//        if startDate.date > endDate.date {
//            endDate.date = startDate.date
//        }
//        endDate.minimumDate = startDate.date
//    }
    
//    @objc private func tapStepper() {
//        warrantyCount = Int(warrantyStepper.value)
//        warrantyText.text = "\(warrantyCount)개월"
//    }
    
    // TODO: - 방생성카테고리 뷰로 수정 예정.
    
    @objc private func tapNextButton() {
        roomCategoryViewController.clientName = customerTextField.text ?? ""
//        roomCategoryViewController.startingDate = startDate.date
//        roomCategoryViewController.endingDate = endDate.date
//        roomCategoryViewController.warrantyTime = Int32(warrantyCount)
        navigationController?.pushViewController(roomCategoryViewController, animated: true)
    }
    
    @objc private func tapCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc private func buttonAttributeChanged() {
        if (customerTextField.text!.count) >= 1 {
            nextButton.backgroundColor = .blue
            nextButton.isEnabled = true
            nextButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        } else {
            nextButton.backgroundColor = .gray
            nextButton.isEnabled = false
        }
    }
}

extension RoomCreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return 1
        }
        if tableViewData[section].isOpend {
            return 2
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let warrantyCell = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewWarrantyCell.identifier, for: indexPath) as! RoomCreationViewWarrantyCell
            let background = UIView()
            background.backgroundColor = .clear
            warrantyCell.selectedBackgroundView = background
            
            warrantyCell.contentView.addSubview(warrantyCell.warrantyView)
            warrantyCell.warrantyView.anchor(
                top: warrantyCell.topAnchor,
                left: warrantyCell.leftAnchor,
                bottom: warrantyCell.bottomAnchor,
                right: warrantyCell.rightAnchor
            )
            
            roomCategoryViewController.warrantyTime = Int32(warrantyCell.warrantyCount)
            
            return warrantyCell
        }
        if indexPath.row == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewDateHeader.identifier, for: indexPath) as! RoomCreationViewDateHeader
            let background = UIView()
            background.backgroundColor = .clear
            header.selectedBackgroundView = background
            header.contentView.addSubview(header.dateView)
            header.dateView.anchor(
                top: header.topAnchor,
                left: header.leftAnchor,
                bottom: header.bottomAnchor,
                right: header.rightAnchor
            )
            
            if indexPath.section == 0 {
                header.dateLabel.text = "시공일"
                header.dateButton.setTitle("22.11.11", for: .normal)
            } else {
                header.dateLabel.text = "준공일"
                header.dateButton.setTitle("22.11.12", for: .normal)
            }
            
            
            return header
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewDateCell.identifier, for: indexPath) as! RoomCreationViewDateCell
            cell.selectionStyle = .none
//            let background = UIView()
//            background.backgroundColor = .clear
//            cell.selectedBackgroundView = background
            
            if indexPath.section == 0 {
                roomCategoryViewController.startingDate = cell.datePicker.date
            } else if indexPath.section == 1 {
                roomCategoryViewController.endingDate = cell.datePicker.date
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            tableViewData[indexPath.section].isOpend = !tableViewData[indexPath.section].isOpend
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
}
