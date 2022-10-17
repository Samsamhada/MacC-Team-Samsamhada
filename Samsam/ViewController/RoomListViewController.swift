//
//  RoomListViewController.swift
//  Samsam
//
//  Created by 김민택 on 2022/10/17.
//

import UIKit

class RoomListViewController: UIViewController {
    
    // MARK: - View
    
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
        view.addSubview(collectionView)
        
        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func setupNavigationTitle() {
        navigationController?.navigationBar.topItem?.title = "앱 이름"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
    }
}
