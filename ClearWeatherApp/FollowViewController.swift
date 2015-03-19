//
//  FollowViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 3/16/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController {
    
    var twitterButton: UIButton!
    var siteButton: UIButton!
    var githubButton: UIButton!
    var googleButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        let rect = UIScreen.mainScreen().bounds
        
        twitterButton = UIButton(frame: CGRectMake(rect.size.width/2-50, 74, 100, 100))
        twitterButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        twitterButton.tag = 0
        twitterButton.setImage(UIImage(named: "twitter-256"), forState: .Normal)
        
        siteButton = UIButton(frame: CGRectMake(rect.size.width/2-50, 184, 100, 100))
        siteButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        siteButton.tag = 1
        siteButton.setImage(UIImage(named: "rss-256"), forState: .Normal)
        
        githubButton = UIButton(frame: CGRectMake(rect.size.width/2-50, 294, 100, 100))
        githubButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        githubButton.tag = 2
        githubButton.setImage(UIImage(named: "github-256"), forState: .Normal)
        githubButton.tintColor = UIColor.whiteColor()
        
        googleButton = UIButton(frame: CGRectMake(rect.size.width/2-50, 404, 100, 100))
        googleButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        googleButton.tag = 3
        googleButton.setImage(UIImage(named: "googleplus-256"), forState: .Normal)
        
        self.view.addSubview(twitterButton)
        self.view.addSubview(siteButton)
        self.view.addSubview(githubButton)
        self.view.addSubview(googleButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()
        
        FCAnimation().performAnimation(twitterButton, duration: 0.5, delay: 0, type: .Pop)
        FCAnimation().performAnimation(siteButton, duration: 0.5, delay: 0.25, type: .Pop)
        FCAnimation().performAnimation(githubButton, duration: 0.5, delay: 0.50, type: .Pop)
        FCAnimation().performAnimation(googleButton, duration: 0.5, delay: 0.75, type: .Pop)
    }
    
    func goLinks(sender: UIButton) {
        var url = NSURL()
        var button = UIButton()
        switch sender.tag {
        case 0:
            //twitterに飛ぶ処理
            url = NSURL(string: "https://twitter.com/Tech_Logics")!
            button = twitterButton
        case 1:
            // ロジックスのホームページに飛ぶ処理
            url = NSURL(string: "http://techlogics.link/")!
            button = siteButton
        case 2:
            // ロジックスのgituhubに飛ぶ処理
            url = NSURL(string: "https://github.com/techlogics")!
            button = githubButton
        case 3:
            // google+に飛ぶ処理
            url = NSURL(string: "https://plus.google.com/u/0/communities/103512964644715330548")!
            button = googleButton
        default:
            break // do nothing
        }

        FCAnimation().performAnimation(button, duration: 1, delay: 0, type: .Pop)
        UIApplication.sharedApplication().openURL(url)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
