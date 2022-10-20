//
//  PostingCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/17.
//

import UIKit

class PostingCategoryViewController: UIViewController {
    
    // MARK: - View
    
    let categoryView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let nextBtn: UIButton = {
        $0.backgroundColor = .blue
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapNextBtn(_sender:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func layout() {
        view.addSubview(categoryView)
        view.addSubview(nextBtn)
        
        categoryView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBtn.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
        nextBtn.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func attribute() {
        self.view.backgroundColor = .white
        
        setNavigationTitle()

        categoryView.delegate = self
        categoryView.dataSource = self
        categoryView.allowsMultipleSelection = true
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
    }
    
    private func setNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "시공 상황 작성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func tapNextBtn(_sender: UIButton) {
        let vc = PostingImageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension PostingCategoryViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.categoryImage.image = UIImage(named:"category1")
        cell.categoryTitle.text = "\(indexPath.item+1) 카테고리"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == false {
            cell?.isSelected = true
            return true
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true {
            cell?.isSelected = false
            return true
        }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  (view.frame.width - 48)/3
        let cellHeight = 120
        return CGSize(width: Int(cellWidth), height: Int(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 8, left: 8, bottom: 16, right: 8)
    }
}

