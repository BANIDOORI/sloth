//
//  PushNotificationCollectionViewCell.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class PushNotificationTableViewCell: UITableViewCell {
    var isOn: Bool? {
        didSet {
            guard let isOn = isOn else { return }
            switchView.isOn = isOn
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.addArrangedSubviews(views: [iconImageView, labelStackView, switchContainerView])
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .Sloth.push
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubviews(views: [titleLabel, descLabel])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "푸시 알림"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.text = "알림을 받는 회원들이\n나무늘보를 많이 이기고 있어요!"
        label.textColor = UIColor(red: 139/255, green: 139/255, blue: 139/255, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let switchContainerView = UIView()
    
    private let switchView: SwitchView = {
        let switchView = SwitchView()
        switchView.onTintColor = .switchBackground
        switchView.thumbTintColor = .primary400
        return switchView
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
            $0.top.bottom.equalToSuperview().inset(22)
            $0.left.right.equalToSuperview().inset(18)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        switchContainerView.snp.makeConstraints {
            $0.width.equalTo(52)
        }
        
        switchContainerView.addSubview(switchView)
        
        switchView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
