//
//  TransformationsViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 11/1/23.
//

import UIKit

class TransformationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var transformations: [Transformation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Copiamos código de TableViewController
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Transformaciones"
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")

        //Copiamos código de TableViewController
    }
    
    //Delegate & DataSourcemethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// Pintamos la celda con los cambios que indiquemos
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell //Pasamos el nombre de la celda XIB y en el for indexPath
        
        let heroe = transformations[indexPath.row] //Sacamos el objeto del array
        
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
}
