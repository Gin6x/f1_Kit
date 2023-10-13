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
        
//        apiCall(rank: "drivers", season: "2023")
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
            "X-RapidAPI-Key": "abc",
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
        
        if let responses = responses {
            rankingCell.rankLabel.text = String(responses[indexPath.section].position)
            rankingCell.driverNameLabel.text = responses[indexPath.section].driver?.name
            if let points = responses[indexPath.section].points, points > 0 {
                rankingCell.pointsLabel.text = String(points)
            } else {
                rankingCell.pointsLabel.text = "0"
            }
            rankingCell.teamLogoImageView.downloaded(from: responses[indexPath.section].team.logo)
        }
        return rankingCell
    }
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
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
