//
//  hideKeyboard+.swift
//  Samsam
//
//  Created by 지준용 on 2022/10/25.
//

import UIKit


extension UIViewController {

    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func endEditingView() {
        view.endEditing(true)
    }
}
