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
        twitterButton = UIButton(frame: CGRectMake(rect.size.width/2-35, 154, 70, 70))
        twitterButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        twitterButton.tag = 0
        twitterButton.setImage(UIImage(named: "twitter"), forState: .Normal)
        
        siteButton = UIButton(frame: CGRectMake(rect.size.width/2-35, 244, 70, 70))
        siteButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        siteButton.tag = 1
        siteButton.setImage(UIImage(named: "Rss"), forState: .Normal)
        
        githubButton = UIButton(frame: CGRectMake(rect.size.width/2-35, 334, 70, 70))
        githubButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        githubButton.tag = 2
        githubButton.setImage(UIImage(named: "Github")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        githubButton.tintColor = UIColor.whiteColor()
        
        googleButton = UIButton(frame: CGRectMake(rect.size.width/2-35, 424, 70, 70))
        googleButton.addTarget(self, action: "goLinks:", forControlEvents: .TouchUpInside)
        googleButton.tag = 3
        googleButton.setImage(UIImage(named: "g+"), forState: .Normal)
        
        self.view.addSubview(twitterButton)
        self.view.addSubview(siteButton)
        self.view.addSubview(githubButton)
        self.view.addSubview(googleButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.blackColor()

        // Do any additional setup after loading the view.
    }
    
    func goLinks(sender: UIButton) {
        println("関数突撃でち")
        var url = NSURL()
        switch sender.tag {
        case 0:
            println("twitterに飛ぶ処理")
            url = NSURL(string: "https://twitter.com/Tech_Logics")!
        case 1:
            // ロジックスのホームページに飛ぶ処理
            url = NSURL(string: "http://techlogics.link/")!
        case 2:
            // ロジックスのgituhubに飛ぶ処理
            url = NSURL(string: "https://github.com/techlogics")!
        case 3:
            // google+に飛ぶ処理
            url = NSURL(string: "https://plus.google.com/u/0/communities/103512964644715330548")!
        default:
            break // do nothing
        }
        
        UIApplication.sharedApplication().openURL(url)
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
