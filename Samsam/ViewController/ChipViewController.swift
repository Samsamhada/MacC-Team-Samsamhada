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
    
    private var chips: [UIButton] = []
    var categoryID: Int = 0
    private var selectedID: Int = 0

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
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    private lazy var writingButton: UIButton = {
        $0.backgroundColor = AppColor.giwazipBlue
        $0.setTitle("시공상황 작성하기", for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
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
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )

        writingButton.anchor(
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            height: 90
        )
    }

    private func attribute() {
        historyView.contentInset.bottom = 80
        
        view.backgroundColor = AppColor.backgroundGray

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
            chips.append(makeButton(title: "  " + (Category(rawValue: Int(statuses![i-1].category))?.categoryName())! + "  ", tag: i))        }

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
                if $0.category == statuses![selectedID - 1].category{
                    selectedPosts.append($0)
                }
            }
            return selectedPosts.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewContentCell.identifier, for: indexPath) as! WorkingHistoryViewContentCell
        
        let selectedArray = (selectedID == 0 ? posts : selectedPosts)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: selectedArray[indexPath.item].photos![0].photoPath)!)
            
            DispatchQueue.main.async {
                contentCell.uiImageView.image = UIImage(data: data!)
                contentCell.imageDescription.text = selectedArray[indexPath.item].description
                contentCell.workType.text = Category(rawValue: Int(selectedArray[indexPath.item].category))?.categoryName()
            }
        }
        
        return contentCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.width - 32
        let cellHeight = width / 4 * 3
        return CGSize(width: Int(width), height: Int(cellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()

        let selectedArray = (selectedID == 0 ? posts : selectedPosts)
        
        detailViewController.descriptionLBL.text = selectedArray[indexPath.item].description
        
        selectedArray[indexPath.item].photos!.forEach {
            detailViewController.images.append($0)
        }
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
