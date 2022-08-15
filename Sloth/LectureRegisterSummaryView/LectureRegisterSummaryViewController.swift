//
//  LectureRegisterSummaryViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class LectureRegisterSummaryViewController: UIViewController {
    
    private let upperBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary400
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나공이에게 결투를 신청합니다!"
        label.font = UIFont(name: "OTSBAggroM", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .Sloth.register
        return imageView
    }()
    
    private let informationView: LectureSummaryInformationView = LectureSummaryInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        setupNavigationBar()
    }
    
    private func initializeViews() {
        view.backgroundColor = .white
        
        view.addSubview(upperBackgroundView)
        view.addSubview(titleLabel)
        view.addSubview(informationView)
        view.addSubview(iconImageView)
        
        upperBackgroundView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(280)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(48)
            $0.left.right.equalToSuperview().inset(22)
        }
    
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(160)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        informationView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).inset(30)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(440)
        }
    }
    
    private func setupNavigationBar() {
        title = "새로운 인강 등록"
        
        navigationController?.navigationBar.tintColor = .gray600
        navigationController?.navigationBar.backIndicatorImage = .back
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .back
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
}
