//
//  SettingRoomViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import UIKit

class SettingRoomViewController: UIViewController {
    
    // MARK: - Property
 
    private var invitecode: String?
    var room: Room?
    
    // MARK: - View
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let header = ["",""]
    private let data = [["초대 코드 공유"],["방 정보 수정"]]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: - 추후 수정 예정
        invitecode = "asdf"
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
    
    private func shareInvitecode() {
        var shareItems = [String]()
        if let invitecode = invitecode {
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
}

extension SettingRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: .none)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        
        if indexPath == [0,0] {
            cell.detailTextLabel?.text = invitecode
            cell.detailTextLabel?.textColor = AppColor.campanulaBlue
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath
        {
        case [0,0]:
            self.shareInvitecode()
        case [1,0]:
            self.tapRoomModification()
        default:
            break
        }
    }
}
