//
//  InquiryHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/01.
//

import UIKit

class InquiryHistoryViewController: UIViewController {
    
    // MARK: - View
    
    private let inquiryHistoryView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inquiryHistoryView.reloadData()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        
        inquiryHistoryView.delegate = self
        inquiryHistoryView.dataSource = self

        inquiryHistoryView.register(InquiryCell.self, forCellWithReuseIdentifier: InquiryCell.identifier)
    }
    
    private func layout() {
        view.addSubview(inquiryHistoryView)
        
        inquiryHistoryView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
}

extension InquiryHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InquiryCell.identifier, for: indexPath) as! InquiryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = width / 4 * 3 + 30
        return CGSize(width: Int(width), height: Int(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
