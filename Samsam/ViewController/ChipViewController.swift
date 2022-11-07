//
//  ChipViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/11/07.
//

import UIKit

class ChipViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Property
    
    var roomID: Int?
    var chips: [UIButton] = []
    
    // MARK: - View
    
    private var chipScrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    private var chipContentView: UIStackView = {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private var textLabel: UILabel = {
        $0.text = "aasㅁㄴdfsㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇas"
        return $0
    }(UILabel())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataManager.loadOneRoomData(roomID: roomID!)
        coreDataManager.loadPostingData(roomID: roomID!)
        coreDataManager.loadWorkingStatusData(roomID: roomID!)
        setChip()
    }
    
    // MARK: - Method
    
    private func layout() {
        view.addSubview(chipScrollView)
        chipScrollView.addSubview(chipContentView)
        chipContentView.addArrangedSubview(textLabel)
        
        chipScrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            height: 60
        )
        
        chipContentView.anchor(
            top: chipScrollView.contentLayoutGuide.topAnchor,
            left: chipScrollView.contentLayoutGuide.leftAnchor,
            bottom: chipScrollView.contentLayoutGuide.bottomAnchor,
            right: chipScrollView.contentLayoutGuide.rightAnchor,
            height: 60
        )

        
    }
    
    private func setChip() {
        chips.append(makeButton(title: "  전체  "))
        
        coreDataManager.workingStatuses.forEach {
            chips.append(makeButton(title: "  "+Category(rawValue: Int($0.categoryID))!.categoryName()+"  "))
        }
        
        chips.forEach {
            chipContentView.addArrangedSubview($0)
        }
    }
    
    private func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(AppColor.campanulaBlue, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = AppColor.campanulaBlue?.cgColor
        button.layer.cornerRadius = 16
        return button
    }
}
