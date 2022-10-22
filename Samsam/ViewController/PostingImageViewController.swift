//
//  PostingImageViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/18.
//

import UIKit

class PostingImageViewController: UIViewController {
    
    // MARK: - View
    
    private var titleText: UILabel = {
        $0.text = "시공한 사진을 추가해주세요. \n (최대 4장까지 가능합니다)."
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let nextBTN: UIButton = {
        $0.backgroundColor = .blue
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
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
        self.view.backgroundColor = .white
        setNavigationTitle()
    }
    
    private func layout() {
        self.view.addSubview(nextBTN)
        self.view.addSubview(titleText)
        
        nextBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
        
        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 12,
            paddingLeft: 50,
            paddingRight: 50,
            height: 50
        )
    }
    
    private func setNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.topItem?.title = "시공 상황 작성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func tapNextBTN() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
