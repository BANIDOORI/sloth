//
//  TodayView.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import UIKit
import SnapKit

final class TodayView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)

    init() {
        super.init(frame: .zero)
        backgroundColor = .brown
        addSubviews()
        setUpConstraints()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        let subviews = [
            collectionView,
            activityIndicationView
        ]

        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpViews() {
        collectionView.backgroundColor = .white
    }

    private func setUpConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: size,
            subitem: item, count: 1
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.interGroupSpacing = 5

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - loading UI
extension TodayView {
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }

    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        activityIndicationView.stopAnimating()
    }
}
