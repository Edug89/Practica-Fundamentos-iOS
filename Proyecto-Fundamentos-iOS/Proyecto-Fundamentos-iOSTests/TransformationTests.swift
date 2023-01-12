//
//  TransformationTests.swift
//  Proyecto-Fundamentos-iOSTests
//
//  Created by Eduardo Martinez Palomino on 12/1/23.
//

import XCTest

final class TransformationTests: XCTestCase {
    
    var transformation: Transformation!
    
    override func setUp() {
        super.setUp()
        
        transformation = Transformation(id: "22",
                                        name: "Super saiyan",
                                        photo: "https://www.keepcoding.io",
                                        description: "This is the real one!")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testTransformationId() {
        XCTAssertNotNil(transformation.id) //Aquí indicaamos que debe devolver un id
        XCTAssertEqual(transformation.id, "22") //Aquí indicamos que debe devolver id igual a 4
        XCTAssertNotEqual(transformation.id, "6") //Aquí indicamos que debe devolver diferente a 6
    }
    
    func testTransformationName() {
        XCTAssertNotNil(transformation.name)
        XCTAssertEqual(transformation.name, "Super saiyan")
        XCTAssertNotEqual(transformation.name, "Vegeta")
    }
    
    func testTransformationPhoto() {
        XCTAssertNotNil(transformation.photo)
        XCTAssertEqual(transformation.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(transformation.photo, "https://www.keepcoding.com")
    }
    
    func testTransformationDescription() {
        XCTAssertNotNil(transformation.description)
        XCTAssertEqual(transformation.description, "This is the real one!")
        XCTAssertNotEqual(transformation.description, "Goku bad!!")
        
    }
    
}
