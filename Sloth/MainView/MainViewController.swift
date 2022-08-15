//
//  MainViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class MainViewController: UITabBarController {
    weak var navigator: MainViewNavigator?
    
    private var tabBarItemImageInset: UIEdgeInsets {
        .init(top: 0, left: 0, bottom: -8, right: 0)
    }
    
    private let todayViewController: TodayViewController
    private let lectureListViewController: LectureListViewController
    private let myPageViewController: MyPageViewController
    
    private let viewModel: MainViewModel
    
    init(
        viewModel: MainViewModel,
        todayViewControllerFactory: @escaping () -> (TodayViewController),
        lectureListViewControllerFactory: @escaping () -> (LectureListViewController),
        myPageViewControllerFactory: @escaping () -> (MyPageViewController)
    ) {
        self.viewModel = viewModel
        self.todayViewController = todayViewControllerFactory()
        self.lectureListViewController = lectureListViewControllerFactory()
        self.myPageViewController = myPageViewControllerFactory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        todayViewController.navigator = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 20
    }
    
    private func initializeViews() {
        navigationItem.setHidesBackButton(true, animated: false)
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

extension MainViewController: TodayViewNavigatorDelegate {
    func showMyPage() {
        
    }
}
