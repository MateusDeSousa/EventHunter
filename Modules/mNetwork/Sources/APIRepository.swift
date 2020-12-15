//
//  APIRepository.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

class APIRepository {
    
    let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api"
    
    func getAllEvents(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        let endPoint = "/events"
        if let url = URL(string: baseURL + endPoint) {
            do {
                let data = try Data(contentsOf: url)
                let listEvents = try JSONDecoder().decode([EventModel].self, from: data)
                completion(.success(listEvents))
            } catch {
                completion(.failure(error))
            }
        }else {
            let error = NSError()
            completion(.failure(error))
        }
    }
    
    func getEvent(with id: Int, completion: (Result<EventModel, Error>) -> Void) {
        let endPoint = "/events/\(id)"
        if let url = URL(string: baseURL + endPoint) {
            do {
                let data = try Data(contentsOf: url)
                let listEvents = try JSONDecoder().decode(EventModel.self, from: data)
                completion(.success(listEvents))
            } catch {
                completion(.failure(error))
            }
        }else {
            let error = NSError()
            completion(.failure(error))
        }
    }
}
