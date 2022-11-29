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
    var roomCreation: Bool? {
        didSet {
            if roomCreation == true {
                loadDateImformation()
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
            if !roomCreation! {
                if warrantyTime != room!.warrantyTime {
                    modificationButton.backgroundColor = AppColor.campanulaBlue
                    modificationButton.isEnabled = true
                } else {
                    modificationButton.backgroundColor = .gray
                    modificationButton.isEnabled = false
                }
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

    private var startDate = "" {
        didSet {
            if !roomCreation! {
                if String(startDate.dropLast(13)) != String(room!.startDate.dropLast(14)) {
                    modificationButton.backgroundColor = AppColor.campanulaBlue
                    modificationButton.isEnabled = true
                } else {
                    modificationButton.backgroundColor = .gray
                    modificationButton.isEnabled = false
                }
            }
        }
    }
    private var endDate = "" {
        didSet {
            if !roomCreation! {
                if String(endDate.dropLast(13)) != String(room!.endDate.dropLast(14)) {
                    modificationButton.backgroundColor = AppColor.campanulaBlue
                    modificationButton.isEnabled = true
                } else {
                    modificationButton.backgroundColor = .gray
                    modificationButton.isEnabled = false
                }
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

    private let textUnderLine: UIView = {
        $0.backgroundColor = AppColor.mainBlack
        $0.setHeight(height: 1)
        return $0
    }(UITextField())

    private var tableView: UITableView = {
        return $0
    }(UITableView())

    private lazy var nextButton: UIButton = {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = AppColor.campanulaBlue
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var modificationButton: UIButton = {
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
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
        view.backgroundColor = .white

        setTableView()
        setNavigation()
        hidekeyboardWhenTappedAround()
    }

    private func layout() {
        view.addSubview(uiView)

        uiView.addSubview(customerTitle)
        uiView.addSubview(customerTextField)
        uiView.addSubview(textUnderLine)
        uiView.addSubview(tableView)
        uiView.addSubview(nextButton)
        uiView.addSubview(modificationButton)
        

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
            left: uiView.leftAnchor,
            bottom: uiView.bottomAnchor,
            right: uiView.rightAnchor,
            height: 50
        )
        
        modificationButton.anchor(
            left: uiView.leftAnchor,
            bottom: uiView.bottomAnchor,
            right: uiView.rightAnchor,
            height: 50
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
    
    @objc private func buttonAttributeChanged() {
        if roomCreation! {
            if (customerTextField.text!.count) >= 1 {
                nextButton.backgroundColor = .blue
                nextButton.isEnabled = true
            } else {
                nextButton.backgroundColor = .gray
                nextButton.isEnabled = false
            }
        } else {
            if customerTextField.text! != room!.clientName {
                modificationButton.backgroundColor = AppColor.campanulaBlue
                modificationButton.isEnabled = true
            } else {
                modificationButton.backgroundColor = .gray
                modificationButton.isEnabled = false
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
        updateRoomImformation(RoomDTO: roomDTO)
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
    
    private func updateRoomImformation(RoomDTO: RoomDTO) {
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
    
    private func loadDateImformation() {
        startDate = Date.now.toString(dateFormat:  "yyyy-MM-dd HH:mm:ss.SSS")
        endDate = Date.now.toString(dateFormat:  "yyyy-MM-dd HH:mm:ss.SSS")
    }
    
    private func loadRoomImformation() {
        customerTextField.text = room?.clientName
        warrantyTime = room!.warrantyTime
        startDate = String(room!.startDate.dropLast(1))
        currentSelectedFirstDate = String(startDate.dropLast(4)).replacingOccurrences(of: "T", with: " ").toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
        endDate = String(room!.endDate.dropLast(1))
        currentSelectedSecondDate = String(endDate.dropLast(4)).replacingOccurrences(of: "T", with: " ").toDate(dateFormat: "yyyy-MM-dd HH:mm:ss")
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
                header.dateButton.text = String(startDate.dropLast(13))
            }
            if indexPath.section == 1 {
                header.dateLabel.text = "준공일"
                header.dateButton.text = String(endDate.dropLast(13))
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
