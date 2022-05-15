//
//  TodayView.swift
//  Sloth
//
//  Created by Eojin on 2022/05/14.
//

import UIKit
import SnapKit

final class TodayView: UIView {
    lazy var slothImageView = UIImageView()
    lazy var messageLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)

    init() {
        super.init(frame: .zero)
        backgroundColor = .brown
        addSubviews()
        setUpConstraints()
        setUpViews()

        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        messageLabel.numberOfLines = 3
        messageLabel.text = "시작이 반인데...\n너 설마 아직도\n시작 안했어?"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        let subviews = [
            messageLabel,
            slothImageView,
            collectionView,
            activityIndicationView
        ]

        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpViews() {
        slothImageView.backgroundColor = .yellow
        collectionView.backgroundColor = .white
    }

    private func setUpConstraints() {
        slothImageView.snp.makeConstraints {
            $0.width.height.equalTo(160)
            $0.top.equalToSuperview().inset(24)
            $0.right.equalToSuperview().inset(20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.centerY.equalTo(slothImageView.snp.centerY)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(18)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(slothImageView.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
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
