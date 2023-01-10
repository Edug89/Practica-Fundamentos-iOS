//
//  DetailsViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 7/1/23.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var heroeImageView: UIImageView!
    @IBOutlet weak var heroeNameLabel: UILabel!
    @IBOutlet weak var heroeDescLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    var heroe: Heroe!
    var transformations: [Transformation] = [] //Me creo este array para guardar transformaciones.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transformationsButton.alpha = 0

        title = heroe.name
        
        heroeImageView.setImage(url: heroe.photo)
        heroeNameLabel.text = heroe.name
        heroeDescLabel.text = heroe.description
        
        let token = LocalDataLayer.shared.getToken() //Me traigo el token para la llamada.
        
        NetworkLayer
            .shared
            .fetchTransformations(token: token, heroeId: heroe.id) { [weak self] allTrans, error in guard let self = self else { return }
                
                if let allTrans = allTrans {
                    self.transformations = allTrans
                    
                    DispatchQueue.main.async {
                        self.transformationsButton.alpha = 1
                    }
                    
                } else {
                    print("Error fetching transformations: ", error?.localizedDescription ?? "")
                }
                
            }
    }

    
    @IBAction func transformationsButtonTapped(_ sender: UIButton) {
        print("Hola!!!")
    }
    
}
