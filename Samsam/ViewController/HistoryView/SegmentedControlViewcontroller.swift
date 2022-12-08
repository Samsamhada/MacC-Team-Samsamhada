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
    var statuses: [Status]? {
        didSet {
            workingHistoryView.statuses = statuses
        }
    }
    var posts = [Post]() {
        didSet {
            workingHistoryView.posts = []
            inquiryHistoryView.posts = []
            posts.sort(by: {$0.postID > $1.postID})
            posts.forEach {
                if $0.type == 0 {
                    workingHistoryView.posts.append($0)
                }
                if $0.type == 1 {
                    inquiryHistoryView.posts.append($0)
                }
            }
        }
    }

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
        $0.isChangedSegment = true
        return $0
    }(WorkingHistoryViewController())

    private let inquiryHistoryView: WorkingHistoryViewController = {
        $0.isChangedSegment = false
        return $0
    }(WorkingHistoryViewController())

    private lazy var dataViewControllers: [UIViewController] = [workingHistoryView, inquiryHistoryView]

    private lazy var pageViewController: UIPageViewController = {
        $0.setViewControllers([dataViewControllers[0]],
                              direction: .forward,
                              animated: true)
        return $0
    }(UIPageViewController(transitionStyle: .scroll,
                          navigationOrientation: .horizontal))
    
    private var currentViewNumber: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = (oldValue <= currentViewNumber ? .forward : .reverse)
            pageViewController.setViewControllers([dataViewControllers[currentViewNumber]], direction: direction, animated: true)
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        loadStatusesByRoomID(roomID: room!.roomID)
        loadInquiryView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPostByRoomID(roomID: room!.roomID)
        loadRoomByRoomID(roomID: room!.roomID)
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .white

        setSegmentedControl()
        setNavigationBar()

        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func layout() {
        view.addSubview(segmentedControl)
        view.addSubview(pageControlBackgroundView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

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
    }

    private func setNavigationBar() {
        navigationItem.title = room?.clientName
        navigationController?.navigationBar.prefersLargeTitles = false
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(tapSettingButton))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    @objc func tapSettingButton() {
        let settingViewController = SettingRoomViewController()
        settingViewController.room = room
        navigationController?.pushViewController(settingViewController, animated: true)
    }

    private func setSegmentedControl() {
        removeBackgroundAndDivider()

        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .selected)
        
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(changeValue), for: .valueChanged)

        self.changeValue(control: segmentedControl)
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
    
    private func loadPostByRoomID(roomID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadPostByRoomID(roomID: roomID)
                guard let data = response else {
                    return
                }
                posts = data
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }

    private func loadRoomByRoomID(roomID: Int) {
        Task {
            do {
                let response = try await self.roomAPI.loadRoom(roomID: roomID)
                if let data = response {
                    room = data
                    setNavigationBar()
                }
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
    
    private func loadStatusesByRoomID(roomID: Int) {
        Task {
            let response = try await self.roomAPI.loadStatusesByRoomID(roomID: room!.roomID)
            guard let data = response else {
                return
            }
            statuses = data
        }
    }
    
    private func loadInquiryView() {
        inquiryHistoryView.room = room
        inquiryHistoryView.pleaseWriteLabel.text = "아직 문의내역이 없어요"
        inquiryHistoryView.writingButton.isHidden = true
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
            let index = dataViewControllers.firstIndex(of: vc)
        else { return }
        currentViewNumber = index
        segmentedControl.selectedSegmentIndex = index
    }
}
