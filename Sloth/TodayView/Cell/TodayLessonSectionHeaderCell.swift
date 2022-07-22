//
//  TodayLessonSectionHeaderCell.swift
//  Sloth
//
//  Created by Eojin on 2022/07/16.
//

import UIKit
import SnapKit

final class TodayLessonSectionHeaderCell: UICollectionReusableView {
    static var identifier: String {
        return String(describing: TodayLessonSectionHeaderCell.self)
    }

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: 18,
            weight: .medium
        )
        label.textColor = .gray500
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
