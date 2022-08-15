//
//  MyPageServiceCollectionViewCell.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class MyPageServiceTableViewCell: UITableViewCell {
    var myPageService: MyPageServiceType? {
        didSet {
            guard let item = myPageService else { return }
            titleLabel.text = item.rawValue
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let rightButtonIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .right
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightButtonIcon)
        rightButtonIcon.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(16)
            $0.right.equalTo(rightButtonIcon.snp.left)
        }
    }
    
    func config(title: String) {
        titleLabel.text = title
    }
}
