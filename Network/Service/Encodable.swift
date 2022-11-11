//
//  Encodable.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
