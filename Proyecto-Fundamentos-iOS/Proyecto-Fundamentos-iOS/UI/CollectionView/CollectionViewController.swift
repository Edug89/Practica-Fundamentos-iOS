//
//  CollectionViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 26/12/22.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
            
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "customcCollectionCell")
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customRows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcCollectionCell", for: indexPath) as! CollectionCell
        let customItem = customRows[indexPath.row]
        cell.iconImageView.image = customItem.image
        cell.titleLabel.text = customItem.text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //Aqui indicamos el tamaño de las celdas.
        let itemsInRow: CGFloat = 2 // Número de celdas por filas
        let spacing: CGFloat = 12 // Este es el espacio que hay entre celda y celda de ancho.
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing // Aquí es el número de elementos -1
        let finalWidth = (collectionView.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: finalWidth, height: 120)
    }

}
