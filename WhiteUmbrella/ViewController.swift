//
//  ViewController.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/19/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var UVLabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    var futureNews = Future(list:[])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrent()
        getFuture()
        getUV()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futureNews.list.isEmpty ? 0 : futureNews.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let new = futureNews.list[indexPath.row]
        
        cell.textLabel?.text = "Date: \(new.date)"
        cell.detailTextLabel?.text = "\(Int8(new.main.temp - 273.15))℃; Wind speed: \(new.wind.speed) m/s; Cloudiness: \(new.clouds.all) %;\n\(new.weather[0].description)"
        
        return cell
    }
    
    func getCurrent(){
        do{
            let url = try NewsApiRouter.weather.asRequest()
            //print(url)
            ApiService.shared.request(request: url, type: Current.self) { result in
                switch result{
                case .success(let information):
                    DispatchQueue.main.async {
                        self.tempLabel.text = "\(Int8(information.main.temp - 273.15))℃"
                        self.windLabel.text = "Wind speed: \(information.wind.speed) m/s"
                        self.cloudLabel.text = "Cloudiness: \(information.clouds.all) %"
                        self.descLabel.text = information.weather[0].description
                    }
                    break
                case .failure(let failure):
                    print("C ERROR:\n\(failure)")
                    break
                }
            }
        }catch{
            print("no data")
        }
    }
    
    func getFuture(){
        do{
            let url = try NewsApiRouter.forecast.asRequest()
            //print(url)
            ApiService.shared.request(request: url, type: Future.self) { result in
                switch result{
                case .success(let information):
                    self.futureNews = information
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    break
                case .failure(let failure):
                    print("F ERROR:\n\(failure)")
                    break
                }
            }
        }catch{
            print("no data")
        }
    }
    
    func getUV(){
        do{
            let url = try NewsApiRouter.uvi.asRequest()
            //print(url)
            ApiService.shared.request(request: url, type: UV.self) { result in
                switch result{
                case .success(let information):
                    DispatchQueue.main.async {
                        self.UVLabel.text = "UV: \(information.value)"
                    }
                    break
                case .failure(let failure):
                    print("U ERROR:\n\(failure)")
                    break
                }
            }
        }catch{
            print("no data")
        }
    }
    
}

