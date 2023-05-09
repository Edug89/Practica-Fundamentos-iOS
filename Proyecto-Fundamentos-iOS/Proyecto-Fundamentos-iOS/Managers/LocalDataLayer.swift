//
//  LocalDataLayer.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 31/12/22.
//

import Foundation

final class LocalDataLayer {
    private static let token = "token"
    private static let heroes = "heroes"
    
    static let shared = LocalDataLayer()
    
    func save(token: String) {
        UserDefaults.standard.set(token, forKey: Self.token) //Utilizamos esta func para guardar el token, este Self en mayúscula es lo mismo que poner el nombre de la Clase(LocalDataLayer)
    }
    
    func getToken() -> String {
        UserDefaults.standard.string(forKey: Self.token) ?? "" //Esta función es para coger el token
    }
    
    func isUserLogged() -> Bool {
        !getToken().isEmpty //Esto es para saber que el usuario está logueado: Si traes un token y no está vacío indica que el usuario esta logueado
    }
    
    func save(heroes: [Heroe]) {
        if let encodedHeroes = try? JSONEncoder().encode(heroes) {
            UserDefaults.standard.set(encodedHeroes, forKey: Self.heroes)
        }
    }
    
    func getHeroes() -> [Heroe] {
        if let savedHeroesData = UserDefaults.standard.object(forKey: Self.heroes) as? Data {
            do {
                let savedHeroes = try JSONDecoder().decode([Heroe].self, from: savedHeroesData)
                return savedHeroes
            } catch {
                print("Something went wrong !!!")
                return []
            }
            
        } else {
            return []
        }
    }
}
