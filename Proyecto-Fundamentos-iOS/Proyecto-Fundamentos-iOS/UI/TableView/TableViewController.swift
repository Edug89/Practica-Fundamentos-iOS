//
//  TableViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 22/12/22.
//

import UIKit

struct CustomItem {
    let image: UIImage
    let text: String
}

class TableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: [Heroe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self //A nuestra clase le indicamos que herede de UITableViewDelegate.
        tableView.dataSource = self //A nuestra clase le indicamos que herede de UITableDataSource.
        
        navigationItem.title = "Heroes"
        
        let xib = UINib(nibName: "TableCell", bundle: nil) //aquí instanciamos el archivo Xib de TableCell
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        let token = LocalDataLayer.shared.getToken() //Nos traemos al token
        
        NetworkLayer.shared.fetchHeroes(token: token) { [weak self] allHeroes, error in //LLamamos a la API
            guard let self = self else { return } // Desempacamos de forma segura
            
            if let allHeroes = allHeroes { //Y con esos personajes que nos devuelve la api (allHeroes)                                  refrescamos la tableview
                self.heroes = allHeroes
                LocalDataLayer.shared.save(heroes: allHeroes) //Una vez venimos de la llamada de la API guardamos aquí los Heroes
                
                NotificationCenter.default.post(Notification(name: Notification.Name("fecthHeroes")))
                //Enviamos la notificacion
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Error fetching heroes: ", error?.localizedDescription ?? "")
            }
        }
        
    }
    
    //Delegate & DataSource methods, con estos métodos nosotros nos ocupamos de pintar lo que queremos en la aplicación.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// Pintamos la celda con los cambios que indiquemos
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell //Pasamos el nombre de la celda XIB y en el for indexPath
        
        let heroe = heroes[indexPath.row] //Sacamos el objeto del array
        
        cell.iconImageView.setImage(url: heroe.photo) //Aqui pintamos la imagenes de cada celda.
        cell.titleLabel.text = heroe.name //Aquí implementamos la label de cada celda.
        cell.descLabel.text = heroe.description //Aquí implemaentamos la descripción del heroe
        cell.accessoryType = .disclosureIndicator // indica el icono de la flecha en cada celda
        cell.selectionStyle = .none // la celda no sale ningún seleccionado cuando pinchas para navegar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //Este método es para darle altura a las celdas
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //Con esta función hacemos la navegación de la tableView hacia detailView, confi dicha navegación
        let heroe = heroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe //Con esto inyectamos el heroe antes de que cargue la vista en la siguiente línea.
        navigationController?.pushViewController(detailsView, animated: true)
    }
}

extension UIImageView {
    func setImage(url: String){
        guard let url = URL(string: url) else { return }
        
        downloadImage(url: url) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
    }
    
    private func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image) //En caso de que no sea nulo devolveremos la imagen
        }.resume() //Esto es lo mismo que si hacemos una constante task = URL Session y luego abajo ahcemos la llamada con task.resume()
    }
}
