//
//  DeveloperViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/23.
//

import UIKit

class DeveloperViewController: UIViewController {
    
    // MARK: - View
    
    private let vStack: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private lazy var eddyButton: UIButton = {
        $0.setImage(UIImage(named: "Eddy"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 100
        $0.tag = 1
        $0.addTarget(self, action: #selector(tapButton(name:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var meenuButton: UIButton = {
        $0.setImage(UIImage(named: "Meenu"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 100
        $0.tag = 2
        $0.addTarget(self, action: #selector(tapButton(name:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var dinnerButton: UIButton = {
        $0.setImage(UIImage(named: "Dinner"), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 100
        $0.tag = 3
        $0.addTarget(self, action: #selector(tapButton(name:)), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        layout()
    }
    
    // MARK: - Method
    
    private func layout() {
        view.addSubview(eddyButton)
        view.addSubview(meenuButton)
        view.addSubview(dinnerButton)
        
        eddyButton.anchor(
            bottom: meenuButton.topAnchor,
            paddingBottom: 50,
            width: 200,
            height: 200
        )
        eddyButton.centerX(inView: self.view)
        
        meenuButton.anchor(
            width: 200,
            height: 200
        )
        meenuButton.centerX(inView: self.view)
        meenuButton.centerY(inView: self.view)
        
        dinnerButton.anchor(
            top: meenuButton.bottomAnchor,
            paddingTop: 50,
            width: 200,
            height: 200
        )
        dinnerButton.centerX(inView: self.view)
    }
    
    @objc func tapButton(name sender: UIButton) {
        switch sender.tag
        {
        case 1:
            if let url = URL(string: "https://github.com/juny0110") {
                UIApplication.shared.open(url)
        }
        case 2:
            if let url = URL(string: "https://github.com/taek0622") {
                UIApplication.shared.open(url)
        }
        case 3:
            if let url = URL(string: "https://github.com/creohwan") {
                UIApplication.shared.open(url)
        }
        default:
            break
        }
    }
}
