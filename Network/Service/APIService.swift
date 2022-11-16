//
//  APIService.swift
//  Samsam
//
//  Created by creohwan on 2022/11/10.
//


import Foundation

final class APIService: Requestable {
    
    var requestTimeOut: Float = 30

    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T? {
        let (data, httpResponse) = try await requestDataToURL(request)
        
        switch httpResponse.statusCode {
        case (200..<300):
            let decoder = JSONDecoder()
            let baseModelData: T? = try decoder.decode(T.self, from: data)
            return baseModelData
        case (300..<500):
            throw NetworkError.clientError(message: httpResponse.statusCode.description)
        default:
            throw NetworkError.serverError
        }
    }
}

extension APIService {
    typealias URLResponse = (Data, HTTPURLResponse)
    
    private func requestDataToURL(_ request: NetworkRequest) async throws -> URLResponse {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        guard let encodedURL = request.URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURL) else {
            throw NetworkError.encodingError
        }
        
        let (data, response) = try await URLSession.shared.data(for: request.buildURLRequest(with: url))
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.serverError }
        
        return (data, httpResponse)
    }
}

