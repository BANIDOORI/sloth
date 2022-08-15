//
//  TitleInput.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/15.
//

import UIKit

class TitleInput: UIView {
    // MARK: Title Label Properties
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var titleTextAlign: NSTextAlignment = .left {
        didSet {
            titleLabel.textAlignment = titleTextAlign
        }
    }
    
    var titleTextColor: UIColor = .gray500 {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var titleFont: UIFont = .systemFont(ofSize: 16, weight: .medium) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = titleTextAlign
        label.textColor = titleTextColor
        label.font = titleFont
        return label
    }()
    
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        addSubview(titleLabel)
        addSubview(containerView)
        initializeConstraints()
    }
    
    private func initializeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(56)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }
}
