//
//  genreViewController.swift
//  iTunesSongRank
//
//  Created by 川北紘正 on 2018/01/31.
//  Copyright © 2018年 川北紘正. All rights reserved.
//

import UIKit

class genreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let cellId = "itemCell"
    let photos = ["POP", "Anime", "Electronic", "Alternative", "Classic", "SoundTrack", "Jazz", "Dance", "HIP HOP", "Rock"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.title = "ジャンル"
        
        // 大きさとレイアウトを指定して UICollectionView を作成
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: self.view.frame.size.height - statusBarHeight),
            collectionViewLayout: UICollectionViewFlowLayout())
        
        // アイテム表示領域を白色に設定
        collectionView.backgroundColor = UIColor.darkGray
        
        // セルの再利用のための設定
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // デリゲート設定
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // UICollectionView を表示
        self.view.addSubview(collectionView)
    }
    
    // 表示するアイテムの数を設定（UICollectionViewDataSource が必要）
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // アイテムの大きさを設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.view.frame.width / 3 + 55
        return CGSize(width: size, height: size)
    }
    
    // アイテム表示領域全体の上下左右の余白を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset =  (self.view.frame.width / 4) / 3
        return UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }
    
    // アイテムの上下の余白の最小値を設定（UICollectionViewDelegateFlowLayout が必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (self.view.frame.width / 4) / 3
    }
    
    // アイテムの表示内容（UICollectionViewDataSource が必要）
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // アイテムを作成
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        /*
        let imageIcon = UIImage(named: "imageIcon")
        let image = UIImageView(image: imageIcon)
        image.sizeToFit()
        image.center =  cell.contentView.center
        cell.addSubview(image)
        */
        
        
        // アイテムセルを再利用する際、前に追加していた要素（今回はラベル）を削除する
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Label
        let label = UILabel()
        label.font = UIFont(name: "Copperplate-Light", size: 20)
        label.text = photos[indexPath.row]
        label.textColor = UIColor.white
        label.shadowColor = UIColor.darkGray
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.sizeToFit()
        label.center = cell.contentView.center
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    // アイテムタッチ時の処理（UICollectionViewDelegate が必要）
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(photos[indexPath.row])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

