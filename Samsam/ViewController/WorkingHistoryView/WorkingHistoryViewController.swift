//
//  WorkingHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewController: UIViewController {

    // MARK: - View
    
    private let writingButton: UIButton = {
        $0.backgroundColor = .yellow
        $0.setTitle("시공상황 작성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())
    
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
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .white
        setNavigationBar()
        
        workingHistoryView.delegate = self
        workingHistoryView.dataSource = self
        
        workingHistoryView.register(WorkingHistoryViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WorkingHistoryViewHeader.identifier)
        workingHistoryView.register(WorkingHistoryViewCell.self, forCellWithReuseIdentifier: WorkingHistoryViewCell.identifier)
        
        writingButton.addTarget(self, action: #selector(tapWritingButton), for: .touchDown)
    }
    
    private func layout() {
        view.addSubview(workingHistoryView)
        view.addSubview(writingButton)
        
        workingHistoryView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )

        writingButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }
    
    // MARK: - Method
    
    private func setNavigationBar() {
        navigationItem.title = "포항공대 포스빌"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // TODO: - postingCategoryView를 FullScreen모달로 띄우는 기능. 추후 수정

    @objc func tapWritingButton() {
        let postingCategoryView = ViewController()
        postingCategoryView.modalPresentationStyle = .fullScreen
        present(postingCategoryView, animated:  true, completion: nil)
    }
}

extension WorkingHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Header
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkingHistoryViewHeader.identifier, for: indexPath) as! WorkingHistoryViewHeader
        header.uploadDate.text = "10월 12일"
        
        return header
    }
    
    // MARK: - Cell
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewCell.identifier, for: indexPath) as! WorkingHistoryViewCell
        cell.imageDescription.text = "애플, 동아시아 최초 '디벨로퍼 아카데미' 한국서 운영"
        cell.imageDescription.textAlignment = .center
        cell.imageDescription.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        let tapContents = UITapGestureRecognizer(target: self, action: #selector(tapContents))
        cell.vStack.addGestureRecognizer(tapContents)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = width / 4 * 3 + 30
        
        return CGSize(width: Int(width), height: Int(cellHeight))
    }
    
    @objc func tapContents() {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
