//
//  PostingImageViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/18.
//
import UIKit
import PhotosUI

struct CellItem {
    var image: UIImage?
    var path: Data?
}

class PostingImageViewController: UIViewController {

    // MARK: - Property

    var roomID: Int?
    var categoryID: Int?
    var room: Room?
    var status: [Status]?

    private var photoImages: [CellItem] = []
    private var changeNUM: Int = -1
    private var plusBool: Bool = true

    // MARK: - View

    private var titleText: UILabel = {
        $0.text = "시공한 사진을 추가해주세요\n(최대 4장까지 가능합니다)"
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

        imageCellView.register(PostingImageButtonCell.self, forCellWithReuseIdentifier: PostingImageButtonCell.identifier)
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

        if photoImages.count == 0 {
            makeAlert(title: "", message: "사진을 한 장 이상 선택해야 합니다")
        } else {
            postingWritingView.roomID = roomID
            postingWritingView.categoryID = categoryID
            postingWritingView.photoImages = photoImages
            navigationController?.pushViewController(postingWritingView, animated: true)
        }
    }

    func uploadCheckPermission(){
        switch PHPhotoLibrary.authorizationStatus() {
        case .denied:
            didMoveToSetting()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (state) in
                if state == .authorized {
                    DispatchQueue.main.async {
                        self.uploadPhoto()
                    }
                }
            })
        case .authorized:
            uploadPhoto()
        default:
            break
        }
    }

    private func makeAlert(title: String,
                           message: String? = nil,
                           okAction: ((UIAlertAction) -> Void)? = nil,
                           completion : (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    func makeRequestAlert(title: String,
                          message: String,
                          okTitle: String = "확인",
                          cancelTitle: String = "취소",
                          okAction: ((UIAlertAction) -> Void)?,
                          cancelAction: ((UIAlertAction) -> Void)? = nil,
                          completion : (() -> Void)? = nil) {

        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)

        let okAction = UIAlertAction(title: okTitle, style: .destructive, handler: okAction)
        alertViewController.addAction(okAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    private func didMoveToSetting() {
        let settingAction: ((UIAlertAction) -> ()) = { _ in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingURL)
        }
        if let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String {
            makeRequestAlert(title: "설정",
                             message: "\(appName)이 카메라에 접근이 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
                             okAction: settingAction,
                             completion: nil)
        } else if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
            makeRequestAlert(title: "설정",
                             message: "\(appName)이 카메라에 접근이 허용되어 있지 않습니다. 설정화면으로 가시겠습니까?",
                             okAction: settingAction,
                             completion: nil)
        }
    }

    private func makeActionSheet(indexPath: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: "사진 변경하기", style: .default, handler: { action in
            self.changePhoto(indexPath: indexPath)
        })
        let removeAction = UIAlertAction(title: "사진 삭제하기", style: .destructive, handler: { action in
            self.deletePhoto(indexPath: indexPath)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        var scale = 0.0
        var newHeight = 0.0
        if newWidth < image.size.width {
            scale = newWidth / image.size.width
            newHeight = image.size.height * scale
        } else {
            scale = 1.0
            newHeight = image.size.height
        }
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    @objc func uploadPhoto() {
        changeNUM = -1
        var configure = PHPickerConfiguration()
        configure.selectionLimit = 4 - photoImages.count
        configure.selection = .ordered
        configure.filter = .images
        let picker = PHPickerViewController(configuration: configure)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    @objc func changePhoto(indexPath: Int) {
        changeNUM = indexPath
        var configure = PHPickerConfiguration()
        configure.selectionLimit = 1
        configure.selection = .ordered
        configure.filter = .images
        let picker = PHPickerViewController(configuration: configure)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    @objc func deletePhoto(indexPath: Int) {
        photoImages.remove(at: indexPath)
        imageCellView.reloadData()
    }
}

extension PostingImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        for result in results.reversed() {
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        if self?.changeNUM == -1 {
                            self?.photoImages.insert(CellItem(image: image,
                                                              path: self!.resizeImage(image: image, newWidth: UIScreen.main.bounds.width).jpegData(compressionQuality: 1.0)), at: 0)
                        } else {
                            self?.photoImages[self!.changeNUM] = CellItem(image: image,
                                                                          path: self!.resizeImage(image: image, newWidth: UIScreen.main.bounds.width).jpegData(compressionQuality: 1.0))
                        }
                        self?.imageCellView.reloadData()
                    }
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.makeAlert(title: "",message: "사진을 불러올 수 없습니다")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension PostingImageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 && photoImages.count == 4 {
            return 0
        } else if section == 0 {
            return 1
        } else {
            return photoImages.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingImageButtonCell.identifier, for: indexPath) as! PostingImageButtonCell
            return buttonCell
        } else {
            let imagecell = collectionView.dequeueReusableCell(withReuseIdentifier: PostingImageCell.identifier, for: indexPath) as! PostingImageCell
            imagecell.preview.image = photoImages[indexPath.row].image
            return imagecell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            uploadCheckPermission()
        } else {
            makeActionSheet(indexPath: indexPath.row)
        }
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
