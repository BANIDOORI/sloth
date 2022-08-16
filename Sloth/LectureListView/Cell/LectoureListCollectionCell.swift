//
//  LectoureListCollectionCell.swift
//  Sloth
//
//  Created by Eojin on 2022/08/13.
//

import UIKit
import Combine

final class LectoureListCollectionCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: LectoureListCollectionCell.self)
    }

    var viewModel: LectoureListCollectionCellViewModel! {
        didSet { setUpViewModel() }
    }

    lazy var lessonInformationView = LessonInformationView()

    lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    lazy var lessonCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    lazy var investedMoneyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray600
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    lazy var progressBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()

    lazy var stackView: UIStackView = {
        let labelStackView = UIStackView(
            arrangedSubviews: [
                startDateLabel,
                lessonCountLabel,
                investedMoneyLabel
            ]
        )
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        labelStackView.alignment = .leading

        let stackView = UIStackView(
            arrangedSubviews: [
                lessonInformationView,
                labelStackView,
                progressBarView
            ]
        )

        progressBarView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(66)
        }

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()

    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray600.withAlphaComponent(0.6)
        return view
    }()

    lazy var stampImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
        addSubviews()
        setUpConstraints()

        startDateLabel.text = "시작예정일 2021.10.23"
        investedMoneyLabel.text = "내가 투자한 금액 50,000원"
        lessonCountLabel.text = "강의 개수 50강"
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
            stackView,
            dimmedView
        ]

        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        stackView.snp.makeConstraints {
            $0.top.left.trailing.bottom.equalToSuperview().inset(20)
        }

        dimmedView.snp.makeConstraints {
            $0.top.left.trailing.bottom.equalToSuperview()
        }
    }

    private func setUpViewModel() {
        changeViewDesign(section: viewModel.section)
        lessonInformationView.lessonNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        lessonInformationView.remainDayLabel.text = "D-\(viewModel.remainDay ?? 0)"
        lessonInformationView.categoryNameLabel.text = viewModel.categoryName
        lessonInformationView.siteNameLabel.text = viewModel.siteName
        lessonInformationView.lessonNameLabel.text = "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)" //viewModel.lessonName
    }

    private func changeViewDesign(section: LectureListViewController.Section) {
        progressBarView.isHidden = section != .ing
        lessonCountLabel.isHidden = section != .done
        startDateLabel.isHidden = section != .will
        dimmedView.isHidden = section != .done

        if section == .done {
            dimmedView.addSubview(stampImageView)
            stampImageView.snp.makeConstraints {
                $0.trailing.bottom.equalToSuperview().inset(24)
            }
            stampImageView.image = viewModel.isDone ? .failureStamp : .successStamp
        }
    }
}

final class LectoureListCollectionCellViewModel {
    @Published var lessonName: String? = ""
    @Published var categoryName: String? = ""
    @Published var remainDay: Int? = 0
    @Published var siteName: String? = ""
    @Published var presentNumber: Int? = 0
    @Published var totalNumber: Int? = 0
    @Published var isDone: Bool = false
    @Published var section: LectureListViewController.Section = .ing

    private let lesson: Lesson

    init(lesson: Lesson, section: LectureListViewController.Section) {
        self.lesson = lesson
        self.section = section

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
