//
//  RoomCategoryViewController.swift
//  Samsam
//
//  Created by creohwan on 2022/10/20.
//

import UIKit

class RoomCategoryViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()


    }
    
    // MARK: - Method
    
    private func attribute() {
        setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        let appearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "방 생성"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}


