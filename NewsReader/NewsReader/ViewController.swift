//
//  ViewController.swift
//  NewsReader
//
//  Created by Hugo Patural on 11/01/2017.
//  Copyright © 2017 8e etage. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let reuseIdentifier = "myCell"
    
    @IBOutlet weak var tableView: UITableView!
    var titles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyTableViewCell
        
        cell.titre.text = titles[indexPath.row]
        return cell
    }
    
    func getPosts() {
        Alamofire.request("https://8e-etage.fr/wp-json/wp/v2/posts").responseJSON { response in
            print(response.result)   // result of response serialization
            
            if let datas = response.result.value {
                print("JSON: \(datas)")
                
                let json = JSON(datas)
                
                for (_,subJson):(String, JSON) in json {
                    
                    let titleObject = subJson["title"]
                    
                    self.titles.append(titleObject["rendered"].stringValue)
                }
                
                self.tableView.reloadData()
                
            }
        }
    }

}

