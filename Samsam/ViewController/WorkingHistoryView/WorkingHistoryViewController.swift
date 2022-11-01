//
//  WorkingHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewController: UIViewController {
    
    // MARK: - Property
    
    var roomID: Int?
    var views: [UIView?] = []
    var index = 0
    
    // MARK: - View
    
    private let segmentedControl: UISegmentedControl = {
        $0.tintColor = .black
        $0.backgroundColor = .clear
        $0.selectedSegmentIndex = 0
        $0.addTarget(self, action: #selector(tapSegmentButton), for: .valueChanged)
        return $0
    }(UISegmentedControl(items: ["시공내역", "문의내역"]))
    
    private let writingButton: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("시공상황 작성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())
    
    private let workingHistoryView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let inquiryHistoryView: UIView = {
        $0.backgroundColor = .black
        return $0
    }(UIView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreDataManager.loadOneRoomData(roomID: roomID!)
        coreDataManager.loadPostingData(roomID: roomID!)
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
        
        writingButton.addTarget(self, action: #selector(tapWritingButton), for: .touchDown)
    }
    
    private func layout() {
        view.addSubview(segmentedControl)
        view.addSubview(inquiryHistoryView)
        view.addSubview(workingHistoryView)
        view.addSubview(writingButton)
        
        segmentedControl.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
        inquiryHistoryView.anchor(
            top: segmentedControl.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16
        )
        
        workingHistoryView.anchor(
            top: segmentedControl.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 16
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
        navigationItem.title = coreDataManager.oneRoom?.clientName
        navigationController?.navigationBar.prefersLargeTitles = false
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(tapSettingButton))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tapWritingButton() {
        let postingCategoryViewController = PostingCategoryViewController()
        postingCategoryViewController.roomID = roomID
        let navigationController = UINavigationController(rootViewController: postingCategoryViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated:  true, completion: nil)
    }
    
    @objc func tapSettingButton() {
        let settingViewController = ViewController()
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc func tapSegmentButton() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(workingHistoryView)
            self.view.bringSubviewToFront(writingButton)
        case 1:
            self.view.bringSubviewToFront(inquiryHistoryView)
            self.view.bringSubviewToFront(writingButton)
        default:
            break
        }
    }
    
    func moveToFrame(contentOffset : CGFloat) {

        let frame: CGRect = CGRect(
            x: contentOffset,
            y: self.workingHistoryView.contentOffset.y,
            width: self.workingHistoryView.frame.width,
            height: self.workingHistoryView.frame.height
        )
        self.workingHistoryView.scrollRectToVisible(frame, animated: true)
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
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
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
            coreDataManager.loadPhotoData(postingID: indexPath.item)
            
            contentCell.uiImageView.image = UIImage(data: coreDataManager.photos[0].photoPath!)
            contentCell.imageDescription.text = coreDataManager.postings[indexPath.item].explanation
            contentCell.workType.text = Category.categoryName(Category(rawValue: Int(coreDataManager.postings[indexPath.item].categoryID))!)()
            
            return contentCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let width = UIScreen.main.bounds.width
            let cellHeight = 20
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
            coreDataManager.loadPhotoData(postingID: indexPath.item)
            detailViewController.images = coreDataManager.photos
            coreDataManager.postings.forEach {
                if $0.postingID == indexPath.item + 1 {
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
