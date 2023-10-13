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
    
    var localCircuitData: [CircuitResponses]?
    var circuitImageName: String?
    var apiSearchName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        guard let searchName = apiSearchName, let circuitName = circuitImageName else { return }
        
        circuitImageView.image = UIImage(named: circuitName)
        
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
                }
            } catch {
                print("Failed to get circuit data")
            }
        }
        
        //state isLoaging
        //callApi
    }
}
