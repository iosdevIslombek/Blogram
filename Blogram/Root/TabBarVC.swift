//
//  TabBarVC.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // All -------------------------
        let allVC = AllVC(nibName: "AllVC", bundle: nil)
        let allNavVC = UINavigationController(rootViewController: allVC)
        
        let allTabBarItem = UITabBarItem(title: "All",image: UIImage(named: "blogsAndUsers"), selectedImage: nil)
        allNavVC.tabBarItem = allTabBarItem
        
        // Blogs -------------------------
        let blogsVC = BlogsVC(nibName: "BlogsVC", bundle: nil)
        let blogsNavVC = UINavigationController(rootViewController: blogsVC)
        blogsVC.isLikeVC = false
        let blogsTabBarItem = UITabBarItem(title: "Blogs", image: UIImage(named: "allBlogs"), selectedImage: nil)
        blogsNavVC.tabBarItem = blogsTabBarItem
        
        // Users
        let usersVC = UsersVC(nibName: "UsersVC", bundle: nil)
        let usersNavVC = UINavigationController(rootViewController: usersVC)
        let usersTabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "allUsers"), selectedImage: nil)
        usersNavVC.tabBarItem = usersTabBarItem
        
        // Profile -------------------------
        let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        profileNavVC.tabBarItem = profileTabBarItem

        viewControllers = [allNavVC, blogsNavVC, usersNavVC, profileNavVC]
    }
}
