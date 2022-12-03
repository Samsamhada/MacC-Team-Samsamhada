//
//  DetailViewController.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/18.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Property

    let screenWidth = UIScreen.main.bounds.width - 32

    private var naviTitle = "화장실"
    var images: [Photo] = []
    private var sharingItems: [Any] = []

    // MARK: - View

    private lazy var scrollView: UIScrollView = {

        // TODO: - 이미지 갯수만큼 스크롤 가능. 데이터 반영 시 Images를 수정하여 데이터 갯수만큼 지정.

        $0.contentSize = CGSize(
            width: Int(screenWidth) * images.count,
            height: Int(screenWidth) / 4 * 3
        )
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.layer.cornerRadius = 16
        return $0
    }(UIScrollView())

    private lazy var pageControl: UIPageControl = {

        // TODO: - 서버연결 시 images를 데이터로 변경해야함.

        $0.numberOfPages = images.count
        $0.currentPage = 0
        $0.pageIndicatorTintColor = UIColor.lightGray
        $0.currentPageIndicatorTintColor = UIColor.black
        $0.backgroundStyle = .prominent
        return $0
    }(UIPageControl())

    private lazy var descriptionView: UIScrollView = {
        $0.contentSize = CGSize(
            width: screenWidth,
            height: screenWidth / 5 * 2
        )
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .lightGray
        return $0
    }(UIScrollView())

    let descriptionLBL: UILabel = {
        $0.backgroundColor = .clear
        $0.text = "힘차게 싹이 보는 원대하고, 청춘의 모래뿐일 약동하다. 인생에 공자는 길을 운다. 구하기 불어 심장은 쓸쓸한 그것을 있으랴? 가치를 별과 인류의 때까지 그들을 찾아 목숨을 이상을 청춘에서만 철환하였는가? 밥을 속에서 만물은 새가 따뜻한 온갖 것이다. 구하지 예가 할지니, 칼이다. 갑 원대하고, 이것을 구하지 것이다. 광야에서 석가는 구할 곧 그러므로 위하여 황금시대다. 없으면, 남는 하였으며, 있는 힘차게 위하여서. 풍부하게 이것을 노년에게서 우리의 같이, 쓸쓸하랴? 사랑의 얼마나 곳으로 과실이 있는 날카로우나 쓸쓸한 황금시대다."
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let sharingButton: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("시공 상황 공유하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        return $0
    }(UIButton())

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
        sharingItems.append(self.descriptionLBL.text!)

        scrollView.delegate = self
        pageControl.addTarget(self, action: #selector(pageDidChange), for: .valueChanged)
        sharingButton.addTarget(self, action: #selector(tapShareButton), for: .touchUpInside)
    }

    private func layout() {

        configuratingScrollView()

        view.addSubview(descriptionView)
        descriptionView.addSubview(descriptionLBL)
        view.addSubview(sharingButton)

        descriptionView.anchor(
            top: pageControl.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16,
            height: screenWidth / 5 * 2
        )

        descriptionLBL.anchor(
            top: descriptionView.topAnchor,
            left: descriptionView.safeAreaLayoutGuide.leftAnchor,
            bottom: descriptionView.bottomAnchor,
            right: descriptionView.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )

        sharingButton.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func setNavigationBar() {
        navigationController?.navigationBar.topItem?.title = naviTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tapEditButton)
        )
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / screenWidth)
    }

    @objc func pageDidChange(sender: UIPageControl){
        let offsetX = screenWidth * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    // TODO: - 수정화면 생성되면 수정예정.

    @objc func tapEditButton() {
        let editViewController = ViewController()
        navigationController?.pushViewController(editViewController, animated: true)
    }

    @objc func tapShareButton() {
        let vc = UIActivityViewController(activityItems: self.sharingItems, applicationActivities: [])
        self.present(vc, animated: true)
    }
}

// MARK: - configuratingScrollView

extension DetailViewController {
    private func configuratingScrollView() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)

        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: screenWidth / 4 * 3
        )

        pageControl.anchor(
            top: scrollView.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16
        )

        for num in 0..<images.count {
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: URL(string: self.images[num].photoPath)!)
                
                DispatchQueue.main.async {
                    self.addImageView(img: imageData!, position: CGFloat(num))
                    
                    guard let image = UIImage(data: imageData!) else { return }
                    self.sharingItems.append(image)
                }
            }
        }
    }

    private func addImageView(img: Data, position: CGFloat) {
        let constructionImage = UIImageView()
        constructionImage.image = UIImage(data: img)

        let changedView = ModalTapRecognizer(target: self, action: #selector(changedView))
        changedView.image = constructionImage.image
        constructionImage.addGestureRecognizer(changedView)
        constructionImage.isUserInteractionEnabled = true

        scrollView.addSubview(constructionImage)

        constructionImage.frame = CGRect(
            x: screenWidth * position,
            y: 0,
            width: screenWidth,
            height: screenWidth / 4 * 3
        )
    }

    @objc func changedView(_ sender: ModalTapRecognizer) {
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.detailImage.image = sender.image
        
        let navigationController = UINavigationController(rootViewController: imageDetailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: false)
    }
}

class ModalTapRecognizer: UITapGestureRecognizer {
    var image: UIImage?
}
