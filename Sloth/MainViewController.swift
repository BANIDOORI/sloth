//
//  MainViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class MainViewController: UITabBarController {
    
    private let todayViewController = UIViewController()
    private let lectureListViewController = UIViewController()
    private let myPageViewController = UIViewController()
    
    private var tabBarItemImageInset: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: -8, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 20
    }
    
    private func initializeViews() {
        setupTabBarItems()
        setupTabBar()
    }
    
    private func setupTabBarItems() {
        todayViewController.tabBarItem = UITabBarItem(
            title: "투데이",
            image: .todayTab,
            selectedImage: .todayTabSelected
        )
        todayViewController.tabBarItem.imageInsets = tabBarItemImageInset
        
        lectureListViewController.tabBarItem = UITabBarItem(
            title: "강의목록",
            image: .lectureListTab,
            selectedImage: .lectureListTabSelected
        )
        lectureListViewController.tabBarItem.imageInsets = tabBarItemImageInset
        
        myPageViewController.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: .myPageTab,
            selectedImage: .myPageTabSelected
        )
        myPageViewController.tabBarItem.imageInsets = tabBarItemImageInset
        
        self.viewControllers = [
            todayViewController,
            lectureListViewController,
            myPageViewController
        ]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .primary400
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        tabBar.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]
        tabBar.layer.cornerRadius = 15
        
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 20, height: 0)
        tabBar.layer.shadowRadius = 20
        tabBar.layer.shadowOpacity = 1
    }
}

