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
    let circuits = Circuits()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circuitsCollectionView.delegate = self
        circuitsCollectionView.dataSource = self
        circuitsCollectionView.layer.cornerRadius = 10
        setupCell(collectionViewWidth: UIScreen.main.bounds.width - 32)
    }
    
    func setupCell(collectionViewWidth: CGFloat) {

        let flowLayout = circuitsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = 0
        let width = floor(collectionViewWidth / 2)
        flowLayout?.itemSize = CGSize(width: width, height: width)
    }
}

extension CircuitsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let circuitCell = circuitsCollectionView.dequeueReusableCell(withReuseIdentifier: "circuitCell", for: indexPath) as! CircuitCell
        let circuitImage = circuits.image[indexPath.item]
        circuitCell.circuitImageView.image = UIImage(named: circuitImage)
        let circuitLabel = circuits.displayCircuitName[indexPath.item]
        circuitCell.circuitLabel.text = circuitLabel.uppercased()
        return circuitCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        if let detailCircuitVC = storyboard?.instantiateViewController(withIdentifier: "detailCircuitVC") as? DetailCircuitViewController {
            self.navigationController?.pushViewController(detailCircuitVC, animated: true)
        }
        
        let selectedCircuitName = circuits.apiSearchName[indexPath.item]
        print(selectedCircuitName)
    }
    
    
}
