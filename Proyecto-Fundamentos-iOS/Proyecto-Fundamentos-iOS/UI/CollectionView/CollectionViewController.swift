//
//  CollectionViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 26/12/22.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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

}
