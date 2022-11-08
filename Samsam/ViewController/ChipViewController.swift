//
//  ChipViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/07.
//

import UIKit

class ChipViewController: UIViewController {
    
    // MARK: - Property
    
    var roomID: Int?
    var chips: [UIButton] = []
    var categoryID: [Int] = []
    var selectedID: Int = 0
    var selectedCategoryItem: [PostingEntity] = []
    
    // MARK: - View
    
    private var chipScrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    private var chipContentView: UIStackView = {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 10
        return $0
    }(UIStackView())

    private var historyView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataManager.loadOneRoomData(roomID: roomID!)
        coreDataManager.loadPostingData(roomID: roomID!)
        coreDataManager.loadWorkingStatusData(roomID: roomID!)
        historyView.reloadData()
    }
    
    // MARK: - Method
    
    private func layout() {
        view.addSubview(chipScrollView)
        chipScrollView.addSubview(chipContentView)
        view.addSubview(historyView)
        
        chipScrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 60
        )
        
        chipContentView.anchor(
            top: chipScrollView.contentLayoutGuide.topAnchor,
            left: chipScrollView.contentLayoutGuide.leftAnchor,
            bottom: chipScrollView.contentLayoutGuide.bottomAnchor,
            right: chipScrollView.contentLayoutGuide.rightAnchor,
            height: 60
        )
        
        historyView.anchor(
            top:chipScrollView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func attribute() {
        view.backgroundColor = .white
        
        setChip()
        
        historyView.delegate = self
        historyView.dataSource = self
        historyView.register(WorkingHistoryViewContentCell.self, forCellWithReuseIdentifier: WorkingHistoryViewContentCell.identifier)
    }
    
    private func setChip() {
        
        chips.append(makeButton(title: "  전체  ", tag: 0))
        
        for i in stride(from: 1, to: coreDataManager.workingStatuses.count + 1, by: 1) {
            chips.append(makeButton(title: "  "+Category(rawValue: Int(coreDataManager.workingStatuses[i-1].categoryID))!.categoryName()+"  ", tag: i))
            categoryID.append(Int(coreDataManager.workingStatuses[i-1].categoryID))
        }
        
        chips.forEach {
            chipContentView.addArrangedSubview($0)
        }
        
        selectedButton(UIButton: chips[selectedID])
    }
    
    private func makeButton(title: String, tag: Int) -> UIButton {
        lazy var button = UIButton()
        button.setTitleColor(AppColor.campanulaBlue, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = AppColor.campanulaBlue?.cgColor
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(selectButton(name:)), for: .touchUpInside)
        button.tag = tag
        return button
    }
    
    @objc private func selectButton(name sender: UIButton) {
        if selectedID != sender.tag {
            didSelectedButton(UIButton: chips[selectedID])
            selectedID = sender.tag
            selectedButton(UIButton: chips[selectedID])
            selectedCategoryItem = []
            historyView.reloadData()
        }
    }
    
    private func selectedButton(UIButton: UIButton) {
        UIButton.setTitleColor(.white, for: .normal)
        UIButton.backgroundColor = AppColor.campanulaBlue
    }

    private func didSelectedButton(UIButton: UIButton) {
        UIButton.setTitleColor(AppColor.campanulaBlue, for: .normal)
        UIButton.backgroundColor = .white
    }
}

extension ChipViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedID == 0 {
            return coreDataManager.postings.count
        } else {
            coreDataManager.postings.forEach {
                if $0.categoryID == categoryID[selectedID-1] {
                    selectedCategoryItem.append($0)
                }
            }
            return selectedCategoryItem.count
        }
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewContentCell.identifier, for: indexPath) as! WorkingHistoryViewContentCell
        
        if selectedID == 0 {
            coreDataManager.loadPhotoData(postingID: Int(coreDataManager.postings[indexPath.item].postingID))
            contentCell.uiImageView.image = UIImage(data: coreDataManager.photos[0].photoPath!)
            contentCell.imageDescription.text = coreDataManager.postings[indexPath.item].explanation
            contentCell.workType.text = Category.categoryName(Category(rawValue: Int(coreDataManager.postings[indexPath.item].categoryID))!)()
        } else {
            coreDataManager.loadPhotoData(postingID: Int(selectedCategoryItem[indexPath.item].postingID))
            contentCell.uiImageView.image = UIImage(data: coreDataManager.photos[0].photoPath!)
            contentCell.imageDescription.text = selectedCategoryItem[indexPath.item].explanation
            contentCell.workType.text = Category.categoryName(Category(rawValue: Int(selectedCategoryItem[indexPath.item].categoryID))!)()
        }
        return contentCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = width / 4 * 3 + 30
        return CGSize(width: Int(width), height: Int(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        coreDataManager.loadPhotoData(postingID: Int(coreDataManager.postings[indexPath.item].postingID))
        detailViewController.images = coreDataManager.photos
        coreDataManager.postings.forEach {
            if $0 == coreDataManager.postings[indexPath.item] {
                detailViewController.descriptionLBL.text = $0.explanation
            }
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}
