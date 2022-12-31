//
//  NetworkLayer.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 31/12/22.
//

import Foundation

enum NetworkError: Error { //Enumeramos los posibles casos de Error que nos devuelva la API
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> Void ) {
        
    }
        
    
}
