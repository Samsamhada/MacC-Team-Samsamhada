//
//  WorkingHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewController: UIViewController {
    
    // MARK: - View
    
    private let workingHistoryView: UICollectionView = {
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
        workingHistoryView.reloadData()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        
        workingHistoryView.delegate = self
        workingHistoryView.dataSource = self
        
        workingHistoryView.register(WorkingHistoryViewTopHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorkingHistoryViewTopHeader.identifier)
        workingHistoryView.register(WorkingHistoryViewContentHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorkingHistoryViewContentHeader.identifier)
        workingHistoryView.register(WorkingHistoryViewTopCell.self, forCellWithReuseIdentifier: WorkingHistoryViewTopCell.identifier)
        workingHistoryView.register(WorkingHistoryViewContentCell.self, forCellWithReuseIdentifier: WorkingHistoryViewContentCell.identifier)
    }
    
    private func layout() {
        view.addSubview(workingHistoryView)
        
        workingHistoryView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
}

extension WorkingHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Header
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let topHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkingHistoryViewTopHeader.identifier, for: indexPath) as! WorkingHistoryViewTopHeader
            
            topHeader.progressDuration.text = "진행상황(10.11 ~ 11.12)"
            
            return topHeader
        } else {
            let contentHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkingHistoryViewContentHeader.identifier, for: indexPath) as! WorkingHistoryViewContentHeader
            
            contentHeader.uploadDate.text = "10월 12일"
            
            return contentHeader
        }
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return coreDataManager.postings.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewTopCell.identifier, for: indexPath) as! WorkingHistoryViewTopCell
            topCell.viewAll.addTarget(self, action: #selector(tapAllView), for: .touchUpInside)
            return topCell
        } else {
            let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewContentCell.identifier, for: indexPath) as! WorkingHistoryViewContentCell
            coreDataManager.loadPhotoData(postingID: indexPath.item + 1)
            
            contentCell.uiImageView.image = UIImage(data: coreDataManager.photos[0].photoPath!)
            contentCell.imageDescription.text = coreDataManager.postings[indexPath.item].explanation
            contentCell.workType.text = Category.categoryName(Category(rawValue: Int(coreDataManager.postings[indexPath.item].categoryID))!)()
            
            return contentCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let width = UIScreen.main.bounds.width
            let cellHeight = 30
            return CGSize(width: Int(width), height: cellHeight)
        } else {
            let width = UIScreen.main.bounds.width - 32
            let cellHeight = width / 4 * 3 + 30
            
            return CGSize(width: Int(width), height: Int(cellHeight))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section > 0 {
            let detailViewController = DetailViewController()
            coreDataManager.loadPhotoData(postingID: indexPath.item + 1)
            detailViewController.images = coreDataManager.photos
            coreDataManager.postings.forEach {
                if $0 == coreDataManager.postings[indexPath.item] {
                    detailViewController.descriptionLBL.text = $0.explanation
                }
            }
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @objc func tapAllView() {
        let chipViewController = ViewController()
        navigationController?.pushViewController(chipViewController , animated: true)
    }
}
