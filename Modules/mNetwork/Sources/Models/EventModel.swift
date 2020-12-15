//
//  EventModel.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

public struct EventModel: Decodable {
    public let date: Int
    public let description: String
    public let image: String
    public let longitude: Double
    public let latitude: Double
    public let price: Double
    public let title: String
    public let id: String
}
