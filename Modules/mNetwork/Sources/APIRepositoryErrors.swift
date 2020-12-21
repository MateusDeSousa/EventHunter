//
//  APIRepositoryErrors.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

enum APIRepositoryErrors: Error {
    case urlInvalid
    case noResponseServer
    case failureCheckin
    case encodePostData
}

extension APIRepositoryErrors: LocalizedError {
    var failureReason: String? {
        switch self {
        case .urlInvalid:
            return "Invalid server URL"
        case .noResponseServer:
            return "No response from the server"
        case .failureCheckin:
            return "Error in API"
        case .encodePostData:
            return "Error when turning dictionary to Data"
        }
    }
}
