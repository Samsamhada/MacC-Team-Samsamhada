//
//  WorkingHistoryViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/17.
//

import UIKit

class WorkingHistoryViewController: UIViewController {

    // MARK: - Property
    
    let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var statuses: [Status]?
    var posts = [Post]() {
        didSet {
            pleaseWriteLabel.isHidden = (!posts.isEmpty ? true : false)

            posts.forEach {
                postDate.insert(String($0.createDate.dropLast(14)))
            }
            dateArray = postDate.sorted(by: {$0 > $1})
            workingHistoryView.reloadData()
        }
    }
    
    var isChangedSegment: Bool = true
    var dateArray: [String] = []
    var room: Room?
    var postDate = Set<String>()

    // MARK: - View

    private let workingHistoryView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let pleaseWriteLabel: UILabel = {
        $0.text = """
                  아직 작업내용이 없어요
                  시공 내용을 작성해주세요!
                  """
        $0.numberOfLines = 2
        $0.textColor = .gray
        $0.textAlignment = .center
        return $0
    }(UILabel())

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
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
        view.addSubview(pleaseWriteLabel)

        workingHistoryView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )

        pleaseWriteLabel.anchor(
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
        return postDate.count + 1
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
            
            topHeader.progressDuration.text = "진행상황(\(String((room?.startDate.dropText(first: 2, last: 14).replacingOccurrences(of: "-", with: "."))!)) ~ \(String((room?.endDate.dropText(first: 2, last: 14).replacingOccurrences(of: "-", with: "."))!)))"

            return topHeader
        } else {
            let contentHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkingHistoryViewContentHeader.identifier, for: indexPath) as! WorkingHistoryViewContentHeader

            var createDates = dateArray[indexPath.section - 1]
            createDates.insert("년", at: createDates.index(createDates.startIndex, offsetBy: 4))
            createDates.insert("월", at: createDates.index(createDates.startIndex, offsetBy: 8))
            createDates.insert("일", at: createDates.index(createDates.startIndex, offsetBy: 12))
            createDates = createDates.dropFirst(2).replacingOccurrences(of: "-", with: " ")

            contentHeader.uploadDate.text = createDates
            
            return contentHeader
        }
    }

    // MARK: - Cell

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewTopCell.identifier, for: indexPath) as! WorkingHistoryViewTopCell

            if isChangedSegment {
                topCell.viewAll.addTarget(self, action: #selector(tapAllView), for: .touchUpInside)
            } else {
                topCell.isHidden = true
            }

            return topCell
        } else {
            let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkingHistoryViewContentCell.identifier, for: indexPath) as! WorkingHistoryViewContentCell

            contentCell.imageDescription.text = posts[indexPath.item].description
            contentCell.workType.text = Category.categoryName(Category(rawValue: posts[indexPath.item].category)!)()
            if isChangedSegment {
                contentCell.workType.text = Category.categoryName(Category(rawValue: everyDayPosts[indexPath.item].category)!)()
            } else {
                contentCell.workType.text = ""
                contentCell.workTypeView.isHidden = true
            }
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: URL(string: self.posts[indexPath.item].photos![0].photoPath)!)
                DispatchQueue.main.async {
                    contentCell.uiImageView.image = UIImage(data: data!)
                }
            }
            return contentCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            let width = UIScreen.main.bounds.width
            var cellHeight = 30
            
            if !isChangedSegment {
                
                // FIXME: - cellHeight값이 0이면, 게시물이 보이지 않는 문제 식별
                
                cellHeight = 1
            }
            
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
            detailViewController.descriptionLBL.text = posts[indexPath.item].description
            
            posts[indexPath.item].photos!.forEach {
                detailViewController.images.append($0)
            }
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    @objc func tapAllView() {
        let chipViewController = ChipViewController()
        chipViewController.room = room
        chipViewController.posts = posts
        chipViewController.statuses = statuses
        navigationController?.pushViewController(chipViewController , animated: true)
    }
}
