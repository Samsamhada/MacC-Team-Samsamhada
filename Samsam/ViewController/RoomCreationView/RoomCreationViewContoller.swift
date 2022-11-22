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

    var workerID = 0
    private var tableViewData = [CellData]()
    private let roomCategoryViewController = RoomCategoryViewController()
    private let roomCreationViewDateHeader = RoomCreationViewDateHeader()
    private let roomCreationViewDateFirstCell = RoomCreationViewDateFirstCell()
    private let roomCreationViewDateSecondCell = RoomCreationViewDateSecondCell()
    private let roomCreationViewWarrantyCell = RoomCreationViewWarrantyCell()

    private var startDate = "\(Date.now)"
    private var endDate = "\(Date.now)"

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

    private let nextButton: UIButton = {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = AppColor.campanulaBlue
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .gray
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MM. d"
        let strDate = dateFormatter.string(from: Date.now)

        startDate = strDate
        endDate = strDate
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

    @objc private func tapNextButton() {
        roomCategoryViewController.workerID = workerID
        roomCategoryViewController.clientName = customerTextField.text ?? ""

        navigationController?.pushViewController(roomCategoryViewController, animated: true)
    }

    @objc private func tapCloseButton() {
        self.dismiss(animated: true)
    }

    @objc private func buttonAttributeChanged() {
        if (customerTextField.text!.count) >= 1 {
            nextButton.backgroundColor = .blue
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = .gray
            nextButton.isEnabled = false
        }
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
            setCell(UITableViewCell: warrantyCell, UIView: warrantyCell.warrantyView)
            roomCategoryViewController.warrantyTime = Int32(warrantyCell.warrantyCount)

            return warrantyCell
        }

        // MARK: - Header $ Cell(DatePicker)

        if indexPath.row == 0 {
            setCell(UITableViewCell: header, UIView: header.dateView)

            if indexPath.section == 0 {
                header.dateLabel.text = "시공일"
                header.dateButton.text = startDate
            }
            if indexPath.section == 1 {
                header.dateLabel.text = "준공일"
                header.dateButton.text = endDate
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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MM. d"
        let strDate = dateFormatter.string(from: date)

        startDate = strDate
        currentSelectedFirstDate = date
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        roomCategoryViewController.startDate = dateFormatter.string(from: date)
        tableView.reloadData()
    }
}

extension RoomCreationViewController: RoomCreationViewDateSecondCellDelegate {
    func secondDateDidTap(date: Date) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy. MM. d"
        let strDate = dateFormatter.string(from: date)

        endDate = strDate
        currentSelectedSecondDate = date
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        roomCategoryViewController.endDate = dateFormatter.string(from: date)
        tableView.reloadData()
    }
}
