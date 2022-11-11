//
//  NetworkError.swift
//  Manito
//
//  Created by creohwan on 2022/11/10.
//


import Foundation

enum NetworkError: Error {
    case encodingError
    case clientError(message: String?)
    case serverError
}
