//
//  LectureDetailViewController.swift
//  Sloth
//
//  Created by Eojin on 2022/08/15.
//

import UIKit
import SnapKit

final class LectureDetailViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()

    private lazy var slothImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(160)
        }
        return imageView
    }()
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private lazy var headerSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 내가 날린 돈"
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private lazy var headerMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .primary500
        return label
    }()

    private lazy var moneyStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                headerSubTitleLabel,
                headerMoneyLabel
            ]
        )
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var headerStackView: UIStackView = {
        let descriptionStackView = UIStackView(
            arrangedSubviews: [
                headerTitleLabel,
                moneyStackView
            ]
        )
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 16

        let stackView = UIStackView(
            arrangedSubviews: [
                slothImageView,
                descriptionStackView
            ]
        )
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        return stackView
    }()

    private lazy var lessonInformationView = LessonInformationView()
    private lazy var lessonDescriptionView = LessonDescriptionView()
    private lazy var bodyView = UIView()
    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()

    private lazy var deleteButton: ConfirmButton = {
        let button = ConfirmButton()
        button.backgroundColor = .gray200
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("삭제", for: .normal)
        button.addTarget(self, action: #selector(handleDeleteButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var categoryNameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .gray200
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()

    lazy var siteNameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .gray200
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        return label
    }()

    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                categoryNameLabel,
                siteNameLabel
            ]
        )
        stackView.spacing = 6
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()

    lazy var labelDescriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "강의 정보"
        return label
    }()

    lazy var progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary100
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupScrollSubViews()
        setupHeaderViews()
        setupBodyViews()
        setupLessonInformationView()
        setupProgressBarView()
        setupLessonDescriptionView()
        setupDeleteButton()

        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .back
    }

    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .gray100

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    }

    private func setupScrollSubViews() {
        let subview = [
            headerStackView,
            bodyView
        ]
        subview.forEach {
            contentView.addSubview($0)
        }
    }

    private func setupHeaderViews() {
        headerStackView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        slothImageView.image = .Sloth.inProgress
        headerTitleLabel.text = "꾸준히 듣고 있는\n중이에요!"
        headerMoneyLabel.text = "50,000원"
    }

    private func setupBodyViews() {
        bodyView.insetsLayoutMarginsFromSafeArea = false
        bodyView.backgroundColor = .white

        bodyView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(22)
            $0.width.equalTo(contentView.snp.width)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        bodyView.addSubview(bodyStackView)
//        bodyStackView.snp.makeConstraints {
//            $0.top.equalTo(bodyView.snp.top).inset(40)
//            $0.trailing.leading.equalToSuperview().inset(16)
//            $0.bottom.equalTo(bodyView.snp.bottom).inset(40)
//        }
    }

    private func setupLessonInformationView() {
        bodyView.addSubview(lessonInformationView)
        lessonInformationView.snp.makeConstraints {
            $0.top.equalTo(bodyView.snp.top).inset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        bodyView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(lessonInformationView.snp.bottom).offset(8)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().inset(16)
        }

        lessonInformationView.lessonNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        lessonInformationView.categoryNameLabel.isHidden = true
        lessonInformationView.siteNameLabel.isHidden = true
        lessonInformationView.deadlineLabel.isHidden = false
        lessonInformationView.remainDayLabel.textColor = .error
        categoryNameLabel.text = "개발"
        siteNameLabel.text = "인프런"

//        lessonInformationView.labelStackView.isHidden = true
    }

    private func setupProgressBarView() {
        bodyView.addSubview(progressBarView)
        progressBarView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(16)
            $0.height.equalTo(146)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupLessonDescriptionView() {
        bodyView.addSubview(labelDescriptionTitleLabel)
        bodyView.addSubview(lessonDescriptionView)

        labelDescriptionTitleLabel.snp.makeConstraints{
            $0.top.equalTo(progressBarView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        lessonDescriptionView.snp.makeConstraints {
            $0.top.equalTo(labelDescriptionTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupDeleteButton() {
        bodyView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo((lessonDescriptionView).snp.bottom).offset(32)
            $0.bottom.equalTo(bodyView.snp.bottom).inset(40)
            $0.trailing.leading.equalToSuperview().inset(16)
        }
    }

    @objc private func handleDeleteButtonTapped() {
        print(#function)
    }
}

final class LessonDescriptionView: UIView {
    private let container = UIStackView()

    lazy var lessonCountDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "강의 개수"
        return label
    }()
    lazy var lessonCountLabel = UILabel()

    lazy var dayDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "수강 기간"
        return label
    }()
    lazy var dayLabel = UILabel()

    lazy var moneyDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "금액"
        return label
    }()
    lazy var moneyLabel = UILabel()

    lazy var pushNotiDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "푸시 알림 주기"
        return label
    }()
    lazy var pushNotiLabel = UILabel()

    lazy var determinationDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "각오 한 마디"
        return label
    }()

    lazy var determinationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.snp.makeConstraints {
            $0.width.equalTo(230)
        }
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        dummyData()
        addSubviews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dummyData()
        addSubviews()
        setUpConstraints()
    }

    private func dummyData() {
        lessonCountLabel.text = "24강"
        dayLabel.text = "2021.10.24 - 2021. 12. 24"
        moneyLabel.text = "250,000원"
        pushNotiLabel.text = "매주 화요일"
        determinationLabel.text = "열심히열심히열심히열심히열심히열심히열심히열심히열심히열심히"

    }

    private func addSubviews() {
        addSubview(container)
        container.axis = .vertical
        container.spacing = 14

        container.addArrangedSubview(
            makeStackView(
                descLabel: lessonCountDescLabel,
                label: lessonCountLabel
            )
        )
        container.addArrangedSubview(
            makeStackView(
                descLabel: dayDescLabel,
                label: dayLabel
            )
        )
        container.addArrangedSubview(
            makeStackView(
                descLabel: moneyDescLabel,
                label: moneyLabel
            )
        )
        container.addArrangedSubview(
            makeStackView(
                descLabel: pushNotiDescLabel,
                label: pushNotiLabel
            )
        )
        container.addArrangedSubview(
            makeStackView(
                descLabel: determinationDescLabel,
                label: determinationLabel
            )
        )
    }

    private func makeStackView(descLabel: UILabel, label: UILabel) -> UIStackView {
        label.textColor = .gray600
        label.font = .systemFont(ofSize: 16, weight: .medium)
        let stackView = UIStackView(
            arrangedSubviews: [
                descLabel,
                label
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }

    private func setUpConstraints() {
        container.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
