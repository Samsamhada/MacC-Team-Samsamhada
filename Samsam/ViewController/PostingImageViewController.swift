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
    private var copyPhotoImages: [cellItem]?
    private var changeNUM: Int?
    private var plusBool: Bool = true
    
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
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
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
    
    @objc func tapNextBTN() {
        let postingWritingView = PostingWritingView()
        postingWritingView.roomID = roomID
        postingWritingView.categoryID = categoryID
        
        if numberOfItem == 0 {
            showToast()
        } else if numberOfItem > 3 {
            postingWritingView.photoImages = photoImages
            navigationController?.pushViewController(postingWritingView, animated: true)
        } else {
            copyPhotoImages = photoImages
            copyPhotoImages?.remove(at: 0)
            postingWritingView.photoImages = copyPhotoImages
            navigationController?.pushViewController(postingWritingView, animated: true)
        }
    }
    
    // 이미지를 하나도 선택하지 않고 다음 뷰를 넘어갈 때, 이를 방지하기 위한 함수
    private func showToast() {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.text = "사진을 하나 이상 선택해주세요!"
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.alpha = 0
        self.view.addSubview(label)
        
        label.anchor(
            bottom: nextBTN.topAnchor,
            paddingBottom: 30,
            width: 240,
            height: 30
        )
        label.centerX(inView: self.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            label.alpha = 0.8
        }, completion: { isCompleted in
            UIView.animate(withDuration: 2.0, animations: {
                label.alpha = 0
            }, completion: { isCompleted in
                label.removeFromSuperview()
            })
        })
    }
    
    // 사진이 불러와지지 않을 때, 알람을 주기 위한 함수
    private func makeErrorAlert(tittle: String, message: String? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
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
    
        if plusBool == true {
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
                plusBool = false
            }
        } else {
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                        DispatchQueue.main.async {
                            self?.photoImages[self!.changeNUM!].image = image as! UIImage
                            self?.imageCellView.reloadData()
                        }
                    }
                }
            }
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
        setPhoto(indexPath: indexPath.row)
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

