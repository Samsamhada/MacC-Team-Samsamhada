//
//  RoomListViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class RoomListViewController: UIViewController {
    
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
        coreDataManager.loadAllRoomData()
        collectionView.reloadData()
    }

    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        
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
        navigationItem.title = "기와집"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(RoomCreationCell.self, forCellWithReuseIdentifier: RoomCreationCell.identifier)
        collectionView.register(RoomListCell.self, forCellWithReuseIdentifier: RoomListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        return coreDataManager.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCreationCell.identifier, for: indexPath) as! RoomCreationCell

            cell.creationButton.addTarget(self, action: #selector(tapRoomCreationButton), for: .touchUpInside)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomListCell.identifier, for: indexPath) as! RoomListCell
        
        let tapRoomListButton = CustomTapGestureRecognizer(target: self, action: #selector(tapRoomListButton))
        tapRoomListButton.roomID = Int(coreDataManager.rooms[indexPath.item].roomID)
        cell.roomStack.isUserInteractionEnabled = true
        cell.roomStack.addGestureRecognizer(tapRoomListButton)
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        cell.roomTitle.text = coreDataManager.rooms[indexPath.row].clientName
        cell.startDate.text = dateFormatter.string(from: coreDataManager.rooms[indexPath.row].startDate!)
        cell.endDate.text = dateFormatter.string(from: coreDataManager.rooms[indexPath.row].endDate!)
        return cell
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
        let roomCreationViewController = UINavigationController(rootViewController:  RoomCreationViewController())
        roomCreationViewController.modalPresentationStyle = .fullScreen
        present(roomCreationViewController, animated:  true, completion: nil)
    }
    
    @objc func tapRoomListButton(sender: CustomTapGestureRecognizer) {
        let workingHistoryViewController = SegmentedControlViewController()
        workingHistoryViewController.roomID = sender.roomID
        navigationController?.pushViewController(workingHistoryViewController, animated: true)
    }
}

class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var roomID: Int?
}
