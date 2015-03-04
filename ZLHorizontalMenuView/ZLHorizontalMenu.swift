//
//  ZLHorizontalMenu.swift
//  ZLHorizontalMenuView
//
//  Created by luoshao on 03/03/2015.
//  Copyright (c) 2015 Zhiling LUO. All rights reserved.
//

import UIKit

protocol ZLHorizontalMenuDelegate {
    func didSelectPage(page:NSInteger)
}

class ZLHorizontalMenu: UIScrollView{
    
    let ZL_Offset:CGFloat = 100.00
    let ZL_Margin:CGFloat = 40.00
    let ZL_Height:CGFloat = 1.00
    
    var menuDelegate:ZLHorizontalMenuDelegate?
    var index:NSInteger=0
    var titles = NSMutableArray()
    var constraints = NSMutableArray()
    var buttons = NSMutableArray()
    var menuSize:CGFloat = 20.00;
    
    // set custom styles
    var buttonColor:UIColor?
    var buttonFont:UIFont?
    var underlineColor:UIColor?
    var underlineHeight:CGFloat?
    var background_color:UIColor?
    
    var underLine=UIView(frame: CGRectZero)
    
    // set the style of menu 
    func setMenuStyle(menu:UIColor?,menuFont:UIFont?,trait:UIColor?,
        height:CGFloat?, background:UIColor?)
    {
        self.buttonColor = menu
        self.buttonFont = menuFont
        self.underlineColor = trait
        self.underlineHeight = height
        self.background_color = background
    }
    
    //MARK: - View life Cycle
    
    // add all menuButtons and the underline
    override func layoutSubviews()
    {
        if buttons.count>0
        {
            return      // call just only one time
        }
        
        // setup menuButtons
        for var i = 0; i<titles.count ; i++
        {
            let button=UIButton()
           
            button.tag=i
            button.alpha=0.3
            button.titleLabel?.font ?? buttonFont
            button.backgroundColor = UIColor.clearColor()
            button.setTitleColor(buttonColor ?? UIColor.whiteColor(), forState: .Normal)
            button.setTitle(titles.objectAtIndex(i) as NSString, forState: .Normal)
            button.sizeToFit()
            
            var frame = button.frame
            frame.origin.x=menuSize
            frame.origin.y=(CGRectGetHeight(self.frame)-CGRectGetHeight(frame))/2
            
            button.frame=frame
            button.addTarget(self, action:"selectPage:", forControlEvents:.TouchUpInside)
            
            self.addSubview(button)
            
            buttons.addObject(button)
            menuSize+=(CGRectGetWidth(button.bounds)+ZL_Margin)
        }
        
        // setup under line
        underLine.backgroundColor = underlineColor ?? UIColor.whiteColor()
        var frame=(buttons.objectAtIndex(0)as UIButton).frame
        frame.origin.y=CGRectGetMaxY(frame)-1
        frame.size.height = underlineHeight ?? ZL_Height
        underLine.frame=frame
        
        self.addSubview(underLine)
    
        // set the veiw content size
        self.contentSize=CGSizeMake(menuSize,self.frame.size.height)
        self.backgroundColor = background_color ?? UIColor.darkGrayColor()
        
        // setup for the begin state
        animate(0)
        
    }
    
  
    //MARK: - Target Action
    
    func selectPage(sender: UIButton!)
    {
        self.index = (sender as UIButton).tag
        if let delegate=self.menuDelegate
        {
            delegate.didSelectPage(index)
        }
    }
    
    
    //MARK: - View Animation
    
    // animate subviews based of content view
    func animate(contentOffset:CGFloat)
    {
        println(CGFloat(Int(contentOffset)))
        animate(Int(contentOffset),percent:(contentOffset-CGFloat(Int(contentOffset))))
    }
    
    
    func animate(page:Int,percent:CGFloat)
    {
        
        var line_frame = self.underLine.frame
        var contentOffset = CGFloat(page) + percent
        
        // calcul the content offset
        // and underline frame
        if page < self.buttons.count-1
        {
            var currentBtn = self.buttons.objectAtIndex(page) as UIButton
            var nextBtn = self.buttons.objectAtIndex(page+1) as UIButton
            var distance_x =  nextBtn.frame.origin.x - currentBtn.frame.origin.x
            var different_w = nextBtn.frame.size.width - currentBtn.frame.size.width
            
            // calcul the line frame
            line_frame.origin.x = currentBtn.frame.origin.x + distance_x * percent
            line_frame.size.width = currentBtn.frame.size.width + different_w * percent
            
            currentBtn.alpha=1-percent*0.7
            nextBtn.alpha=0.3+percent*0.7
            underLine.alpha=max(currentBtn.alpha,nextBtn.alpha)
        }
        
        // update
        underLine.frame = line_frame
        self.contentOffset = CGPointMake(ZL_Offset*contentOffset,0)
        if percent == 0 {self.index = page}
    }
    
    
}
