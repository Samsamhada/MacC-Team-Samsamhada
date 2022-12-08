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
            collectionView.reloadData()
        }
    }

    // MARK: - View

    private let collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

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

        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
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

    @objc func tapSettingButton() {
        let settingViewController = SettingWorkerViewController()
        settingViewController.workerID = workerID
        navigationController?.pushViewController(settingViewController, animated: true)
    }

    private func setupCollectionView() {
        collectionView.register(RoomCreationCell.self, forCellWithReuseIdentifier: RoomCreationCell.identifier)
        collectionView.register(RoomListCell.self, forCellWithReuseIdentifier: RoomListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return rooms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCreationCell.identifier, for: indexPath) as! RoomCreationCell

            cell.creationButton.addTarget(self, action: #selector(tapRoomCreationButton), for: .touchUpInside)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomListCell.identifier, for: indexPath) as! RoomListCell

        let tapRoomListButton = CustomTapGestureRecognizer(target: self, action: #selector(tapRoomListButton))
        tapRoomListButton.rooms = rooms[indexPath.item]
        cell.roomStack.isUserInteractionEnabled = true
        cell.roomStack.addGestureRecognizer(tapRoomListButton)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"

        cell.roomTitle.text = rooms[indexPath.row].clientName
        cell.startDate.text = convertDate(dateString: rooms[indexPath.row].startDate)
        cell.endDate.text = convertDate(dateString: rooms[indexPath.row].endDate)
        return cell
    }
    
    func convertDate(dateString: String) -> String {
        let year = dateString.dropText(first: 2, last: 20)
        let month = dateString.dropText(first: 5, last: 17)
        let day = dateString.dropText(first: 8, last: 14)

        return "\(year).\(month).\(day)"
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 50)
        }
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    @objc func tapRoomCreationButton() {
        let roomCreationView = RoomCreationViewController()
        roomCreationView.workerID = workerID
        roomCreationView.roomCreation = true
        let roomCreationViewController = UINavigationController(rootViewController:  roomCreationView)
        roomCreationViewController.modalPresentationStyle = .fullScreen
        present(roomCreationViewController, animated:  true, completion: nil)
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
