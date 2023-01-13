//
//  BaseViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 13/1/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logout),
                                               name: Notification.Name("logout"),
                                               object: nil)
    }
    
    @objc func logout() {
        //Implementas la lógica que necesites
    }
    
    //Crearimos este archivo para utilizarlo de modo que los demás hereden de aquí, y utilizarlo como intermediario.(Además evitar duplicar métodos, lo aplicas aquí y de este heredas a donde te haga falta)
}
