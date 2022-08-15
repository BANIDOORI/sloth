//
//  PushNotiCycleCollectionViewCell.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

final class PushNotiCycleCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            toggle()
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.gray300.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.height / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func toggle() {
        textLabel.textColor = isSelected ? .white : .gray500
        containerView.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.gray300.cgColor
        containerView.backgroundColor = isSelected ? .primary400 : .clear
    }
    
    func config(text: String) {
        textLabel.text = text
    }
}
