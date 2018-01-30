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
    
    // itemsをJSONの配列と定義
    var items: [JSON] = []
    var nameArray: [String] = []
    var artistNameArray: [String] = []
    let songCount: Int = 24
    
    // ステータスバーの高さ
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
        tableView.delegate = self
        tableView.dataSource = self
        
        // 画面に UITableView を追加
        self.view.addSubview(tableView)
        
        // iTunesのAPIからデータを取得
        let listUrl = "https://rss.itunes.apple.com/api/v1/jp/itunes-music/top-songs/all/25/explicit.json";
        //APIリクエスト
        Alamofire.request(listUrl).responseJSON{ response in
            //jsonという変数にJSON配列を代入
            let json = JSON(response.result.value ?? 0)
            //foreachとクロージャ？。itemsにdataを追加
            json.forEach{(_, data) in
                self.items.append(data)
                //itemsのresults内部から取得して配列に代入
                for i in 0...self.songCount {
                    self.items[0]["results"][i]["name"].string != nil ? self.nameArray.append(self.items[0]["results"][i]["name"].string!) : print("空です。")
                    self.items[0]["results"][i]["artistName"].string != nil ? self.artistNameArray.append(self.items[0]["results"][i]["artistName"].string!) : print("空です。")
                }
            }
            tableView.reloadData()
            print(self.items[0])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        cell.textLabel?.text = nameArray[indexPath.row]
        cell.detailTextLabel?.text = artistNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        print("タップされたセルのindex番号: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 64
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // アクセサリボタン（セルの右にあるボタン）がタップされた時の処理
        print("タップされたアクセサリがあるセルのindex番号: \(indexPath.row)")
    }
}

