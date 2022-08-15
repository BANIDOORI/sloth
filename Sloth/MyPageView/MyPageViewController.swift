//
//  MyPageViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit


class MyPageViewController: UIViewController {
    
    private var elements: [MyPageElement] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.bounces = true
        tableView.backgroundColor = .background
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(MyPageServiceTableViewCell.self)
        tableView.register(MyAccountTableViewCell.self)
        tableView.register(PushNotificationTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setupDefaultData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    private func setupDefaultData() {
        // NOTE: 추후에 Model 부분으로 옮겨질 예정
        let myAccountElement = MyAccountElement(name: "심두리", email: "doori@gmail.com", iconImage: nil)
        elements.append(myAccountElement)
        let myServiceElement = MyPageServiceElement(serviceType: [.enquiries, .logOut, .signOut])
        elements.append(myServiceElement)
        let pushNotiElement = PushNotiElement(isOn: true)
        elements.append(pushNotiElement)
    }
    
    private func initializeViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = elements[section]
        switch item.type {
        case .service:
            if let serviceItem = item as? MyPageServiceElement {
                return serviceItem.serviceType.count
            }
        default: break
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = elements[indexPath.section]
        switch item.type {
        case .account:
            if let accountItem = item as? MyAccountElement,
               let cell = tableView.dequeueReusableCell(
                withIdentifier: MyAccountTableViewCell.reuseIdentifier,
                for: indexPath
               ) as? MyAccountTableViewCell {
                cell.accountItem = accountItem
                cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
                return cell
            }
        case .service:
            if let serviceItem = item as? MyPageServiceElement,
               let cell = tableView.dequeueReusableCell(
                withIdentifier: MyPageServiceTableViewCell.reuseIdentifier,
                for: indexPath
               ) as? MyPageServiceTableViewCell {
                cell.myPageService = serviceItem.serviceType[indexPath.item]
                
                return cell
            }
        case .pushNoti:
            if let pushNotiItem = item as? PushNotiElement,
               let cell = tableView.dequeueReusableCell(
                withIdentifier: PushNotificationTableViewCell.reuseIdentifier,
                for: indexPath
               ) as? PushNotificationTableViewCell {
                cell.isOn = pushNotiItem.isOn
                cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
