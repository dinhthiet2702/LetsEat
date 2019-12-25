//
//  BaseTabBarViewController.swift
//  LetsEat
//
//  Created by thiet on 12/23/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        // Do any additional setup after loading the view.
    }
    func setupTabBar() {
        // xac dinh viewcontroller
        let MainVC = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        //setup item tabbar
        MainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "main")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:UIImage(named: "main_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        //them vao navigation controllers
        let navMain = BaseNavigationViewController(rootViewController: MainVC)
        
        // xac dinh viewcontroller
        let NearLocationVC = sb.instantiateViewController(withIdentifier: "NearLocationViewController") as! NearLocationViewController
        //setup item tabbar
        NearLocationVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "nearlocation")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:UIImage(named: "nearlocation_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        //them vao navigation controllers
        let navNearLocationVC = BaseNavigationViewController(rootViewController: NearLocationVC)
        
        // xac dinh viewcontroller
               let CategoryVC = sb.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        //setup item tabbar
               CategoryVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "save")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:UIImage(named: "save_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        //them vao navigation controllers
               let navCategoryVC = BaseNavigationViewController(rootViewController: CategoryVC)
        
        // xac dinh viewcontroller
               let NotificationsVC = sb.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
               //setup item tabbar
               NotificationsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "notifications")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:UIImage(named: "notifications_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
               //them vao navigation controllers
               let navNotificationsVC = BaseNavigationViewController(rootViewController: NotificationsVC)
        
        // xac dinh viewcontroller
                let ProfileVC = sb.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                      //setup item tabbar
                ProfileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "wall")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:UIImage(named: "wall_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
                      //them vao navigation controllers
                let navProfileVC = BaseNavigationViewController(rootViewController: ProfileVC)
        
        
        //them vao tabbar controllers
        self.viewControllers = [navMain, navNearLocationVC, navCategoryVC, navNotificationsVC, navProfileVC]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
