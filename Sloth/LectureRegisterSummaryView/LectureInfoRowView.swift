//
//  LectureInfoRowView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

final class LectureInfoRowView: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var info: String = "" {
        didSet {
            infoLabel.text = info
        }
    }
    
    var isEditable: Bool = true {
        didSet {
            notEditableLabel.isHidden = isEditable
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray500
        label.textAlignment = .left
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray500
        label.textAlignment = .left
        return label
    }()
    
    private let notEditableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .error
        label.textAlignment = .right
        label.text = "*수정불가"
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        addSubview(titleLabel)
        addSubview(infoLabel)
        addSubview(notEditableLabel)
        titleLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
        }
        notEditableLabel.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
        }
        infoLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(notEditableLabel.snp.left)
        }
    }
}
