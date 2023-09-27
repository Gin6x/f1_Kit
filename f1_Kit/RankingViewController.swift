//
//  ViewController.swift
//  f1_Kit
//
//  Created by Gin on 25/9/2023.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set BG color to Ferrari red
        let red: CGFloat = 255.0 / 255.0
        let green: CGFloat = 40.0 / 255.0
        let blue: CGFloat = 0.0 / 255.0
        self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        rankButton.layer.cornerRadius = 12
        rankButton.layer.masksToBounds = true
        yearButton.layer.cornerRadius = 12
        yearButton.layer.masksToBounds = true
        
        rankButton.addTarget(self, action: #selector(rankButtonTap), for: .touchUpInside)
        yearButton.addTarget(self, action: #selector(yearButtonTap), for: .touchUpInside)
    }
    
    @objc func rankButtonTap() {
        print("Rank button tapped")
    }
    
    @objc func yearButtonTap() {
        print("Year button tapped")
    }


}

