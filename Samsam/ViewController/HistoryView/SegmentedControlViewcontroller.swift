//
//  SegmentedControlViewcontroller.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/02.
//

import UIKit

class SegmentedControlViewController: UIViewController {

    // MARK: - Property

    let roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var room: Room?
    var posts = [Post]() {
        didSet {
            posts.forEach {
                loadPhotoByRoom(postID: $0.postID)
            }
            posts = posts.reversed()
        }
    }
    var photos = [Photo]() {
        didSet {
            if photos.count == posts.count {
                for i in 0..<posts.count {
                    url.append(URL(string: photos[i].photoPath)!)
                }
                workingHistoryView.url = url.reversed()
            }
        }
    }
    var url: [URL] = []

    // MARK: - View

    private let pageControlBackgroundView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())

    private let segmentedControl: UISegmentedControl = {
        return $0
    }(UISegmentedControl(items: ["시공내역", "문의내역"]))

    private lazy var workingHistoryView: WorkingHistoryViewController = {
        $0.room = room
        return $0
    }(WorkingHistoryViewController())

    private let inquiryHistoryView: InquiryHistoryViewController = {
        return $0
    }(InquiryHistoryViewController())

    private lazy var dataViewControllers: [UIViewController] = [workingHistoryView, inquiryHistoryView]

    private lazy var pageViewController: UIPageViewController = {
        $0.setViewControllers([dataViewControllers[0]],
                              direction: .forward,
                              animated: true)
        return $0
    }(UIPageViewController(transitionStyle: .scroll,
                          navigationOrientation: .horizontal))

    private let writingButton: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("시공상황 작성하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())

    private var currentViewNumber: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = (oldValue <= currentViewNumber ? .forward : .reverse)
            pageViewController.setViewControllers([dataViewControllers[self.currentViewNumber]], direction: direction, animated: true)
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        attribute()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setRoomCategoryID()
        loadPostByRoom(roomID: room!.roomID)
    }

    // MARK: - Method

    // TODO: - 카테고리 설정을 위한 코드
    
    private func setRoomCategoryID() {
//        roomCategoryID = []
//        coreDataManager.workingStatuses.forEach {
//            roomCategoryID.append(Int($0.categoryID))
//        }
    }

    private func attribute() {
        view.backgroundColor = .white

        setSegmentedControl()

        pageViewController.delegate = self
        pageViewController.dataSource = self

        writingButton.addTarget(self, action: #selector(tapWritingButton), for: .touchDown)
    }

    private func layout() {
        view.addSubview(segmentedControl)
        view.addSubview(pageControlBackgroundView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(writingButton)

        segmentedControl.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            width: 180,
            height: 40
        )

        pageControlBackgroundView.anchor(
            top: segmentedControl.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )

        pageViewController.view.anchor(
            top: pageControlBackgroundView.topAnchor,
            left: pageControlBackgroundView.leftAnchor,
            bottom: pageControlBackgroundView.bottomAnchor,
            right: pageControlBackgroundView.rightAnchor
        )
        pageViewController.didMove(toParent: self)

        writingButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func setNavigationBar() {
        navigationItem.title = room?.clientName
        navigationController?.navigationBar.prefersLargeTitles = false
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(tapSettingButton))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func tapSettingButton() {
        let settingViewController = ViewController()
        navigationController?.pushViewController(settingViewController, animated: true)
    }

    private func setSegmentedControl() {
        removeBackgroundAndDivider()

        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .selected)
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(changeValue), for: .valueChanged)

        self.changeValue(control: self.segmentedControl)
    }

    private func removeBackgroundAndDivider() {
        let image = UIImage()
        segmentedControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .selected, barMetrics: .default)

        segmentedControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }

    @objc func changeValue(control: UISegmentedControl) {
        self.currentViewNumber = control.selectedSegmentIndex
    }

    @objc func tapWritingButton() {
        let postingCategoryViewController = PostingCategoryViewController()
        
        // TODO: - 시공상황작성하기 버튼 클릭 시, PostingCategoryView 작업에 필요한 내용.

//        postingCategoryViewController.roomID = roomID
//        postingCategoryViewController.roomCategoryID = roomCategoryID
        let navigationController = UINavigationController(rootViewController: postingCategoryViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated:  true, completion: nil)
    }
    
    private func loadPostByRoom(roomID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadPostByRoom(roomID: roomID)
                guard let data = response else {
                    return
                }
                posts = data
                workingHistoryView.post = posts
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
    private func loadPhotoByRoom(postID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadPhotobyroom(postID: postID)
                guard let data = response else {
                    return
                }
                photos.append(data[0])
                workingHistoryView.photos = photos
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
}

extension SegmentedControlViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        return dataViewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index + 1 < dataViewControllers.count else { return nil }
        return dataViewControllers[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let vc = pageViewController.viewControllers?[0],
            let index = self.dataViewControllers.firstIndex(of: vc)
        else { return }
        self.currentViewNumber = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}
