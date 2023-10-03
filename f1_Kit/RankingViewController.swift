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
        
        
        rankButton.layer.cornerRadius = 12
        rankButton.layer.masksToBounds = true
        yearButton.layer.cornerRadius = 12
        yearButton.layer.masksToBounds = true
        
    }
    
//    @IBAction func rankButtonTap(_ sender: UIButton) {
//        performSegue(withIdentifier: "showPickerVC", sender: nil)
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPickerVC" {
            if let pickerVC = segue.destination as? PickerViewController {
                pickerVC.delegate = self
            }
        }
    }
    
    @IBAction func yearButtonTap(_ sender: UIButton) {
        performSegue(withIdentifier: "showPickerVC", sender: nil)
    }
    
    
}

extension RankingViewController: PickerViewControllerDelegate {
    
    func selectedOption(rank: String, season: String) {
        
        rankButton.setTitle(rank, for: .normal)
        yearButton.setTitle(season, for: .normal)
        print("Checking \(rank) ranking in \(season)")
        
        
    }
    
    
}

