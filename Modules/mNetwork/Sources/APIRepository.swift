//
//  APIRepository.swift
//  mNetwork
//
//  Created by Mateus Sousa on 14/12/20.
//

import Foundation

public class APIRepository {
    
    public init() { }
    
    let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api"
    
    public func getAllEvents(completion: @escaping (Result<Data, Error>) -> Void) {
        let endPoint = "/events"
        if let url = URL(string: baseURL + endPoint) {
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }else {
            completion(.failure(APIRepositoryErrors.urlInvalid))
        }
    }
    
    public func getEvent(with id: Int, completion: (Result<Data, Error>) -> Void) {
        let endPoint = "/events/\(id)"
        if let url = URL(string: baseURL + endPoint) {
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }else {
            completion(.failure(APIRepositoryErrors.urlInvalid))
        }
    }
    
    public func checkinEvent(at id: Int, name: String, email: String, completion: @escaping (Error?) -> Void) {
        let endPoint = "/checkin"
        
        if let url = URL(string: baseURL + endPoint) {
            let params = ["eventId" : "\(id)", "name" : name, "email" : email]
            do {
                let paramsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                let urlRequest = NSMutableURLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = paramsData
                
                URLSession.shared.dataTask(with: urlRequest as URLRequest) { (_, response, error) in
                    if error != nil {
                        completion(error)
                    }else {
                        if let response = response as? HTTPURLResponse {
                            if response.statusCode == 201 {
                                completion(nil)
                            }else {
                                completion(APIRepositoryErrors.failureCheckin)
                            }
                        }else {
                            completion(APIRepositoryErrors.noResponseServer)
                        }
                    }
                }.resume()
            } catch {
                completion(APIRepositoryErrors.encodePostData)
            }
        }else {
            completion(APIRepositoryErrors.urlInvalid)
        }
    }
}
