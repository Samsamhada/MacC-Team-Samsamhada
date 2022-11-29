//
//  PostingWritingView.swift
//  Samsam
//
//  Created by creohwan on 2022/10/19.
//

import UIKit

class PostingWritingView: UIViewController {

    // MARK: - Property

    var room: Room?
    var roomAPI: RoomAPI = RoomAPI(apiService: APIService())
    var post: Post? {
        didSet {
            photoImages?.forEach {
                uploadImage(fileName: "photo.jpeg", photo: $0.path!, postID: post!.postID)
            }
        }
    }
    var photo: Photo?
    var categoryID: Int = 0
    var photoImages: [CellItem]?
    private let textViewPlaceHolder = "텍스트를 입력하세요"

    let uiImage = UIImage(named: "TestImage")
    
    // MARK: - View

    private var textTitle: UILabel = {
        $0.text = "시공 사진에 관하여 부가 설명을 써주세요"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
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
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowRadius = 10
        return $0
    }(UIView())

    private let finalBTN: UIButton = {
        $0.backgroundColor = AppColor.campanulaBlue
        $0.setTitle("작성 완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 16
        $0.addTarget(self, action: #selector(tapNextBTN), for: .touchUpInside)
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
        view.backgroundColor = .white
        setupNavigationTitle()
    }

    private func layout() {
        self.view.addSubview(textTitle)
        self.view.addSubview(shadowView)
        self.shadowView.addSubview(textContent)
        self.view.addSubview(finalBTN)

        textTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            height: 20
        )

        textContent.anchor(
            left: shadowView.leftAnchor,
            right: shadowView.rightAnchor,
            height: 280
        )

        finalBTN.anchor(
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 50
        )

        shadowView.anchor(
            top: textTitle.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16,
            height: 280
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

    @objc func tapNextBTN() {
        let postDTO: PostDTO = PostDTO(roomID: room?.roomID ?? 1, category: categoryID, type: 0, description: textContent.text!)
        createPost(PostDTO: postDTO)

        self.dismiss(animated: true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.finalBTN.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 25)
            })
        }
    }

    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.finalBTN.transform = .identity
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
    
    func uploadImage(fileName: String, photo: Data, postID: Int) {
        let boundary = UUID().uuidString
        
        let session = URLSession.shared

        var urlRequest = URLRequest(url: URL(string: APIEnvironment.photosURL)!)
        urlRequest.httpMethod = "POST"
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
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .fragmentsAllowed)
                if let json = jsonData as? [String: Any] {
                }
            }
        }).resume()
        
    }
}

extension PostingWritingView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
}
