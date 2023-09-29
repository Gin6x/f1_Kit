//
//  PickerViewController.swift
//  f1_Kit
//
//  Created by Gin on 27/9/2023.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let ranks = ["Drivers", "Constructors"]
    let seasons = Array((2013...2023).reversed())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }

    @IBAction func cancelButtonTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtontap(_ sender: UIBarButtonItem) {
        print("Done button pressed")
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
            print(ranks[row])
        } else {
            let seasonStrings = seasons.map { String($0) }
            print(seasonStrings[row])
        }
//        print("Selected \(rank) ranking in \(year)")
    }
}

extension PickerViewController: UIPickerViewDelegate {
    
}
