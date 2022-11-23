//
//  SettingWorkerViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import UIKit

class SettingMainViewController: UIViewController {
    
    // MARK: - View

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let header = ["","",""]
    private let data = [["개인 정보 수정"],["이용약관","개발자정보","고객 센터", "버전 정보"],["로그 아웃","회원 탈퇴"]]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white
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
}

extension SettingMainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
