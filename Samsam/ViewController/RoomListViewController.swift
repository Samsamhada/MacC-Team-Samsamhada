//
//  RoomListViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class RoomListViewController: UIViewController {

    // MARK: - Property

    var workerID = UserDefaults.standard.integer(forKey: "workerID")
    let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var rooms = [Room]() {
        didSet {
            rooms.sort(by: {$0.roomID < $1.roomID})
            classifyRooms()
            collectionView.reloadData()
        }
    }
    
    var doingRooms = [Room]()
    var doneRooms = [Room]()

    // MARK: - View

    private let collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private lazy var createBTN: UIButton = {
        $0.backgroundColor = AppColor.giwazipBlue
        $0.setTitle("+ 고객 추가하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapRoomCreationButton), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadRoomByWorkerID(workerID: workerID)
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = AppColor.backgroundGray

        setupNavigationTitle()
        setupCollectionView()
    }

    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(createBTN)
        
        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
        createBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func setupNavigationTitle() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(tapSettingButton))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "기와집"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    @objc func tapRoomCreationButton() {
        let roomCreationView = RoomCreationViewController()
        roomCreationView.workerID = workerID
        roomCreationView.roomCreation = true
        let roomCreationViewController = UINavigationController(rootViewController:  roomCreationView)
        roomCreationViewController.modalPresentationStyle = .fullScreen
        present(roomCreationViewController, animated:  true)
    }


    @objc func tapSettingButton() {
        let settingViewController = SettingWorkerViewController()
        settingViewController.workerID = workerID
        navigationController?.pushViewController(settingViewController, animated: true)
    }

    private func setupCollectionView() {
        collectionView.register(RoomCreationCell.self, forCellWithReuseIdentifier: RoomCreationCell.identifier)
        collectionView.register(RoomListCell.self, forCellWithReuseIdentifier: RoomListCell.identifier)
        collectionView.register(RoomListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RoomListHeader.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    private func convertDate(dateString: String) -> String {
        let year = dateString.dropText(first: 2, last: 20)
        let month = dateString.dropText(first: 5, last: 17)
        let day = dateString.dropText(first: 8, last: 14)
        
        return "\(year).\(month).\(day)"
    }
    
    private func classifyRooms() {
        doingRooms.removeAll()
        doneRooms.removeAll()
        
        let now = Date.now.toString(dateFormat: "yy.MM.dd")
        
        rooms.forEach {
            let roomDate = convertDate(dateString: $0.endDate)
            if now > roomDate {
                doneRooms.append($0)
            } else {
                doingRooms.append($0)
            }
        }
    }
    

    private func loadRoomByWorkerID(workerID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadRoomByWorkerID(workerID: workerID)
                guard let data = response else {
                    return
                }
                rooms = data
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}

extension RoomListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RoomListHeader.identifier, for: indexPath) as! RoomListHeader
        
        if indexPath.section == 0 {
            header.mainText.text = "시공 중인 고객"
        } else {
            header.mainText.text = "AS 관리 고객"
        }
        
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return doingRooms.count
        } else {
            return doneRooms.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomListCell.identifier, for: indexPath) as! RoomListCell

        let tapRoomListButton = CustomTapGestureRecognizer(target: self, action: #selector(tapRoomListButton))
        
        cell.roomStack.isUserInteractionEnabled = true
        cell.roomStack.addGestureRecognizer(tapRoomListButton)
        
        if indexPath.section == 0 {
            tapRoomListButton.rooms = doingRooms[indexPath.item]
            cell.roomTitle.text = doingRooms[indexPath.row].clientName
            cell.startDate.text = convertDate(dateString: doingRooms[indexPath.row].startDate)
            cell.endDate.text = convertDate(dateString: doingRooms[indexPath.row].endDate)
            cell.chipText.text = "\(cell.startDate.text!) ~ \(String(describing: cell.endDate.text!))"
        } else {
            tapRoomListButton.rooms = doneRooms[indexPath.item]
            cell.roomTitle.text = doneRooms[indexPath.row].clientName
            cell.startDate.text = convertDate(dateString: doneRooms[indexPath.row].startDate)
            cell.endDate.text = convertDate(dateString: doneRooms[indexPath.row].endDate)
            cell.chipText.text = "\(cell.startDate.text!) ~ \(cell.endDate.text!)"
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    @objc func tapRoomListButton(sender: CustomTapGestureRecognizer) {
        let segmentedControlViewController = SegmentedControlViewController()
        segmentedControlViewController.room = sender.rooms!
        navigationController?.pushViewController(segmentedControlViewController, animated: true)
    }
}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var rooms: Room?
}

extension String {
    func dropText(first: Int, last: Int) -> Substring {
        self.dropFirst(first).dropLast(last)
    }
}
