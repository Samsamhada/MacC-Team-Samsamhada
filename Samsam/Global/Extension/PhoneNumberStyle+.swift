//
//  PhoneNumberStyle+.swift
//  Samsam
//
//  Created by 지준용 on 2022/11/07.
//

import UIKit

extension String {
    func phoneNumberStyle() -> String {
        if self.count > 7 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})",
                                                    options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: self,
                                                               range: NSRange(self.startIndex..., in: self),
                                                               withTemplate: "$1 - $2")
                return modString
            }
        }
        return self
    }
}

