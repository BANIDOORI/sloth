//
//  MyAccountCollectionViewCell.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {
    var accountItem: MyAccountElement? {
        didSet {
            guard let item = accountItem else { return }
            profileIconView.setImage(item.iconImage ?? UIImage.profile, for: .normal)
            nameLabel.text = item.name
            emailLabel.text = item.email
        }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let profileIconContainerView: UIView = UIView()
    
    private let profileIconView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.profile, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.text = "심두리"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.text = "doori.sim@gmail.com"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeViews()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(36)
            $0.left.right.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(views: [profileIconContainerView, nameLabel, emailLabel])
        profileIconContainerView.addSubview(profileIconView)
        
        profileIconView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(profileIconView.snp.height)
            $0.centerX.equalToSuperview()
        }
        
        stackView.setCustomSpacing(7, after: profileIconView)
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(28)
        }
        
        stackView.setCustomSpacing(1, after: nameLabel)
        
        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
    }
    
    func config(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}

