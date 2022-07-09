//
//  TodayLessonCollectionCell.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import UIKit
import Combine

final class TodayLessonCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodayLessonCollectionViewCell"

    var viewModel: TodayLessonCollectionCellViewModel! {
        didSet { setUpViewModel() }
    }

    lazy var isFinished: Bool = false

    lazy var remainDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary400
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
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
                remainDayLabel,
                categoryNameLabel,
                siteNameLabel
            ]
        )
        stackView.spacing = 6
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()

    lazy var lessonNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .gray300
        return label
    }()

    lazy var progressBarView: UIView = {
        let view = UIView()
        view.snp.makeConstraints {
            $0.width.equalTo(213)
            $0.height.equalTo(70)
        }
        view.backgroundColor = .gray200
        return view
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.activationPlus, for: .normal)
        return button
    }()

    lazy var pigView: UIView = {
        let view = UIView()
        view.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(58)
        }
        view.backgroundColor = .gray200
        print(isFinished)
        return view
    }()

    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.disableMinus, for: .normal)
        return button
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                minusButton,
                pigView,
                plusButton
            ]
        )
        stackView.spacing = 18
        stackView.distribution = .equalSpacing
        stackView.alignment = .bottom
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        addSubviews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 20
    }

    private func addSubviews() {
        let subviews = [
            labelStackView,
            lessonNameLabel,
            progressBarView,
            numberLabel,
            buttonStackView
        ]
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        labelStackView.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(20)
        }

        lessonNameLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).inset(-11)
            $0.left.right.equalToSuperview().inset(20)
        }

        progressBarView.snp.makeConstraints {
            $0.top.equalTo(lessonNameLabel.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(progressBarView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }

        numberLabel.snp.makeConstraints {
            $0.bottom.equalTo(buttonStackView.snp.top)
            $0.centerX.equalTo(buttonStackView.snp.centerX)
        }
    }

    private func setUpViewModel() {
        changeFinishedView(isFinished: viewModel.totalNumber == viewModel.presentNumber)
        remainDayLabel.text = "D-\(viewModel.remainDay ?? 0)"
        categoryNameLabel.text = viewModel.categoryName
        siteNameLabel.text = viewModel.siteName
        lessonNameLabel.text = "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)" //viewModel.lessonName
        numberLabel.text = "0/4"
    }

    private func changeFinishedView(isFinished: Bool) {
        pigView.isHidden = isFinished
    }
}

final class TodayLessonCollectionCellViewModel {
    @Published var lessonName: String? = ""
    @Published var categoryName: String? = ""
    @Published var remainDay: Int? = 0
    @Published var siteName: String? = ""
    @Published var presentNumber: Int? = 0
    @Published var totalNumber: Int? = 0

    private let lesson: Lesson

    init(lesson: Lesson) {
        self.lesson = lesson

        setUpBindings()
    }

    private func setUpBindings() {
        lessonName = lesson.lessonName
        categoryName = lesson.categoryName
        remainDay = lesson.remainDay
        siteName = lesson.siteName
        presentNumber = lesson.presentNumber
        totalNumber = lesson.totalNumber
    }
}
