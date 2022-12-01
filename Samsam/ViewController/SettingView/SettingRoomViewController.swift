//
//  SettingRoomViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import UIKit

class SettingRoomViewController: UIViewController {
    
    // MARK: - Property
    
    private let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var room: Room?
    
    // MARK: - View
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let data = [["초대 코드 공유"],["방 정보 수정"]]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRoomByRoomID(roomID: room!.roomID)
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white
        
        setupNavigationTitle()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func layout() {
        view.addSubview(tableView)
        
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func setupNavigationTitle() {
        navigationItem.title = "방 설정"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func shareInviteCode() {
        var shareItems = [String]()
        if let invitecode = room?.inviteCode {
            shareItems.append("초대 코드: \(invitecode)")
        }
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func tapRoomModification() {
        let roomCreationView = RoomCreationViewController()
        roomCreationView.room = room
        roomCreationView.roomCreation = false
        let navigationController = UINavigationController(rootViewController: roomCreationView)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated:  true, completion: nil)
    }
    
    private func loadRoomByRoomID(roomID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadRoom(roomID: roomID)
                if let data = response {
                    room = data
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}

extension SettingRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: .none)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        
        if indexPath == [0,0] {
            cell.detailTextLabel?.text = room?.inviteCode
            cell.detailTextLabel?.textColor = AppColor.campanulaBlue
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath
        {
        case [0,0]:
            self.shareInviteCode()
        case [1,0]:
            self.tapRoomModification()
        default:
            break
        }
    }
}
