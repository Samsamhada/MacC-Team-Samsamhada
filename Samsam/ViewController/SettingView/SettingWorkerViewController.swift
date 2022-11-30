//
//  SettingWorkerViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import MessageUI
import UIKit

class SettingWorkerViewController: UIViewController {
    
    // MARK: - View

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let header = ["","","",""]
    private let data = [["개인 정보 수정"],["고객 센터 문의하기"],["이용 약관","개인정보 처리방침","개발자 정보","버전 정보"],["로그 아웃","회원 탈퇴"]]

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
        let cell = UITableViewCell(style: .value1, reuseIdentifier: .none)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        
        if indexPath == [2,3] {
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            cell.detailTextLabel?.text = version
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath
        {
        case [0,0]:
            // TODO: - 추후 수정 예정
            print("개인 정보 수정")
        case [1,0]:
            self.sendReportMail()
        case [2,0]:
            if let url = URL(string: "https://giwazip.notion.site/c9ce45548c834d6d9ab91a139c489a2c") {
                UIApplication.shared.open(url)
            }
        case [2,1]:
            if let url = URL(string: "https://giwazip.notion.site/c9ce45548c834d6d9ab91a139c489a2c") {
                UIApplication.shared.open(url)
            }
        case [2,2]:
            self.navigationController?.pushViewController(DeveloperViewController(), animated: true)
        case [2,3]:
            self.navigationController?.pushViewController(VersionViewController(), animated: true)
        case [3,0]:
            print("로그 아웃")
        case [3,1]:
            print("회원 탈퇴")
        default:
            break
        }
    }
}

extension SettingWorkerViewController: MFMailComposeViewControllerDelegate {
    func sendReportMail() {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            let Email = "samsamhada0915@gmail.com"
            let messageBody = """
                              
                              -----------------------------
                              
                              - 성함:
                              - 전화번호:
                              - 문의 메시지 제목 한줄 요약:
                              - 문의 날짜: \(Date())
                              
                              ------------------------------
                              
                              문의 내용을 작성해주세요.
                              
                              """
            
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([Email])
            composeVC.setSubject("[문의 사항]")
            composeVC.setMessageBody(messageBody, isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        }
        else {
            self.showSendMailErrorAlert()
        }
    }
    
    private func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
