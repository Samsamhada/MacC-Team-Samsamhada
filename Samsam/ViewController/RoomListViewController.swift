//
//  RoomListViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class RoomListViewController: UIViewController {
    
    // MARK: - View
    
    private let creationButton: UIButton = {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .black
        $0.setTitle("고객 추가하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 10
        return $0
    }(UIButton())
    
    private let collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        
        setupNavigationTitle()
        setupCollectionView()
    }
    
    private func layout() {
        view.addSubview(creationButton)
        view.addSubview(collectionView)
        
        creationButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: collectionView.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16,
            height: 90
        )
        
        collectionView.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func setupNavigationTitle() {
        navigationController?.navigationBar.topItem?.title = "앱 이름"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(RoomListCell.self, forCellWithReuseIdentifier: RoomListCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension RoomListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomListCell.identifier, for: indexPath) as! RoomListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 90)
    }
}
