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
    
    //Esta sería la URL de la llamada a Login, en caso de error lo capturamos.
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> Void ) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = "\(email):\(password)"
        let loginData: Data = loginString.data(using: .utf8)!
        let base64 = loginData.base64EncodedString() //Debemos de convertir las contantes de antes en base 64 que es el modelo de como está la api.
        var urlRequest =  URLRequest(url:url)
        urlRequest.httpMethod = "POST" //Tenemos que espeficiarlo ya que viene predeterminado como GET
        urlRequest.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization") //Este será el tipo de autorización que tiene la api para comprobar tus credenciales y darte acceso
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(nil,error)
                return //Compromaos que el error es NULO si si no es así algo habría ido mal y devolveriamos un nulo y el error.
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return //Aquí nos aseguramos que el data viene, en caso de que no venga mostramos un Nil con el error noData
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                return // Indicamos que si el statusCode no es 200 capturamos el error indicando que no es correcto
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil,NetworkError.decodingFailed)
                return //Si llegamos a este guardlet, indica que todo lo anterior se ha ido cumpliendo y ya tenemos nuestro token
            }
            
            completion(token, nil)
        }
        
        task.resume() //Con esto indicamos la llamada a la API
        
    }
    //Este sería la funcíon de llamada a la api para traer personajes
    func fetchHeroes(token: String?, completion: @escaping ([Heroe]?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/auth/heros/all")else{
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        var urlComponents = URLComponents() //Esto sería para hacer la llamada a la API del nombre de heroe
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization") //Excepto en el login que se hace con el Basic, en las demás llamadas se hacen con Bearer \(token)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let heroes = try? JSONDecoder().decode([Heroe].self, from: data) else {
                completion(nil, NetworkError.decodingFailed)
                return
            }
            //Si no encuentra ningún error
            completion(heroes, nil)
        }
        task.resume()
    }
        
}
