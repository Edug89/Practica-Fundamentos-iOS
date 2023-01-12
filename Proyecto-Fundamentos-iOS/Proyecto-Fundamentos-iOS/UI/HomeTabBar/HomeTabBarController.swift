//
//  HomeTabBarController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 23/12/22.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout() //para setear colores
        setupTabs() //para setear el controlador en este caso el TableViewController
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchHeroes),
                                               name: Notification.Name("fetchHeroes"),
                                               object: nil)
    }
    
    @objc func fetchHeroes() {
        print("Looking for new heroes from HomeTabBarController")
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTabs() {
        let navigationController = UINavigationController(rootViewController: TableViewController())
        //Instanciamos la clase, y le indicamos que cargue el TableViewController con navigation controller para una vez pulsando acceder a la siguiente pantalla.
        let tabImage = UIImage(systemName: "text.justify")!
        navigationController.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        
       
        let navigationController2 = UINavigationController(rootViewController: CollectionViewController())
        let tabImg = UIImage(systemName: "square.grid.3x3.topleft.filled")!
        navigationController2.tabBarItem = UITabBarItem(title: "CollectionView", image: tabImg, tag: 1)
        
        viewControllers = [navigationController, navigationController2]
         
    }
    
    private func setupLayout() {
        tabBar.backgroundColor = .systemBackground // le indicamos el color
    }
    
}
