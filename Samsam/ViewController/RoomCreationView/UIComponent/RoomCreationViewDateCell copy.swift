//
//  RoomCreationViewStartDateCell.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/08.
//

import UIKit

protocol RoomCreationViewDateSecondCellDelegate: AnyObject {
    func secondDateDidTap(date: Date)
}

class RoomCreationViewDateSecondCell: UITableViewCell {
    
    // MARK: - Property
    
    weak var secondDelegate: RoomCreationViewDateSecondCellDelegate?
    static let identifier = "roomCreationViewSecondDateCell"

    // MARK: - View
    
    var datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.preferredDatePickerStyle = .inline
        $0.tintColor = AppColor.campanulaBlue
        return $0
    }(UIDatePicker())
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        checkValueForDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)가 실행되지 않았습니다.")
    }
    
    // MARK: - Method
    
    private func layout() {
        self.addSubview(datePicker)
        
        datePicker.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
    
    private func checkValueForDate() {
        datePicker.addTarget(self, action: #selector(check), for: .valueChanged)
    }
    
    @objc private func check() {
        secondDelegate?.secondDateDidTap(date: datePicker.date)
    }
    
    func configure(date: Date?) {
        if let date = date {
            datePicker.setDate(date, animated: true)
        }
    }
}