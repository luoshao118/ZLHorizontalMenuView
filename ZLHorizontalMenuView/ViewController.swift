//
//  ViewController.swift
//  ZLHorizontalMenuView
//
//  Created by luoshao on 03/03/2015.
//  Copyright (c) 2015 Zhiling LUO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameBtn: UIButton!
    var name:NSString!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let title=name
        {
            nameBtn.setTitle(title, forState: .Normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showDetail(sender: AnyObject)
    {
        let destinationVC = ZLCoreAnimationViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
