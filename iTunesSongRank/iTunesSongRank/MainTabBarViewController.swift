//
//  MainTabBarViewController.swift
//  iTunesSongRank
//
//  Created by 川北紘正 on 2018/02/01.
//  Copyright © 2018年 川北紘正. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        let nv = UINavigationController(rootViewController: vc)
        
        let vc2 = genreViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        let nv2 = UINavigationController(rootViewController: vc2)
        setViewControllers([nv, nv2], animated: false)
        
        // Color
        UITabBar.appearance().tintColor = UIColor(red: 255/255, green: 233/255, blue: 51/255, alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor(red: 66/255, green: 74/255, blue: 93/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
