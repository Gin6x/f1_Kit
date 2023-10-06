//
//  CircuitsViewController.swift
//  f1_Kit
//
//  Created by Gin on 5/10/2023.
//

import UIKit

class CircuitCell: UICollectionViewCell {

    @IBOutlet weak var circuitImageView: UIImageView!
    @IBOutlet weak var circuitLabel: UILabel!
}

class CircuitsViewController: UIViewController {
   
    @IBOutlet weak var circuitsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circuitsCollectionView.delegate = self
        circuitsCollectionView.dataSource = self
        circuitsCollectionView.layer.cornerRadius = 10
        
    }
    
    func setupCell() {
        let itemSpace: Double = 4
        let columnCount: Double = 2
        let flowLayout = circuitsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((circuitsCollectionView.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
    }
}

extension CircuitsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let circuitCell = circuitsCollectionView.dequeueReusableCell(withReuseIdentifier: "circuitCell", for: indexPath) as! CircuitCell
        circuitCell.circuitImageView.image = UIImage(named: "bahrain.png")
        circuitCell.circuitLabel.text = "Bahrain"

        return circuitCell
    }
    
    
}
