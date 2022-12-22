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

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let customRows = [
        CustomItem(image: UIImage(systemName: "pencil.circle")!, text: "lunes"),
            CustomItem(image: UIImage(systemName: "trash.circle")!, text: "martes"),
            CustomItem(image: UIImage(systemName: "folder.circle")!, text: "miércoles"),
            CustomItem(image: UIImage(systemName: "paperplane.circle")!, text: "jueves"),
            CustomItem(image: UIImage(systemName: "doc.circle")!, text: "viernes"),
            CustomItem(image: UIImage(systemName: "terminal")!, text: "sábado"),
            CustomItem(image: UIImage(systemName: "book.closed")!, text: "domingo")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self //A nuestra clase le indicamos que herede de UITableViewDelegate.
        tableView.dataSource = self //A nuestra clase le indicamos que herede de UITableDataSource.
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") //Tipo de celda e indentificador único con el nombre de "cell"
        
        let xib = UINib(nibName: "TableCell", bundle: nil) //aquí instanciamos el archivo Xib de TableCell
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
    }
    
    //Delegate & DataSource methods, con estos métodos nosotros nos ocupamos de pintar lo que queremos en la aplicación.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell //Pasamos el nombre de la celda XIB y en el for indexPath
        let customItem = customRows[indexPath.row] //Sacamos el objeto del array
        cell.iconImageView.image = customItem.image //Aqui pintamos la imagenes de cada celda.
        cell.titleLabel.text = customItem.text //Aquí implementamos la label de cada celda.
        
        return cell
    }
}
