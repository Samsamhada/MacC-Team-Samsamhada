//
//  WorkingSelectionView.swift
//  Samsam
//
//  Created by creohwan on 2022/10/17.
//

import UIKit

class WorkingSelectionViewController: UIViewController {
    
    // MARK: - View
    let categoryView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle()
        attribute()

        categoryView.delegate = self
        categoryView.dataSource = self
        
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    // MARK: - Method

    private func attribute() {
        self.view.backgroundColor = .white
        view.addSubview(categoryView)
        categoryView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
    
    private func setNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.topItem?.title = "시공 상황 작성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout
extension WorkingSelectionViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        cell.categoryImage.image = UIImage(named:"category")
        cell.categoryTitle.text = "카테고리 텍스트"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  (view.frame.width - 48)/3
        let cellHeight = 120
        return CGSize(width: Int(cellWidth), height: Int(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    

}
