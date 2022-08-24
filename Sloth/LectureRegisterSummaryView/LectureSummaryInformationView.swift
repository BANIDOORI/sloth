//
//  LectureSummaryInformationView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class LectureSummaryInformationView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubviews(views: [titleLabel, descLabel, dashed, infoContainerView])
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OTSBAggroM", size: 20)
        label.textAlignment = .center
        label.textColor = .gray600
        label.text = "결투 신청서"
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Framer X로 인터랙티브 UI 디자인하기 최대 두 줄까지 허용합니다"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let dashed: UIView = UIView()
    
    private lazy var infoContainerView: UIView = {
        let view = UIView()
        view.addSubview(infoRowStackView)
        return view
    }()
    
    private lazy var infoRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.addArrangedSubviews(views: [
            lectureCountRowView,
            lectureCategoryRowView,
            lectureSiteRowView,
            lectureAmountRowView,
            lecturePushNotiCycleRowView,
            lectureStartDateRowView,
            lectureEndDateRowView
        ])
        return stackView
    }()
    
    private let lectureCountRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "강의 개수"
        return view
    }()
    
    private let lectureCategoryRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "카테고리"
        return view
    }()
    
    private let lectureSiteRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "강의 사이트"
        return view
    }()
    
    private let lectureAmountRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "강의 금액"
        return view
    }()
    
    private let lecturePushNotiCycleRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "푸쉬 알림 주기"
        return view
    }()
    
    private let lectureStartDateRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "강의 시작일"
        view.isEditable = false
        return view
    }()
    
    private let lectureEndDateRowView: LectureInfoRowView = {
        let view = LectureInfoRowView()
        view.title = "완강 목표일"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.gray300.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.minY), CGPoint(x: bounds.maxX - 32, y: bounds.minY)])
        shapeLayer.path = path
        dashed.layer.addSublayer(shapeLayer)
    }
    
    private func initializeViews() {
        backgroundColor = .white
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        stackView.setCustomSpacing(16, after: titleLabel)
        
        descLabel.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        
        stackView.setCustomSpacing(24, after: descLabel)
        
        dashed.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        stackView.setCustomSpacing(28, after: dashed)
        
        infoRowStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lectureCountRowView.snp.makeConstraints {
            $0.height.equalTo(20)
        }
    }
}
