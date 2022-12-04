//
//  ChipViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/07.
//

import UIKit

class ChipViewController: UIViewController {

    // MARK: - Property

    var room: Room?
    var posts: [Post] = []
    var statuses: [Status]?

    var selectedPosts: [Post] = []
    
    var roomID: Int?
    private var chips: [UIButton] = []
    var categoryID: Int = 0
    private var categoryArray: [Int] = []
    private var selectedID: Int = 0
    private var selectedCategoryItem: [PostingEntity] = []

    // MARK: - View

    private let chipScrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        return $0
    }(UIScrollView())

    private let chipContentView: UIStackView = {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 10
        return $0
    }(UIStackView())

    private let historyView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    private lazy var writingButton: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("시공상황 작성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapWritingButton), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: - 칩뷰 데이터(이미지, 설명, 칩 정보) 로드
        
//        coreDataManager.loadOneRoomData(roomID: roomID!)
//        coreDataManager.loadPostingData(roomID: roomID!)
//        coreDataManager.loadWorkingStatusData(roomID: roomID!)
        historyView.reloadData()
    }

    // MARK: - Method

    private func layout() {
        view.addSubview(chipScrollView)
        chipScrollView.addSubview(chipContentView)
        view.addSubview(historyView)
        view.addSubview(writingButton)

        chipScrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            height: 60
        )

        chipContentView.anchor(
            top: chipScrollView.contentLayoutGuide.topAnchor,
            left: chipScrollView.contentLayoutGuide.leftAnchor,
            bottom: chipScrollView.contentLayoutGuide.bottomAnchor,
            right: chipScrollView.contentLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 60
        )

        historyView.anchor(
            top:chipScrollView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
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

    private func attribute() {
        view.backgroundColor = .white

        setChip()

        historyView.delegate = self
        historyView.dataSource = self
        historyView.register(WorkingHistoryViewContentCell.self, forCellWithReuseIdentifier: WorkingHistoryViewContentCell.identifier)
    }

    @objc func tapWritingButton() {
        let postingCategoryViewController = PostingCategoryViewController()
        postingCategoryViewController.room = room
        postingCategoryViewController.categoryID = categoryID

        let navigationController = UINavigationController(rootViewController: postingCategoryViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }

    private func setChip() {
        chips.append(makeButton(title: "  전체  ", tag: 0))

        for i in stride(from: 1, to: statuses!.count + 1, by: 1) {
            chips.append(makeButton(title: "  " + (Category(rawValue: Int(statuses![i-1].category))?.categoryName())! + "  ", tag: i))
            categoryArray.append(Int(statuses![i-1].category))
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
        button.addTarget(self, action: #selector(tapSelectedButton(name:)), for: .touchUpInside)
        button.tag = tag
        return button
    }

    @objc private func tapSelectedButton(name sender: UIButton) {
        if selectedID != sender.tag {
            unselectedButton(UIButton: chips[selectedID])
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

    private func unselectedButton(UIButton: UIButton) {
        UIButton.setTitleColor(AppColor.campanulaBlue, for: .normal)
        UIButton.backgroundColor = .white
    }
}

extension ChipViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedID == 0 {
            return posts.count
        }
        
        if selectedID > 0 {
            selectedPosts = []
            
            posts.forEach {
                if $0.category == categoryArray[selectedID - 1] {
                    selectedPosts.append($0)
                }
            }
            return selectedPosts.count
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewContentCell.identifier, for: indexPath) as! WorkingHistoryViewContentCell
        
        if self.selectedID == 0 {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: URL(string: self.posts[indexPath.item].photos![0].photoPath)!)
                
                DispatchQueue.main.async {
                    contentCell.uiImageView.image = UIImage(data: data!)
                    contentCell.imageDescription.text = self.posts[indexPath.item].description
                    contentCell.workType.text = Category(rawValue: Int(self.posts[indexPath.item].category))?.categoryName()
                }
            }
        } else {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: URL(string: self.selectedPosts[indexPath.item].photos![0].photoPath)!)
                
                DispatchQueue.main.async {
                    contentCell.uiImageView.image = UIImage(data: data!)
                    contentCell.imageDescription.text = self.selectedPosts[indexPath.item].description
                    contentCell.workType.text = Category(rawValue: Int(self.selectedPosts[indexPath.item].category))?.categoryName()
                }
            }
        }
        return contentCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width - 32
        let cellHeight = width / 4 * 3 + 30
        return CGSize(width: Int(width), height: Int(cellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailViewController = DetailViewController()
//        detailViewController.images = posts![indexPath.item].photos!
//        posts?.forEach {
//            if $0 == posts![indexPath.item] {
//                detailViewController.descriptionLBL.text = $0.description
//            }
//        }
//        coreDataManager.loadPhotoData(postingID: Int(coreDataManager.postings[indexPath.item].postingID))
//        detailViewController.images = coreDataManager.photos
//        coreDataManager.postings.forEach {
//            if $0 == coreDataManager.postings[indexPath.item] {
//                detailViewController.descriptionLBL.text = $0.explanation
//            }
//        }
//        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
