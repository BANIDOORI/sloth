//
//  LectureListViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/23.
//

import UIKit

final class LectureListViewController: UIViewController {
    
    weak var navigator: LectureListNavigator?
    
    private lazy var registerButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage.actionPlus, style: .plain, target: self, action: #selector(handleRegisterButtonTapped))
        return button
    }()
    
    private lazy var notificationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage.actionBell, style: .plain, target: self, action: #selector(handleNotificationButtonTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        initializeViews()
    }
    
    private func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.tintColor = .gray600
        navigationItem.rightBarButtonItems = [
            notificationButton,
            registerButton
        ]
    }
    
    private func initializeViews() {
        view.backgroundColor = .white
    }
    
    @objc private func handleRegisterButtonTapped() {
        navigator?.showLectureRegister()
    }
    
    @objc private func handleNotificationButtonTapped() {
        print(#function)
    }
}
