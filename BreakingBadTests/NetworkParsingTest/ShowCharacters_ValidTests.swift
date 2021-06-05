//
//  ShowCharacters_ValidTests.swift
//  BreakingBadTests
//

import XCTest
@testable import BreakingBad

class ShowCharacters_ValidTests: XCTestCase {
    
    func testShowCharacterWithValidJSON() {
       
        guard let json = type(of: self).jsonObject(fromFileName: "character") else { return XCTFail() }
        
        guard let character = try? type(of: self).jsonDecoder.decode(Character.self, from: json) else {
            return XCTFail()
        }
        
        XCTAssertEqual(character.name, "Walter White")
        XCTAssertEqual(character.nickname, "Heisenberg")
        XCTAssertEqual(character.occupation.count, 2)
        XCTAssertEqual(character.status, "Deceased")
        XCTAssertEqual(character.appearance.count, 5)
        XCTAssertEqual(character.img, URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"))
    }

    func testInvalidJSON() {
        guard let json = type(of: self).jsonObject(fromFileName: "invalid") else { return XCTFail() }
        XCTAssertThrowsError(try type(of: self).jsonDecoder.decode(Character.self, from: json))
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()
    
    static let jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        return jsonEncoder
    }()
    
    static func jsonObject(fromFileName fileName: String) -> Data? {
        let bundle = Bundle(for: self)
        
        guard let jsonURL = bundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: jsonURL)
    }
}
