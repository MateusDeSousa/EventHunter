//
//  EventHunterUITests.swift
//  EventHunterUITests
//
//  Created by Mateus Sousa on 17/12/20.
//

import XCTest


class EventHunterUITests: XCTestCase {
    
    func testOpenDetailsEvent() {
        let app = XCUIApplication()
        app.activate()
        app.tables.firstMatch.cells.firstMatch.tap()
            
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertEqual(app.tables.cells.count, 1)
        app.terminate()
    }
    
    func testOpenCheckinScreen() {
        let app = XCUIApplication()
        app.activate()
        app.tables.firstMatch.cells.firstMatch.tap()
        
        app.buttons["Fazer check-in"].tap()
        
        XCTAssertEqual(app.textFields.count, 2)
        app.terminate()
    }
    
    func testOpenMapEvent() {
        let app = XCUIApplication()
        app.activate()
        app.tables.firstMatch.cells.firstMatch.tap()
        
        app.buttons["Ver no mapa"].tap()
        
        XCTAssertEqual(app.maps.count, 1)
        app.terminate()
    }
}
