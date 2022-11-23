//
//  SettingWorkerViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import UIKit

class SettingWorkerViewController: UIViewController {
    
    // MARK: - View

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let header = ["","",""]
    private let data = [["개인 정보 수정"],["이용약관","개인정보 처리방침","고객 센터","개발자정보","버전 정보"],["로그 아웃","회원 탈퇴"]]

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

extension SettingWorkerViewController: UITableViewDataSource, UITableViewDelegate {
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
        print(indexPath.row)
        switch indexPath
        {
        case [0,0]: // 개인 정보 수정
            print("개인 정보 수정")
        case [1,0]: // 이용 약관
            if let url = URL(string: "https://giwazip.notion.site/c9ce45548c834d6d9ab91a139c489a2c") {
                UIApplication.shared.open(url, options: [:])
            }
        case [1,1]: // 개인정보 처리방침
            if let url = URL(string: "https://giwazip.notion.site/c9ce45548c834d6d9ab91a139c489a2c") {
                UIApplication.shared.open(url, options: [:])
            }
        case [1,2]: // 고객센터
            print("고객 센터 문의")
        case [1,3]: // 개발자 정보
            self.navigationController?.pushViewController(DeveloperViewController(), animated: true)
        case [1,4]: // 버전 정보
            self.navigationController?.pushViewController(VersionViewController(), animated: true)
        case [2,0]: // 로그 아웃
            print("로그 아웃")
        case [2,1]: // 회원 탈퇴
            print("회원 탈퇴")
        default:
            break
        }
    }
}
