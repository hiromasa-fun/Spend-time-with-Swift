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
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [JSON] = []
    var songName: [String] = []
    var artistName: [String] = []
    var albumArtWork: [String] = []
    var albumUrl: [String] = []
    let songCount: Int = 24
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        let tableView = UITableView()        
        tableView.frame = CGRect(x: 0, y: statusBarHeight, width: width, height: height-statusBarHeight)
        
        //Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //NavigationController
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "トップソング"
        
        //TableView
        tableView.register(myCell.self, forCellReuseIdentifier: NSStringFromClass(myCell.self))
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
                    self.items[0]["results"][i]["name"].string != nil ? self.songName.append(self.items[0]["results"][i]["name"].string!) : print("nameがありません。")
                    self.items[0]["results"][i]["artistName"].string != nil ? self.artistName.append(self.items[0]["results"][i]["artistName"].string!) : print("artistNameがありません")
                    self.items[0]["results"][i]["artworkUrl100"].string != nil ? self.albumArtWork.append(self.items[0]["results"][i]["artworkUrl100"].string!) : print("albumArtWorkがありません")
                    self.items[0]["results"][i]["url"].string != nil ? self.albumUrl.append(self.items[0]["results"][i]["url"].string!) : print("albumArtWorkがありません")
                }
            }
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(myCell.self), for: indexPath) as! myCell
        
        //Text
        cell.songLabel.text = "\(indexPath.row+1). " + songName[indexPath.row]
        cell.artistNameLabel.text = artistName[indexPath.row]
        
        //Image
        let url = URL(string: albumArtWork[indexPath.row])!
        let imageData = try? Data(contentsOf: url)
        let myImage = UIImage(data: imageData!)
        //cell.imageView!.image = myImage?.resize(size: CGSize(width: 50, height: 50))
        cell.imageView?.af_setImage(withURL: url, placeholderImage: myImage)
        //cell.imageView?.image = myImage

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Cell count
        return songName.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Cell tapped action
        /*
        let url = URL(string: albumUrl[indexPath.row])!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        */
        //debug
        print("\(indexPath.row)番目をタップした")
        print(albumUrl[indexPath.row])
        print(albumArtWork[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Cell hight
        return 64
    }
}


extension UIImage {
    func resize(size: CGSize) -> UIImage {
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
        let resizedSize = CGSize(width: (self.size.width * ratio), height: (self.size.height * ratio))
        // 画質を落とさないように以下を修正
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

class myCell: UITableViewCell {
    var songLabel: UILabel!
    var artistNameLabel: UILabel!
    var myImage: UIImage!
    var myImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Label
        songLabel = UILabel(frame: CGRect.zero)
        songLabel.textAlignment = .left
        contentView.addSubview(songLabel)
        artistNameLabel = UILabel(frame: CGRect.zero)
        artistNameLabel.font = UIFont.systemFont(ofSize: 12)
        artistNameLabel.textAlignment = .left
        contentView.addSubview(artistNameLabel)
        
        /*
        myImage = UIImage()
        myImageView = UIImageView(image: myImage)
        contentView.addSubview(myImageView)
        */
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        songLabel.frame = CGRect(x: 100, y: 0, width: frame.width - 100, height: frame.height)
        artistNameLabel.frame = CGRect(x: 100, y: 22, width: frame.width - 100, height: frame.height)
        //myImageView.frame = CGRect(x: 0, y: 0, width: 64, height: frame.height)
    }
}

