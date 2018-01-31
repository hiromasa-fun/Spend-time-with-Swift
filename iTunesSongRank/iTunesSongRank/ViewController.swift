//
//  ViewController.swift
//  iTunesSongRank
//
//  Created by 川北紘正 on 2018/01/28.
//  Copyright © 2018年 川北紘正. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [JSON] = []
    var nameArray: [String] = []
    var artistNameArray: [String] = []
    let songCount: Int = 24
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()        
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        
        //Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //TableView
        self.view.addSubview(tableView)
        
        // iTunes RSS Generator API
        let listUrl = "https://rss.itunes.apple.com/api/v1/jp/itunes-music/top-songs/all/25/explicit.json";
        //API request
        Alamofire.request(listUrl).responseJSON{ response in
            let json = JSON(response.result.value ?? 0)
            json.forEach{(_, data) in
                self.items.append(data)
                
                //jsonのresults内部から取得して配列に代入
                for i in 0...self.songCount {
                    self.items[0]["results"][i]["name"].string != nil ? self.nameArray.append(self.items[0]["results"][i]["name"].string!) : print("nameが空です。")
                    self.items[0]["results"][i]["artistName"].string != nil ? self.artistNameArray.append(self.items[0]["results"][i]["artistName"].string!) : print("artistNameが空です。")
                }
            }
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // make Cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        cell.textLabel?.text = nameArray[indexPath.row]
        cell.detailTextLabel?.text = artistNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Cell count
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Cell tapped action
        print("タップされたセルのindex番号: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell hight
        return 64
    }
    
}

