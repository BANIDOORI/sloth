//
//  RegisterLectureViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/11.
//

import UIKit

class RegisterLectureViewController: UIViewController {
    
    private let titleContainerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 강의를 들으시나요?"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .gray600
        return label
    }()
    
    
    private let fieldContainerView: UIView = UIView()
    
    private let lectureNameField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 이름"
        field.placeholder = "수강할 인강 이름을 입력하세요."
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
    }
    
    private func initializeViews() {
        view.backgroundColor = .white
        
        initializeTitleView()
        initializeFields()
    }
    
    private func initializeTitleView() {
        view.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(80)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.left.bottom.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
        }
    }
    
    private func initializeFields() {
        view.addSubview(fieldContainerView)
        fieldContainerView.addSubview(lectureNameField)
        fieldContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.left.right.bottom.equalToSuperview()
        }
        lectureNameField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(86)
        }
        
    }
}
