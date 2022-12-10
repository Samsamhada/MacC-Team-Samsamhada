//
//  PostingWritingView.swift
//  Samsam
//
//  Created by creohwan on 2022/10/19.
//

import UIKit

class PostingWritingView: UIViewController {

    // MARK: - Property
    var postID: Int?
    var sharingItems: [Any] = []
    
    var postCreation: Bool = true {
        didSet {
            if postCreation {
                textTitle.text = "작업내용을 작성해주세요"
                textViewPlaceHolder = "고객을 위해 쉽고 자세하게 설명해주세요."
                postBTN.isHidden = false
            } else {
                textTitle.text = "작업내용을 수정해주세요"
                textViewPlaceHolder = sharingItems[0] as! String
                textContent.textColor = .black
                modificationBTN.isHidden = false
            }
        }
    }
    
    private var post: Post? {
        didSet {
            photoImages?.forEach {
                uploadImage(fileName: "photo.jpeg", photo: $0.path!, postID: post!.postID)
            }
        }
    }
    private var photoCount: Int = 0 {
        didSet {
            if photoCount == photoImages!.count {
                DispatchQueue.main.sync {
                    self.dismiss(animated: true)
                }
            }
        }
    }

    var room: Room?
    var categoryID: Int = 0
    var photoImages: [CellItem]?
    private var roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    private var textViewPlaceHolder = "고객을 위해 쉽고 자세하게 설명해주세요."
    
    // MARK: - View

    private var textTitle: UILabel = {
        $0.text = "작업내용을 작성해주세요"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let exampleLabel: UILabel = {
        $0.text = """
                    예시)
                    - 거실 바닥 장판 철거, PE폼 깔기
                    - 강화마루 설치
                    - 특이사항 없음
                    - 작업인원 0명
                    """
        $0.numberOfLines = 0
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return $0
    }(UILabel())

    private lazy var textContent: UITextView = {
        let linestyle = NSMutableParagraphStyle()
        linestyle.lineSpacing = 4.0
        $0.typingAttributes = [.paragraphStyle: linestyle]
        $0.backgroundColor = .clear
        $0.text = textViewPlaceHolder
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textAlignment = .natural
        $0.textContainerInset = UIEdgeInsets(top: 17, left: 12, bottom: 17, right: 12)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.delegate = self
        return $0
    }(UITextView())

    private var shadowView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
//        $0.layer.shadowColor = UIColor.black.cgColor
//        $0.layer.shadowOpacity = 0.25
//        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
//        $0.layer.shadowRadius = 10
        return $0
    }(UIView())

    private let postBTN: UIButton = {
        $0.backgroundColor = .gray
        $0.setTitle("작성 완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.isHidden = true
        $0.addTarget(self, action: #selector(createPostBTN), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let modificationBTN: UIButton = {
        $0.backgroundColor = .gray
        $0.setTitle("수정 완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.isHidden = true
        $0.addTarget(self, action: #selector(modifyPostBTN), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        hidekeyboardWhenTappedAround()
        setupNotificationCenter()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = AppColor.backgroundGray
        setupNavigationTitle()
    }

    private func layout() {
        self.view.addSubview(textTitle)
        self.view.addSubview(exampleLabel)
        self.view.addSubview(shadowView)
        self.shadowView.addSubview(textContent)
        self.view.addSubview(postBTN)
        self.view.addSubview(modificationBTN)
        

        textTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        exampleLabel.anchor(
            top: textTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16
        )
        
        shadowView.anchor(
            top: exampleLabel.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16,
            height: 240
        )

        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 240
        )

        postBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
        
        modificationBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )
    }

    private func setupNavigationTitle() {
        navigationItem.title = "시공 상황 작성"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func createPostBTN() {
        let postDTO: PostDTO = PostDTO(roomID: room?.roomID ?? 1, category: categoryID, type: 0, description: textContent.text!)
        createPost(PostDTO: postDTO)
    }
    
    @objc func modifyPostBTN() {
        let postDTO: PostDTO = PostDTO(description: textContent.text!)
        modifyPost(PostDTO: postDTO, postID: postID!)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.postBTN.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
                self.modificationBTN.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.postBTN.transform = .identity
            self.modificationBTN.transform = .identity
        })
    }
    
    private func createPost(PostDTO: PostDTO) {
        Task{
            do {
                let response = try await self.roomAPI.createPost(PostDTO: PostDTO)
                guard let data = response else {
                    return
                }
                self.post = data
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
    
    private func modifyPost(PostDTO: PostDTO, postID: Int) {
        Task{
            do {
                let response = try await self.roomAPI.modifyPost(PostDTO: PostDTO, postID: postID)
                guard let data = response else { return }
                let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: true)
            } catch NetworkError.serverError {
            } catch NetworkError.encodingError {
            } catch NetworkError.clientError(_) {
            }
        }
    }
    
    private func uploadImage(fileName: String, photo: Data, postID: Int) {
        let boundary = UUID().uuidString
        
        let session = URLSession.shared

        var urlRequest = URLRequest(url: URL(string: APIEnvironment.photosURL)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue(APIEnvironment.apiKey, forHTTPHeaderField: "API-Key")
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: photo/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(photo)
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"postID\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
        data.append(String(postID).data(using: .utf8)!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                self.photoCount += 1
            }
        }).resume()
    }
}

extension PostingWritingView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder && postCreation {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.text == textViewPlaceHolder) ||
            (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)  {
            postBTN.isEnabled = false
            postBTN.backgroundColor = .gray
            modificationBTN.isEnabled = false
            modificationBTN.backgroundColor = .gray
        } else {
            postBTN.isEnabled = true
            postBTN.backgroundColor = AppColor.giwazipBlue
            modificationBTN.isEnabled = true
            modificationBTN.backgroundColor = AppColor.giwazipBlue
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            if postCreation {
                textView.textColor = .lightGray
            }
        }
    }
}
