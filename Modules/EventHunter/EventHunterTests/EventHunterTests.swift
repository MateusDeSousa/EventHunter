//
//  EventHunterTests.swift
//  EventHunterTests
//
//  Created by Mateus Sousa on 21/12/20.
//

import XCTest
import mNetwork
@testable import EventHunter


class EventHunterTests: XCTestCase {
    
    let api = APIRepository()
    
    func testDecodableListEventModel() throws {
        let expectation = XCTestExpectation(description: "Decodable events")
        
        api.getAllEvents { (result) in
            switch result {
            case .success(let data):
                do {
                    let eventList = try JSONDecoder().decode([EventModel].self, from: data)
                    XCTAssertTrue(eventList.count > 0)
                } catch {
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        //60 is the default timeout for a URLRequest
        wait(for: [expectation], timeout: 60)
    }
    
    func testDecodableEventModel() throws {
        let expectation = XCTestExpectation(description: "Decodable only one event")
        
        api.getEvent(with: 1) { (result) in
            switch result {
            case .success(let data):
                do {
                    let eventList = try JSONDecoder().decode(EventModel.self, from: data)
                    XCTAssertTrue(eventList.date.format("dd/MM/yyyy") == "20/08/2018" )
                } catch {
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        //60 is the default timeout for a URLRequest
        wait(for: [expectation], timeout: 60)
    }
}
