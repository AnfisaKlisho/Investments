//
//  SessionError.swift
//  Investments
//
//  Created by Anfisa Klisho on 03.03.2021.
//

import Foundation

enum SessionError: Error{
    case invalidURL, decodingError(Error), serverError(_ statusCode: Int), other(Error), dataError
    
    var localizedDescription: String{
        switch self {
        case .invalidURL:
            return "Invalid URL-address"
        case let .decodingError(error):
            return error.localizedDescription
        case let .serverError(statusCode):
            return "Unable to connect with server (\(statusCode))"
        case .dataError:
            return "Invalid data"
        case let .other(error):
            return error.localizedDescription
        }
    }
}
