//
//  SegmentedControlViewcontroller.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/02.
//

import UIKit

class SegmentedControlViewController: UIViewController {
    
    // MARK: - Property
    
    var roomID: Int?
    
    // MARK: - View
    
    private let pageControlBackgroundView: UIView = {
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    private let segmentedControl: UISegmentedControl = {
        return $0
    }(UISegmentedControl(items: ["시공내역", "문의내역"]))
    
    private let workingHistoryView: WorkingHistoryViewController = {
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
                          navigationOrientation: .horizontal,
                          options: nil))
    
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
        coreDataManager.loadOneRoomData(roomID: roomID!)
        coreDataManager.loadPostingData(roomID: roomID!)
    }
    
    // MARK: - Method
    
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
    
    // MARK: - Method
    
    private func setNavigationBar() {
        navigationItem.title = coreDataManager.oneRoom?.clientName
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
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control: )), for: .valueChanged)
        
        self.changeValue(control: self.segmentedControl)
    }
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        segmentedControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segmentedControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    @objc func changeValue(control: UISegmentedControl) {
        self.currentViewNumber = control.selectedSegmentIndex
    }

    @objc func tapWritingButton() {
        let postingCategoryViewController = PostingCategoryViewController()
        postingCategoryViewController.roomID = roomID
        let navigationController = UINavigationController(rootViewController: postingCategoryViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated:  true, completion: nil)
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

