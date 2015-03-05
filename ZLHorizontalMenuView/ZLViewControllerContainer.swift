//
//  ZLViewControllerContainer.swift
//  ZLHorizontalMenuView
//
//  Created by luoshao on 03/03/2015.
//  Copyright (c) 2015 Zhiling LUO. All rights reserved.
//

import UIKit

class ZLViewControllerContainer: UIViewController,UIScrollViewDelegate,ZLHorizontalMenuDelegate {
    
    var viewControllers = NSMutableArray()
    let listNames = ["CoreAnimations","Notifications","My compte","Setting","Others"]
    let listColor = [(0.5,0.1,0.1),(0.1,0.9,0.1),(0.9,0.1,0.7),(0.6,0.5,0.1),(0.1,0.7,0.9)]
    
    var contentView = UIScrollView(frame: CGRectZero)
    var menuView = ZLHorizontalMenu(frame: CGRectZero)
    
    var currentPage=0

    
    //MARK: - UIView Life cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let superview=self.view
        
        // set up the menuView
        menuView.titles = NSMutableArray(array: listNames)
        menuView.menuDelegate = self
        menuView.setTranslatesAutoresizingMaskIntoConstraints(false)
        menuView.scrollEnabled = false
        var colors = (backgound:UIColor.darkGrayColor(),trait:UIColor.whiteColor(),btn:UIColor.whiteColor())
        menuView.setMenuStyle(colors.btn, menuFont: nil, trait: colors.trait, height: 1, background: nil)
        superview.addSubview(menuView)
        
        //set up the contentView
        contentView.delegate=self
        contentView.pagingEnabled=true
        contentView.bounces=false
        contentView.showsHorizontalScrollIndicator=false
        superview.addSubview(contentView)
        
        
        // add constraints of content and menu view
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let views = Dictionary(dictionaryLiteral:("superview",superview),("menu",menuView),("content",contentView))
        superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[content]|", options: nil, metrics: nil, views:views))
        superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[menu]|", options: nil, metrics: nil, views:views))
        superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[menu(==60)]-0-[content]|", options: nil, metrics: nil, views:views))
        
        
        // add the child views into contentview
        for name in listNames
        {
            // init all childviewcontroller and set up
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("childViewController") as ViewController
            vc.name=name
            let index=(listNames as NSArray).indexOfObject(name)
            let (R,G,B)=listColor[index]
            vc.view.backgroundColor=UIColor(red:CGFloat(R), green: CGFloat(G), blue: CGFloat(B), alpha: 1)
            self.viewControllers.addObject(vc)
            // add childviewcontroller to self
            contentView.addSubview(vc.view)
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
        }
        
    }

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        // call only one time
        if contentView.frame.width>=0
        {
            let frame=self.contentView.bounds
            let width=CGRectGetWidth(frame)
            let height=CGRectGetHeight(frame)
            
            for var i=0; i<viewControllers.count;++i
            {
                let vc=viewControllers.objectAtIndex(i) as ViewController
                vc.view.frame=CGRectMake(CGFloat(i)*width, 0, width, height)
            }
            
            contentView.contentSize=CGSizeMake(CGFloat(viewControllers.count)*width, height)
            contentView.contentOffset=CGPointMake(CGFloat(currentPage)*width, 0)
        }
        
    }
    
    
    
    //MARK: - MenuView Delegate

    func didSelectPage(page: NSInteger)
    {
        currentPage = page
        var content_offset = self.contentView.contentOffset
        content_offset.x = CGFloat(page)*CGRectGetWidth(self.contentView.frame);
        contentView.setContentOffset(content_offset, animated: true)
    }
    
    
    
    //MARK: - UIScrollView Delegate

    func scrollViewDidScroll(scrollView: UIScrollView) {
        menuView.animate(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
    
    
    
    //MARK: -  Memory Warning
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
