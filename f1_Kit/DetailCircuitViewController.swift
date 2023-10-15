//
//  DetailCircuitViewController.swift
//  f1_Kit
//
//  Created by Gin on 10/10/2023.
//

import UIKit

class DetailCircuitViewController: UIViewController {

    @IBOutlet weak var circuitImageView: UIImageView!
    @IBOutlet weak var circuitLabel: UILabel!
    @IBOutlet weak var raceDistanceLabel: UILabel!
    @IBOutlet weak var lapsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var localCircuitData: [CircuitResponses]?
    var circuitImageName: String?
    var apiSearchName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        getCircuit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingIndicator.startAnimating()
    }
    
    func getCircuit() {
        
        loadingIndicator.startAnimating()
        
        guard let searchName = apiSearchName, let circuitName = circuitImageName else { return }
        
        circuitImageView.image = UIImage(named: circuitName)
        
        if searchName == "jeddah" {
            
            circuitLabel.text = "Jeddah Corniche Circuit"
            raceDistanceLabel.text = "308.45 kms"
            lapsLabel.text = "50"
            timeLabel.text = "1:30.734"
            driverNameLabel.text = "Lewis Hamilton"
            yearLabel.text = "2021"
            loadingIndicator.isHidden = true
            
        } else if searchName == "miami" {
            
            circuitLabel.text = "Miami International Autodrome"
            raceDistanceLabel.text = "308.326 kms"
            lapsLabel.text = "57"
            timeLabel.text = "1:29.708"
            driverNameLabel.text = "Max Verstappen"
            yearLabel.text = "2023"
            loadingIndicator.isHidden = true
        } else if searchName == "las vegas" {
            
            circuitLabel.text = "Las Vegas"
            raceDistanceLabel.text = "310.05 kms"
            lapsLabel.text = "50"
            timeLabel.text = "N/A"
            driverNameLabel.text = "N/A"
            yearLabel.text = "N/A"
            loadingIndicator.isHidden = true
        } else  if searchName == "yas marina" {
            
            circuitLabel.text = "Yas Marina Circuit"
            raceDistanceLabel.text = "306.183 kms"
            lapsLabel.text = "58"
            timeLabel.text = "1:26.103"
            driverNameLabel.text = "Max Verstappen"
            yearLabel.text = "2021"
            loadingIndicator.isHidden = true
        } else {
            Task.init {
                do {
                    let circuitDatas = try await RapidApiServices.shared.getCircuitData(circuit: searchName)
                    print("\(circuitDatas)")
                    for circuitData in circuitDatas {
                        circuitLabel.text = circuitData.name
                        raceDistanceLabel.text = circuitData.race_distance
                        lapsLabel.text = String(circuitData.laps)
                        timeLabel.text = circuitData.lap_record.time
                        driverNameLabel.text = circuitData.lap_record.driver
                        yearLabel.text = circuitData.lap_record.year
                        loadingIndicator.stopAnimating()
                        loadingIndicator.hidesWhenStopped = true
                    }
                } catch {
                    loadingIndicator.stopAnimating()
                    loadingIndicator.hidesWhenStopped = true
                    print("Failed to get circuit data")
                }
            }
        }
    }
}
