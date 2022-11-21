//
//  RoomCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/20.
//

import UIKit

class RoomCategoryViewController: UIViewController {
    
    // MARK: - Property

    var clientName: String = ""
    var startingDate: Date = Date()
    var endingDate: Date = Date()
    var warrantyTime: Int32 = 0
    var selectedCellArray: [Int] = []
    let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var room: Room? {
        didSet {
            selectedCellArray.forEach {
                createStatus(StatusDTO: StatusDTO(roomID: room!.roomID, category: $0))
            }
        }
    }
    var statuses: [Status] = []
    
    // MARK: - View

    private var titleText: UILabel = {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())

    private let nextBTN: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("방 생성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())

    private let categoryView: UICollectionView = {
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
        self.view.backgroundColor = .white
        setNavigationTitle()
        setTitleText()

        categoryView.delegate = self
        categoryView.dataSource = self
        categoryView.allowsMultipleSelection = true
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }

    private func layout() {
        view.addSubview(titleText)
        view.addSubview(nextBTN)
        view.addSubview(categoryView)

        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 30,
            height: 20
        )

        categoryView.anchor(
            top: titleText.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBTN.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20
        )

        nextBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func setNavigationTitle() {
        navigationItem.title = "방 생성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func setTitleText() {
        let statement = "시공 과정을 모두 선택해주세요".getColoredText("모두", .red)
        titleText.text = ""
        titleText.attributedText = statement
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

        var roomDTO: RoomDTO = RoomDTO(workerID: workerID, clientName: clientName, startDate: startDate, endDate: endDate, warrantyTime: warrantyTime)

        createRoom(RoomDTO: roomDTO)

        self.dismiss(animated: true)
    }
}

extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

extension String {
    func getColoredText(_ text: String, _ color: UIColor) -> NSMutableAttributedString {
        let nsString = NSMutableAttributedString(string: self)
        nsString.setColorForText(textToFind: self, withColor: UIColor.black)
        nsString.setColorForText(textToFind: text, withColor: color)
        return nsString
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
        let cellWidth =  (view.frame.width - 48)/3
        let cellHeight = 120
        return CGSize(width: Int(cellWidth), height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 16, right: 8)
    }
}
