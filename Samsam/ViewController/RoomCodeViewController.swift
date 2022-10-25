//
//  RoomCodeViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/21.
//

import UIKit

var inviteCode = "ASD12d"

class RoomCodeViewController: UIViewController {
    
    // MARK: - View
    
    private var mainTitle: UILabel = {
        $0.text = "방 생성이 완료되었습니다!"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var contentView: UIImageView = {
        $0.backgroundColor = .yellow
        return $0
    }(UIImageView())
    
    private var inviteLabel: UILabel = {
        $0.text = "초대코드 􀉐 "
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var copyLabel: UILabel = {
        $0.text = "초대코드를 눌러 복사하세요"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    private var inviteBTN: UIButton = {
        $0.setTitle(inviteCode, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.setTitleColor(.blue, for: .normal)
        $0.addTarget(self, action: #selector(copyCode), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    private var finishBTN: UIButton = {
        $0.backgroundColor = .blue
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(doneBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        self.view.backgroundColor = .white
        setNavigationTitle()
    }
    
    private func layout() {
        self.view.addSubview(mainTitle)
        self.view.addSubview(contentView)
        self.contentView.addSubview(inviteLabel)
        self.contentView.addSubview(copyLabel)
        self.contentView.addSubview(inviteBTN)
        self.view.addSubview(finishBTN)
        
        mainTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 280,
            height: 20
        )
        
        contentView.anchor(
            top: mainTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 50,
            height: 100
        )
        
        inviteLabel.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
        )
        
        copyLabel.anchor(
            top: inviteBTN.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10
        )
        
        inviteBTN.anchor(
            top: inviteLabel.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10
        )
        
        finishBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }
    
    private func setNavigationTitle() {
        navigationController?.navigationBar.topItem?.title = "생성 완료"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func doneBTN() {
        navigationController?.popToRootViewController(animated: true)
        print("no")
    }
    
    @objc func copyCode() {
        print("Hi")
    }
}
