//
//  HeroeTests.swift
//  Proyecto-Fundamentos-iOSTests
//
//  Created by Eduardo Martinez Palomino on 12/1/23.
//

import XCTest
@testable import Proyecto_Fundamentos_iOS //Con esto importamos el proyecto completo

final class HeroeTests: XCTestCase {
    
    var heroe: Heroe!

    override func setUp() { //Metemos los inicializadores de la clase padre
        super.setUp()
        
        heroe = Heroe(id: "4",
                      name: "Goku",
                      photo: "https://www.keepcoding.io",
                      description: "Goku the best!!",
                      favorite: true)
        
    }

    override func tearDown() {
        heroe = nil
        super.tearDown()
    }
    
    //Indico la traducción de los primeros XCTAAsser los otros son entendibles
    func testHeroeId() {
        XCTAssertNotNil(heroe.id) //Aquí indicaamos que debe devolver un id
        XCTAssertEqual(heroe.id, "4") //Aquí indicamos que debe devolver id igual a 4
        XCTAssertNotEqual(heroe.id, "6") //Aquí indicamos que debe devolver diferente a 6
    }
    
    func testHeroeName() {
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Goku")
        XCTAssertNotEqual(heroe.name, "Vegeta")
    }
    
    func testHeroePhoto() {
        XCTAssertNotNil(heroe.photo)
        XCTAssertEqual(heroe.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(heroe.photo, "https://www.keepcoding.com")
    }
    
    func testHeroeDescription() {
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Goku the best!!")
        XCTAssertNotEqual(heroe.description, "Goku bad!!")
    }
    
    func testHeroeFavorite() {
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, true)
       
    }

}
