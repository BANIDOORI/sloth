//
//  TodayLessonCollectionCell.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import UIKit
import Combine

final class TodayLessonCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: TodayLessonCollectionViewCell.self)
    }
    
    var viewModel: TodayLessonCollectionCellViewModel! {
        didSet { setUpViewModel() }
    }

    lazy var lessonInformationView = LessonInformationView()

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
        button.setImage(.activationPlus, for: .normal)
        return button
    }()

    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(.disableMinus, for: .normal)
        return button
    }()

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .gray300
        return label
    }()

    lazy var pigView: UIView = {
        let view = UIView()
        view.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(58)
        }
        view.backgroundColor = .gray200
        return view
    }()

    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                progressBarView,
                buttonStackView
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    lazy var buttonMiddleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                progressBarView,
                numberLabel,
                pigView
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                minusButton,
                buttonMiddleStackView,
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
            lessonInformationView,
            bottomStackView
        ]
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        lessonInformationView.snp.makeConstraints {
            $0.top.left.trailing.equalToSuperview().inset(20)
        }

        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(lessonInformationView.snp.bottom).inset(-20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    private func setUpViewModel() {
        changeViewDesign(isDone: viewModel.isDone)
        lessonInformationView.remainDayLabel.text = "D-\(viewModel.remainDay ?? 0)"
        lessonInformationView.categoryNameLabel.text = viewModel.categoryName
        lessonInformationView.siteNameLabel.text = viewModel.siteName
        lessonInformationView.lessonNameLabel.text = "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)" //viewModel.lessonName
        numberLabel.text = "0/4"
    }

    private func changeViewDesign(isDone: Bool) {
        pigView.isHidden = isDone
        progressBarView.isHidden = isDone
        plusButton.setImage(isDone ? .activationPlusWhite : .activationPlus, for: .normal)
        minusButton.setImage(isDone ? .activationMinusWhite : .disableMinus, for: .normal)
        lessonInformationView.remainDayLabel.textColor = isDone ? .white : .primary400
        lessonInformationView.categoryNameLabel.backgroundColor = isDone ? .primary200 : .gray200
        lessonInformationView.categoryNameLabel.textColor = isDone ? .primary600 : .black
        lessonInformationView.siteNameLabel.backgroundColor = isDone ? .primary200 : .gray200
        lessonInformationView.siteNameLabel.textColor = isDone ? .primary600 : .black
        lessonInformationView.lessonNameLabel.textColor = isDone ? .white : .black
        backgroundColor = isDone ? .primary500 : .white
    }
}

final class TodayLessonCollectionCellViewModel {
    @Published var lessonName: String? = ""
    @Published var categoryName: String? = ""
    @Published var remainDay: Int? = 0
    @Published var siteName: String? = ""
    @Published var presentNumber: Int? = 0
    @Published var totalNumber: Int? = 0
    @Published var isDone: Bool = false

    private let lesson: Lesson

    init(lesson: Lesson, isDone: Bool) {
        self.lesson = lesson
        self.isDone = isDone

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
