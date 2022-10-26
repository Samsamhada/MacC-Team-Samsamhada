//
//  RoomCodeViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/21.
//

import UIKit

var code = "ASD12d"

class RoomCodeViewController: UIViewController {
    
    // MARK: - View
    
    private var mainTitle: UILabel = {
        $0.text = "방 생성이 완료되었습니다!"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var contentView: UIImageView = {
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private var inviteLabel: UILabel = {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "arrowshape.turn.up.forward")
        let attachmentString = NSAttributedString(attachment: attachment)
        let text = NSMutableAttributedString(string: "초대 코드 ")
        text.append(attachmentString)
        $0.attributedText = text
        
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private var detailLabel: UILabel = {
        $0.text = "초대 코드 글자를 눌러 복사하세요"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .center
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    private var inviteBTN: UIButton = {
        $0.setTitle(code, for: .normal)
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
        self.contentView.addSubview(detailLabel)
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
        
        inviteBTN.anchor(
            top: inviteLabel.bottomAnchor
        )
        inviteBTN.centerX(inView: contentView)
        
        detailLabel.anchor(
            top: inviteBTN.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
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
    
    @objc func copyCode() {
        UIPasteboard.general.string = code
        showToast()
    }
    
    private func showToast() {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.text = "초대 코드 복사가 완료되었습니다!"
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.alpha = 0
        self.view.addSubview(label)
        
        label.anchor(
            bottom: finishBTN.topAnchor,
            paddingBottom: 30,
            width: 240,
            height: 30
        )
        label.centerX(inView: self.view)
        
        UIView.animate(withDuration: 1.5, animations: {
            label.alpha = 0.8
        }, completion: { isCompleted in
                UIView.animate(withDuration: 1.5, animations: {
                    label.alpha = 0
                }, completion: { isCompleted in
                        label.removeFromSuperview()
                    })
            })
    }
    
    @objc func doneBTN() {
        navigationController?.popToRootViewController(animated: true)
    }
}
