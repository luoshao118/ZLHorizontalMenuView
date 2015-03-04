//
//  ViewController.swift
//  ZLHorizontalMenuView
//
//  Created by luoshao on 03/03/2015.
//  Copyright (c) 2015 Zhiling LUO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name:NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title=name
        {
            nameLabel.text=title
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
