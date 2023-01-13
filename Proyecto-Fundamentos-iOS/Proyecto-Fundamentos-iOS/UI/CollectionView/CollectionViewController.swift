//
//  CollectionViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 26/12/22.
//

import UIKit

class CollectionViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroes: [Heroe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = "Heroes"
        heroes = LocalDataLayer.shared.getHeroes() //indicamos que se guarde en la array llamada heroes
        
        
        let xib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "customcCollectionCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcCollectionCell", for: indexPath) as! CollectionCell
        let heroe = heroes[indexPath.row]
        cell.iconImageView.setImage(url: heroe.photo)
        cell.titleLabel.text = heroe.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //Aqui indicamos el tamaño de las celdas.
        let itemsInRow: CGFloat = 2 // Número de celdas por filas
        let spacing: CGFloat = 12 // Este es el espacio que hay entre celda y celda de ancho.
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing // Aquí es el número de elementos -1
        let finalWidth = (collectionView.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: finalWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroe = heroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
        
    }

}
