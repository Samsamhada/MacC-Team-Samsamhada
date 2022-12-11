//
//  RoomCreationViewContoller.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/21.
//

import UIKit

struct CellData {
    var isOpend = Bool()
    var title = UIView()
    var sectionData = UIView()
}

class RoomCreationViewController: UIViewController{

    // MARK: - Property
    
    private let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var room: Room?
    var roomCreation: Bool = true {
        didSet {
            if roomCreation {
                navigationItem.title = "방 생성"
                nextButton.isHidden = false
            } else {
                loadRoomImformation()
                navigationItem.title = "방 정보 수정"
                modificationButton.isHidden = false
            }
        }
    }
    var warrantyTime: Int = 12 {
        didSet {
            if !roomCreation {
                modificationButton.backgroundColor = (warrantyTime != room!.warrantyTime) ? AppColor.giwazipBlue : .gray
                modificationButton.isEnabled = (warrantyTime != room!.warrantyTime) ? true : false
            }
        }
    }

    var workerID = 0
    private var tableViewData = [CellData]()
    private let roomCategoryViewController = RoomCategoryViewController()
    private let roomCreationViewDateHeader = RoomCreationViewDateHeader()
    private let roomCreationViewDateFirstCell = RoomCreationViewDateFirstCell()
    private let roomCreationViewDateSecondCell = RoomCreationViewDateSecondCell()
    private let roomCreationViewWarrantyCell = RoomCreationViewWarrantyCell()

    private var startDate = Date.now.toString(dateFormat:  "yyyy-MM-dd HH:mm:ss.SSS") {
        didSet {
            if !roomCreation {
                modificationButton.backgroundColor = (String(startDate.dropLast(13)) != String(room!.startDate.dropLast(14))) ? AppColor.giwazipBlue : .gray
                modificationButton.isEnabled = (String(startDate.dropLast(13)) != String(room!.startDate.dropLast(14))) ? true : false
            }
        }
    }
    private var endDate = Date.now.toString(dateFormat:  "yyyy-MM-dd HH:mm:ss.SSS") {
        didSet {
            if !roomCreation {
                modificationButton.backgroundColor = (String(endDate.dropLast(13)) != String(room!.endDate.dropLast(14))) ? AppColor.giwazipBlue : .gray
                modificationButton.isEnabled = (String(endDate.dropLast(13)) != String(room!.endDate.dropLast(14))) ? true : false
            }
        }
    }

    private var currentSelectedFirstDate: Date?
    private var currentSelectedSecondDate: Date?

    // MARK: - View

    private let uiView: UIView = {
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
        $0.addTarget(self, action: #selector(buttonAttributeChanged), for: .editingChanged)
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

    private var tableView: UITableView = {
        $0.backgroundColor = .clear
        return $0
    }(UITableView())

    private lazy var nextButton: UIButton = {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .gray
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.isHidden = true
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var modificationButton: UIButton = {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.backgroundColor = .gray
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapModificationButton), for: .touchUpInside)
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
        tableView.reloadData()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = AppColor.backgroundGray

        setTableView()
        setNavigation()
        setupNotificationCenter()
        hidekeyboardWhenTappedAround()
    }

    private func layout() {
        view.addSubview(uiView)

        uiView.addSubview(customerTitle)
        uiView.addSubview(customerTextField)
        uiView.addSubview(customerTextLimit)
        uiView.addSubview(textUnderLine)
        uiView.addSubview(tableView)
        view.addSubview(nextButton)
        view.addSubview(modificationButton)

        uiView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingBottom: 8,
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
            right: customerTextLimit.leftAnchor,
            paddingTop: 15,
            paddingLeft: 4,
            paddingBottom: 4
        )

        customerTextLimit.anchor(
            top: customerTitle.bottomAnchor,
            bottom: textUnderLine.topAnchor,
            right: uiView.rightAnchor,
            paddingTop: 15,
            paddingBottom: 4,
            paddingRight: 4
        )

        textUnderLine.anchor(
            left: uiView.leftAnchor,
            right: uiView.rightAnchor
        )

        tableView.anchor(
            top: textUnderLine.bottomAnchor,
            left: uiView.leftAnchor,
            bottom: nextButton.topAnchor,
            right: uiView.rightAnchor,
            paddingTop: 20,
            paddingBottom: 20
        )

        nextButton.anchor(
            left: view.leftAnchor,
            bottom: view.keyboardLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )

        modificationButton.anchor(
            left: view.leftAnchor,
            bottom: view.keyboardLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }

    private func setNavigation() {
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

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.modificationButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
                self.nextButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.modificationButton.transform = .identity
            self.nextButton.transform = .identity
        })
    }

    @objc private func buttonAttributeChanged() {
        checkMaxLength(textField: customerTextField)
        setCounter(count: customerTextField.text!.count)
        
        if roomCreation {
            nextButton.backgroundColor = (customerTextField.text!.count >= 1) ? AppColor.giwazipBlue : .gray
            nextButton.isEnabled = (customerTextField.text!.count >= 1) ? true : false
        } else {
            modificationButton.backgroundColor = (customerTextField.text! != room!.clientName) ? AppColor.giwazipBlue : .gray
            modificationButton.isEnabled = (customerTextField.text! != room!.clientName) ? true : false
        }
    }

    private func setCounter(count: Int) {
        customerTextLimit.text = "\(count)/10"
    }
    
    private func checkMaxLength(textField: UITextField) {
        if let text = textField.text {
            if text.count > 10 {
                let endIndex = text.index(text.startIndex, offsetBy: 10)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + " "
                customerTextField.text = String(fixedText)
            }
        }
    }

    @objc private func tapNextButton() {
        roomCategoryViewController.workerID = workerID
        roomCategoryViewController.clientName = customerTextField.text ?? ""
        roomCategoryViewController.startDate = startDate
        roomCategoryViewController.endDate = endDate
        roomCategoryViewController.warrantyTime = warrantyTime
        navigationController?.pushViewController(roomCategoryViewController, animated: true)
    }
    
    @objc private func tapModificationButton() {
        let roomDTO: RoomDTO = RoomDTO(workerID: room!.workerID, clientName: customerTextField.text!, startDate: startDate, endDate: endDate, warrantyTime: warrantyTime)
        updateRoomInformation(RoomDTO: roomDTO)
    }

    @objc private func tapCloseButton() {
        self.dismiss(animated: true)
    }

    private func setTableView()  {
        self.tableView.register(RoomCreationViewDateHeader.self, forCellReuseIdentifier: RoomCreationViewDateHeader.identifier)
        self.tableView.register(RoomCreationViewDateFirstCell.self, forCellReuseIdentifier: RoomCreationViewDateFirstCell.identifier)
        self.tableView.register(RoomCreationViewDateSecondCell.self, forCellReuseIdentifier: RoomCreationViewDateSecondCell.identifier)
        self.tableView.register(RoomCreationViewWarrantyCell.self, forCellReuseIdentifier: RoomCreationViewWarrantyCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableViewData = [CellData(isOpend: false,
                                  title: roomCreationViewDateHeader.dateView,
                                  sectionData: roomCreationViewDateFirstCell.datePicker),
                         CellData(isOpend: false,
                                  title: roomCreationViewDateHeader.dateView,
                                  sectionData: roomCreationViewDateSecondCell.datePicker),
                         CellData(sectionData: roomCreationViewWarrantyCell)
        ]
    }
    
    private func updateRoomInformation(RoomDTO: RoomDTO) {
        Task{
            do {
                let response = try await self.roomAPI.modifyRoom(roomID: room!.roomID, RoomDTO: RoomDTO)
                if let data = response {
                    self.dismiss(animated: true)
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
    
    private func loadRoomImformation() {
        customerTextField.text = room?.clientName
        warrantyTime = room!.warrantyTime
        startDate = String(room!.startDate.dropLast(1))
        currentSelectedFirstDate = String(startDate.dropLast(4)).replacingOccurrences(of: "T", with: " ").toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        endDate = String(room!.endDate.dropLast(1))
        currentSelectedSecondDate = String(endDate.dropLast(4)).replacingOccurrences(of: "T", with: " ").toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        setCounter(count: customerTextField.text!.count)
    }
}

extension RoomCreationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 2 {
            return 1
        }
        if tableViewData[section].isOpend {
            return 2
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // MARK: - Property

        let warrantyCell = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewWarrantyCell.identifier, for: indexPath) as! RoomCreationViewWarrantyCell
        let header = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewDateHeader.identifier, for: indexPath) as! RoomCreationViewDateHeader
        let firstCell = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewDateFirstCell.identifier, for: indexPath) as! RoomCreationViewDateFirstCell
        let secondCell = tableView.dequeueReusableCell(withIdentifier: RoomCreationViewDateSecondCell.identifier, for: indexPath) as! RoomCreationViewDateSecondCell

        // MARK: - View

        let background = UIView()
        background.backgroundColor = .clear

        // MARK: - AS기간

        if indexPath.section == 2 {
            warrantyCell.warrantyTimeDelegate = self
            setCell(UITableViewCell: warrantyCell, UIView: warrantyCell.warrantyView)
            warrantyCell.warrantyStepper.value = Double(warrantyTime)
            warrantyCell.warrantyText.text = "\(warrantyTime)개월"
            return warrantyCell
        }

        // MARK: - Header $ Cell(DatePicker)

        if indexPath.row == 0 {
            setCell(UITableViewCell: header, UIView: header.dateView)
            
            if indexPath.section == 0 {
                header.dateLabel.text = "시공일"
                header.dateButton.text = String(startDate.dropFirst(2).dropLast(13)).replacingOccurrences(of: "-", with: ".")
            }
            if indexPath.section == 1 {
                header.dateLabel.text = "준공일"
                header.dateButton.text = String(endDate.dropFirst(2).dropLast(13)).replacingOccurrences(of: "-", with: ".")
            }

            return header
        } else {
            if indexPath.section == 0 {
                firstCell.firstDelegate = self
                firstCell.configure(date: currentSelectedFirstDate)

                setCell(UITableViewCell: firstCell, UIView: firstCell.datePicker)

                return firstCell
            }
            if indexPath.section == 1 {
                secondCell.secondDelegate = self
                secondCell.configure(date: currentSelectedSecondDate)

                setCell(UITableViewCell: secondCell, UIView: secondCell.datePicker)

                return secondCell
            }

            return firstCell
        }

        func setCell(UITableViewCell: UITableViewCell, UIView: UIView) {
            UITableViewCell.selectedBackgroundView = background
            UITableViewCell.contentView.addSubview(UIView)
            UIView.anchor(
                top: UITableViewCell.contentView.topAnchor,
                left: UITableViewCell.contentView.leftAnchor,
                bottom: UITableViewCell.contentView.bottomAnchor,
                right: UITableViewCell.contentView.rightAnchor
            )
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableViewData[indexPath.section].isOpend.toggle()
        }
        tableView.reloadSections([indexPath.section], with: .none)
    }
}

extension RoomCreationViewController: RoomCreationViewDateFirstCellDelegate {
    func firstDateDidTap(date: Date) {

        currentSelectedFirstDate = date
        startDate = date.toString(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS", local: "ko_KR")
 
        tableView.reloadData()
    }
}

extension RoomCreationViewController: RoomCreationViewDateSecondCellDelegate {
    func secondDateDidTap(date: Date) {

        currentSelectedSecondDate = date
        endDate = date.toString(dateFormat: "yyyy-MM-dd HH:mm:ss.SSS", local: "ko_KR")
        
        tableView.reloadData()
    }
}

extension RoomCreationViewController: RoomCreationViewWarrantyCellDelegate {
    func warrantyTimeChanged(warrantyTime: Int) {
        self.warrantyTime = warrantyTime
    }
}

extension String {
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension Date {
    func toString(dateFormat: String, local: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if let local = local {
            dateFormatter.locale = Locale(identifier: local)
        }
        
        return dateFormatter.string(from: self)
    }
}
