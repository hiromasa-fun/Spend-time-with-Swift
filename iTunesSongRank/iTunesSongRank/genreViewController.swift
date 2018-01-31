//
//  genreViewController.swift
//  iTunesSongRank
//
//  Created by 川北紘正 on 2018/01/31.
//  Copyright © 2018年 川北紘正. All rights reserved.
//

import UIKit

class genreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Label
        let label1 = UILabel()
        label1.text = "hello"
        label1.sizeToFit()
        label1.center = self.view.center
        self.view.addSubview(label1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
