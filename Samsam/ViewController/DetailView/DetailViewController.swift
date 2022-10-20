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
    var images = ["Test01","Test02","Test03","Test04"]
    
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
    
    private let descriptionLBL: UILabel = {
        $0.backgroundColor = .clear
        $0.text = "디너 미뉴 에디 디너 미뉴 에디 fe디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디fe너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴ef 에디 디너 미뉴 에디 ef디너 미뉴 에fef디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 디너 미뉴 에디 "
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let sharingButton: UIButton = {
        $0.backgroundColor = .lightGray
        $0.setTitle("시공 상황 공유하기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
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
        
        scrollView.delegate = self
        pageControl.addTarget(self, action: #selector(pageDidChange(sender: )), for: .valueChanged)
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
    
    @objc private func pageDidChange(sender: UIPageControl){
        let offsetX = screenWidth * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    // TODO: - 수정화면 생성되면 수정예정.
    
    @objc func tapEditButton() {
        let editViewController = ViewController()
        navigationController?.pushViewController(editViewController, animated: true)
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
            addImageView(img: images[num], position: CGFloat(num))
        }
    }
    
    private func addImageView(img: String, position: CGFloat) {
        let constructionImage = UIImageView()
        constructionImage.image = UIImage(named: img)
        
        scrollView.addSubview(constructionImage)
        
        constructionImage.frame = CGRect(
            x: screenWidth * position,
            y: 0,
            width: screenWidth,
            height: screenWidth / 4 * 3
        )
    }
}
