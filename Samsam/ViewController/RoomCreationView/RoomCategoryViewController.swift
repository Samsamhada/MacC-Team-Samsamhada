//
//  RoomCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/20.
//

import UIKit

class RoomCategoryViewController: UIViewController {

    // MARK: - Property

    var workerID: Int = 0
    var clientName: String = ""
    lazy var startDate: String = ""
    lazy var endDate: String = ""
    var warrantyTime: Int = 12
    var selectedCellArray: [Int] = []
    let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var room: Room? {
        didSet {
            selectedCellArray.forEach {
                createStatus(StatusDTO: StatusDTO(roomID: room!.roomID, category: $0))
            }
        }
    }
    var statuses: [Status] = [] {
        didSet {
            if selectedCellArray.count == statuses.count {
                let roomCodeViewController = RoomCodeViewController()
                roomCodeViewController.inviteCode = room!.inviteCode
                navigationController?.pushViewController(roomCodeViewController, animated: true)
            }
        }
    }

    // MARK: - View

    private var titleText: UILabel = {
        $0.text = "시공 항목을 모두 선택해주세요"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())

    private let nextBTN: UIButton = {
        $0.backgroundColor = AppColor.giwazipBlue
        $0.setTitle("방 생성하기", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())

    private let categoryView: UICollectionView = {
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = AppColor.backgroundGray
        setNavigationTitle()

        categoryView.delegate = self
        categoryView.dataSource = self
        categoryView.allowsMultipleSelection = true
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }

    private func layout() {
        view.addSubview(titleText)
        view.addSubview(categoryView)
        view.addSubview(nextBTN)

        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 30,
            paddingLeft: 16,
            paddingRight: 16,
            height: 20
        )

        categoryView.anchor(
            top: titleText.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16
        )

        nextBTN.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }

    private func setNavigationTitle() {
        navigationItem.title = "방 생성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func createRoom(RoomDTO: RoomDTO) {
        Task{
            do {
                let response = try await self.roomAPI.createRoom(RoomDTO: RoomDTO)
                if let data = response {
                    self.room = data
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }

    private func createStatus(StatusDTO: StatusDTO) {
        Task{
            do {
                let response = try await self.roomAPI.createStatus(StatusDTO: StatusDTO)
                if let data = response {
                    self.statuses.append(data)
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }

    @objc func tapNextBTN() {
        selectedCellArray.sort()
        let roomDTO: RoomDTO = RoomDTO(workerID: workerID, clientName: clientName, startDate: startDate, endDate: endDate, warrantyTime: warrantyTime)
        createRoom(RoomDTO: roomDTO)
    }
}

extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension RoomCategoryViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.categoryImage.image = UIImage(named: CategoryCell.ImageLiteral.noCheck)
        let category: Category = Category(rawValue: indexPath.row)!
        cell.categoryTitle.text = "\(category.categoryName())"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == false {
            cell?.isSelected = true
        }
        selectedCellArray.append(indexPath.item)

        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true {
            cell?.isSelected = false
        }
        selectedCellArray.remove(at: selectedCellArray.firstIndex(of: indexPath.item)!)
        return true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 48)/3
        let cellHeight = cellWidth * 1.21
        return CGSize(width: Int(cellWidth), height: Int(cellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 80, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
