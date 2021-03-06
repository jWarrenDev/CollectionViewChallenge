//
//  CollectionViewController.swift
//  CollectionViewChallenge
//
//  Created by Jerrick Warren on 10/15/18.
//  Copyright © 2018 Erica Sadun. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let reuseIdentifier = "cell"
    var images: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
      
        // Load Images
        for i in 1...12 {
            guard let image = UIImage(named: "Image\(i)") else {return}
            images.append(image)
        }
        collectionView?.allowsMultipleSelection = true
    
        // paralell array [0...11]
    }
    
    // Set up layout
    let targetDimension: CGFloat = 320
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Unable to retrieve layout")
        }
        
        let insetAmount: CGFloat = 32
        
        layout.sectionInset = UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount)
        layout.minimumLineSpacing = .greatestFiniteMagnitude
        layout.scrollDirection = .horizontal
        
    }
    
    // Set up Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {fatalError("Cell is not Available")}
        cell.image.image = images[indexPath.row]
        cell.layer.borderWidth = 1.3
        cell.layer.borderColor = UIColor.yellow.cgColor
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Fetch image
        let image = images[indexPath.row]
        
        // Fetch largest dimension of the image, whether width or height
        let maxDimension = max(image.size.width, image.size.height)
        
        // Calculate how to scale that largest dimension into `targetDimension`
        let scale = targetDimension / maxDimension
        
        // Return scaled dimensions
        return CGSize(width: image.size.width * scale, height: image.size.height * scale)
    }
    
}
