//
//  PickerViewController.swift
//  f1_Kit
//
//  Created by Gin on 27/9/2023.
//

import UIKit

protocol PickerViewControllerDelegate {
    func selectedOption (rank: String, season: String)
}

class PickerViewController: UIViewController {
    
    var delegate: PickerViewControllerDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let ranks = ["Drivers", "Constructors"]
    let seasons = Array((2013...2023).reversed())
    var selectedRank = "Drivers"
    var selectedYear = "2023"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }

    @IBAction func cancelButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtontap(_ sender: UIBarButtonItem) {
        
        delegate?.selectedOption(rank: selectedRank, season: selectedYear)
        dismiss(animated: true)
    }
}

extension PickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return ranks.count
        }
        
        return seasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return ranks[row]
        }
        
        let seasonStrings = seasons.map { String($0) }
        return seasonStrings[row]
    }
    
    //Selected rank and year
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            selectedRank = ranks[row]
        } else {
            let seasonStrings = seasons.map { String($0) }
            selectedYear = seasonStrings[row]
        }
    }
}

extension PickerViewController: UIPickerViewDelegate {
    
}
