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

    lazy var lessonNameLabel = UILabel()
    lazy var teamLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubiews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubiews() {
        let subviews = [lessonNameLabel, teamLabel]

        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            lessonNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            lessonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            lessonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),

            teamLabel.centerYAnchor.constraint(equalTo: lessonNameLabel.centerYAnchor),
            teamLabel.leadingAnchor.constraint(equalTo: lessonNameLabel.trailingAnchor, constant: 10.0),
            teamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            teamLabel.heightAnchor.constraint(equalTo: lessonNameLabel.heightAnchor)
        ])
    }

    private func setUpViewModel() {
        lessonNameLabel.text = viewModel.lessonName
        teamLabel.text = "\(viewModel.lessonName ?? "")의 팀ㅋ"
    }
}
