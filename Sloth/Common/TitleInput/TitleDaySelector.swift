//
//  TitleDaySelector.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class CustomCollectionView: UICollectionView {
    var onBounds: (() -> ())?
    
    override var bounds: CGRect {
        didSet {
            onBounds?()
        }
    }
}

class TitleDaySelector: TitleInput {
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 43, height: 43)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        return layout
    }()
    
    private lazy var collectionView: CustomCollectionView = {
        let collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.onBounds = { [weak self] in
            self?.updateCollectionViewSpacing()
        }
        collectionView.register(PushNotiCycleCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PushNotiCycleCollectionViewCell.self))
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCollectionViewSpacing() {
        collectionViewFlowLayout.minimumLineSpacing = (collectionView.frame.width - 43 * 7) / 6
        collectionViewFlowLayout.minimumInteritemSpacing = (collectionView.frame.width - 43 * 7) / 6
    }
    
    private func initializeViews() {
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TitleDaySelector: UICollectionViewDelegate {
    
}

extension TitleDaySelector: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PushNotiCycle.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PushNotiCycleCollectionViewCell.self), for: indexPath) as? PushNotiCycleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.config(text: PushNotiCycle.allCases[indexPath.item].rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let items = collectionView.indexPathsForSelectedItems {
            print(items.forEach { print(PushNotiCycle.allCases[$0.item], terminator: " ") } )
        }
    }
}
