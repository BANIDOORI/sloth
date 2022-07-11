//
//  LessonInformationView.swift
//  Sloth
//
//  Created by Eojin on 2022/07/10.
//

import UIKit
import Combine

class LessonInformationView: UIView {
    private let container = UIStackView()

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
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        let stackView = UIStackView(
            arrangedSubviews: [
                remainDayLabel,
                categoryNameLabel,
                siteNameLabel,
                emptyView
            ]
        )
        stackView.spacing = 6
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    lazy var lessonNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        addSubview(container)
        container.axis = .vertical
        container.spacing = 10
        container.addArrangedSubview(labelStackView)
        container.addArrangedSubview(lessonNameLabel)
    }

    private func setUpConstraints() {
        container.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
