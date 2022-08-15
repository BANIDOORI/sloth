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
            lessonInformationView
        ]

        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        lessonInformationView.snp.makeConstraints {
            $0.top.left.trailing.bottom.equalToSuperview().inset(20)
        }
    }

    private func setUpViewModel() {
        changeViewDesign(isDone: viewModel.isDone)
        lessonInformationView.remainDayLabel.text = "D-\(viewModel.remainDay ?? 0)"
        lessonInformationView.categoryNameLabel.text = viewModel.categoryName
        lessonInformationView.siteNameLabel.text = viewModel.siteName
        lessonInformationView.lessonNameLabel.text = "프로그래밍 시작하기 : 파이썬 입문 (Inflearn Original)" //viewModel.lessonName
    }

    private func changeViewDesign(isDone: Bool) {
        lessonInformationView.remainDayLabel.textColor = isDone ? .white : .primary400
        lessonInformationView.categoryNameLabel.backgroundColor = isDone ? .primary200 : .gray200
        lessonInformationView.categoryNameLabel.textColor = isDone ? .primary600 : .black
        lessonInformationView.siteNameLabel.backgroundColor = isDone ? .primary200 : .gray200
        lessonInformationView.siteNameLabel.textColor = isDone ? .primary600 : .black
        lessonInformationView.lessonNameLabel.textColor = isDone ? .white : .black
        backgroundColor = isDone ? .primary500 : .white
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
