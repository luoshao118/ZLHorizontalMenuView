//
//  ZLCoreAnimationViewController.swift
//  ZLHorizontalMenuView
//
//  Created by luoshao on 05/03/2015.
//  Copyright (c) 2015 Zhiling LUO. All rights reserved.
//

import UIKit

class ZLCoreAnimationViewController: UIViewController {

    var view_1:UIView?
    var view_2:UIView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.whiteColor()
        func addshadowInFunc(subView:UIView)
        {
            var shadowPath = UIBezierPath(rect:subView.bounds)
            subView.layer.backgroundColor = UIColor.greenColor().CGColor
            subView.layer.masksToBounds = false;
            subView.layer.shadowColor = UIColor.blackColor().CGColor
            subView.layer.shadowOffset = CGSizeMake(-5.0, 5.0)
            subView.layer.shadowOpacity = 0.5
            subView.layer.shadowPath = shadowPath.CGPath
        }
        
        
        // add shadows
        view_1=UIView(frame: CGRectMake(50, 100, 100, 100))
        addshadow(view_1!)
        view.addSubview(view_1!)
        
        // add shadows from the func in a func
        view_2=UIView(frame: CGRectMake(200, 300, 100, 100))
        addshadowInFunc(view_2!)
        view.addSubview(view_2!)
        
    }
    
    
    // if 'addshadow' just call by only one func,
    // we can make it into the func where the 'addshadow' is called
    // like 'addshadowInFunc'
    func addshadow(subView:UIView)
    {
        var shadowPath = UIBezierPath(rect:subView.bounds)
        subView.layer.backgroundColor = UIColor.redColor().CGColor
        subView.layer.masksToBounds = false;
        subView.layer.shadowColor = UIColor.blackColor().CGColor
        subView.layer.shadowOffset = CGSizeMake(5.0, 5.0)
        subView.layer.shadowOpacity = 0.5
        subView.layer.shadowPath = shadowPath.CGPath
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
