//
//  PostingCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/17.
//

import UIKit

class PostingCategoryViewController: UIViewController {

    // MARK: - Property
    
    var roomID: Int?
    var room: Room?
    private var roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var categoryID: Int? {
        didSet {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = AppColor.giwazipBlue
        }
    }
    private var status: [Status]? {
        didSet {
            status = status!.sorted(by: {$0.category < $1.category})
            categoryView.reloadData()
        }
    }

    // MARK: - View

    private let categoryView: UICollectionView = {
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    private let nextBtn: UIButton = {
        $0.backgroundColor = .gray
        $0.setTitle("다음", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        loadStatusesByRoomID(roomID: room?.roomID ?? 1)
    }

    // MARK: - Method

    private func layout() {
        view.addSubview(categoryView)
        view.addSubview(nextBtn)

        categoryView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBtn.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20
        )

        nextBtn.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }

    private func attribute() {
        view.backgroundColor = AppColor.backgroundGray

        setNavigationTitle()

        categoryView.delegate = self
        categoryView.dataSource = self
        categoryView.allowsMultipleSelection = false
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private func setNavigationTitle() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeBTN)
        )
        navigationItem.title = "시공 상황 작성"
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }

    @objc func tapNextBtn(_sender: UIButton) {
        let postingImageViewController = PostingImageViewController()
        postingImageViewController.room = room
        postingImageViewController.categoryID = categoryID
        navigationController?.pushViewController(postingImageViewController, animated: true)
    }

    func loadStatusesByRoomID(roomID: Int) {
        Task {
            let response = try await self.roomAPI.loadStatusesByRoomID(roomID: room!.roomID)
            guard let data = response else {
                return
            }
            status = data
        }
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension PostingCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell

        let category: Category = Category(rawValue: status![indexPath.item].category)!
        cell.categoryImage.image = UIImage(named: category.categoryImage())
        cell.categoryName.text = "\(category.categoryName())"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        categoryID = status![indexPath.item].category
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 48)/3
        let cellHeight = cellWidth * 1.21
        return CGSize(width: Int(cellWidth), height: Int(cellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 80, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    @objc private func closeBTN() {
        self.dismiss(animated: true)
    }
}
