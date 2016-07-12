//
//  CustomTabBarControllerViewController.swift
//  facebook_feed_programatically
//
//  Created by parth on 7/12/16.
//  Copyright © 2016 parthanand.com. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().tintColor = UIColor.rgb(70, green: 146, blue: 250)
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named : "news_feed_icon")
        
 
        let friendRequestController = UIViewController()
        let secondNavigationController = UINavigationController(rootViewController : friendRequestController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = UIImage(named : "requests_icon")
        
        
        let messengerVC = UIViewController()
        messengerVC.navigationItem.title = "some title"
        let thirdNavigationController = UINavigationController(rootViewController : messengerVC)
        thirdNavigationController.title = "Messenger"
        thirdNavigationController.tabBarItem.image = UIImage(named : "messenger_icon")
        
        
        let fourthNavigationController = UINavigationController(rootViewController : UIViewController())
        fourthNavigationController.title = "Notifications"
        fourthNavigationController.tabBarItem.image = UIImage(named : "globe_icon")
        
        
        
        viewControllers = [navigationController , secondNavigationController ,thirdNavigationController , fourthNavigationController]
        
        
        tabBar.translucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, green: 231, blue: 235).CGColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    
    }


}