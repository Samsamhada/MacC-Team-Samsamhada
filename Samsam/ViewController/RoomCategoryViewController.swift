//
//  RoomCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/20.
//

import UIKit

class RoomCategoryViewController: UIViewController {
    
    // MARK: - View

    private lazy var textTitle: UILabel = {
        $0.text = ""
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let nextBTN: UIButton = {
        $0.backgroundColor = .blue
        $0.setTitle("방 생성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapNextBTN(_sender:)), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        setNavigationTitle()
        setTitleText()
    }
    
    private func layout() {
        view.addSubview(textTitle)
        view.addSubview(nextBTN)
        
        textTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 30,
            height: 20
        )
        
        nextBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }
    
    private func setNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "방 생성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setTitleText() {
        let statement = "시공 과정을 모두 선택해주세요".getColoredText("모두", .red)
        textTitle.text = ""
        textTitle.attributedText = statement
    }
    
    @objc func tapNextBTN(_sender: UIButton) {
        let vc = RoomCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

extension String {
    func getColoredText(_ text: String, _ color: UIColor) -> NSMutableAttributedString {
        let nsString = NSMutableAttributedString(string: self)
        nsString.setColorForText(textToFind: self, withColor: UIColor.black)
        nsString.setColorForText(textToFind: text, withColor: color)
        return nsString
    }
}

