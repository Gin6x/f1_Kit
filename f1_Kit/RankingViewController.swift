//
//  ViewController.swift
//  f1_Kit
//
//  Created by Gin on 25/9/2023.
//

import UIKit

class RankingCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
}

class RankingViewController: UIViewController {
    
    @IBOutlet weak var rankButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var rankingTableView: UITableView!
    
    var responses: [Responses]?
    var imageCache = [URL: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        rankButton.layer.cornerRadius = 12
        rankButton.layer.masksToBounds = true
        yearButton.layer.cornerRadius = 12
        yearButton.layer.masksToBounds = true
        //tableView
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.layer.cornerRadius = 10
        
        apiCall(rank: "drivers", season: "2023")
    }
    
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
    
    func apiCall(rank: String, season: String) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api-formula-1.p.rapidapi.com/rankings/\(rank)?season=\(season)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        let headers = [
            "X-RapidAPI-Key": "6ecdce6c5amshe3e328919c857d9p15ec4cjsnedfd8e331d72",
            "X-RapidAPI-Host": "api-formula-1.p.rapidapi.com"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        //Create a URLSession and give different response
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let decoder = JSONDecoder()
            
            if let error = error {
                print("There is an error: \(error.localizedDescription), please check the sever")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            if let data = data, let rankingDatas = try? decoder.decode(Ranking.self, from: data) {
                self.responses = rankingDatas.response
                DispatchQueue.main.sync {
                    self.rankingTableView.reloadData()
                }
            }
        }.resume()
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let responses = responses else { return 0 }
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rankingCell = rankingTableView.dequeueReusableCell(withIdentifier: "rankingCell")! as UITableViewCell as! RankingCell
        
        if let responses = responses, indexPath.section < responses.count {
            for _ in responses {
                
                let response = responses[indexPath.section]
                rankingCell.rankLabel.text = String(response.position)
                
                if rankButton.titleLabel?.text == "Drivers" {
                    if let driver = response.driver {
                        rankingCell.driverNameLabel.text = driver.name
                    }
                } else {
                    rankingCell.driverNameLabel.text = response.team.name
                }
                
                if let points = response.points, points > 0 {
                    rankingCell.pointsLabel.text = String(points)
                } else {
                    rankingCell.pointsLabel.text = "0"
                }
                //Download and set image for team logo
                let url = response.team.logo
                if let cachedImage = imageCache[url] {
                    rankingCell.teamLogoImageView.image = cachedImage
                } else {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            self.imageCache[url] = image
                            DispatchQueue.main.async {
                                rankingCell.teamLogoImageView.image = image
                            }
                        }
                    }
                }
            }
        }
        return rankingCell
    }
}

extension RankingViewController: PickerViewControllerDelegate {
    
    func selectedOption(rank: String, season: String) {
        
        if rank == "drivers" {
            rankButton.setTitle("Drivers", for: .normal)
        } else {
            rankButton.setTitle("Constructors", for: .normal)
        }
        yearButton.setTitle(season, for: .normal)
        print("Checking \(rank) ranking in \(season)")
        apiCall(rank: rank, season: season)
    }
}
