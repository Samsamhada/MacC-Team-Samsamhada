//
//  PostingImageViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/18.
//

import UIKit
import PhotosUI

struct cellItem {
    var image: UIImage?
    var path: Data?
}

class PostingImageViewController: UIViewController {
    
    // MARK: - Property
    
    var roomID: Int?
    var categoryID: Int?
    var numberOfItem = 0
    var exampleNUM = 0
    
    private var photoImages: [cellItem] = [cellItem(image: UIImage(named: "CameraBTN"))]

    
    // MARK: - View
    
    private var titleText: UILabel = {
        $0.text = "시공한 사진을 추가해주세요.\n(최대 4장까지 가능합니다)."
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var exampleImage: UIImageView = {
        $0.image = UIImage(named: "Test04")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let imageCellView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let nextBTN: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
//        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
        PHPhotoLibrary.requestAuthorization { (state) in }
    }
    
    // MARK: - Method
    
    private func attribute() {
        self.view.backgroundColor = .white
        setNavigationTitle()
        
        imageCellView.delegate = self
        imageCellView.dataSource = self
        imageCellView.allowsMultipleSelection = true
        
        imageCellView.register(PostingImageCell.self, forCellWithReuseIdentifier: PostingImageCell.identifier)
        imageCellView.backgroundColor = .white
    }
    
    private func layout() {
        self.view.addSubview(titleText)
        self.view.addSubview(imageCellView)
        self.view.addSubview(nextBTN)
        
        titleText.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 12,
            paddingLeft: 50,
            paddingRight: 50,
            height: 50
        )
        
        imageCellView.anchor(
            top: titleText.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: nextBTN.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
        nextBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "시공 상황 작성"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
//    @objc func tapNextBTN() {
//        let postingWritingView = PostingWritingView()
//        postingWritingView.roomID = roomID
//        postingWritingView.categoryID = categoryID
//        if numberOfItem > 3 {
//            postingWritingView.imgItems = imgItems
//        } else {
//            copyImgItems = imgItems
//            copyImgItems?.remove(at: 0)
//            postingWritingView.imgItems = copyImgItems
//        }
//        navigationController?.pushViewController(postingWritingView, animated: true)
//    }

    @objc func setPhoto() {
        var configure = PHPickerConfiguration()
        configure.selectionLimit = 4 - numberOfItem
        if configure.selectionLimit == 0 {
            configure.selectionLimit = 1
        }
        configure.selection = .ordered
        configure.filter = .images
        let picker = PHPickerViewController(configuration: configure)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}


extension PostingImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        for result in results {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                    DispatchQueue.main.async {
                        self?.photoImages.append(cellItem(image: image as! UIImage))
                        self?.numberOfItem = self!.numberOfItem + 1
                        self?.imageCellView.reloadData()
                    }
                }
            }
        }
        if results.count + photoImages.count == 5 {
            photoImages.remove(at: 0)
        }
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension PostingImageViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingImageCell.identifier, for: indexPath) as! PostingImageCell
        
        cell.preview.image = photoImages[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setPhoto()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth =  310
        let cellHeight = 235
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 16, right: 8)
    }
}

