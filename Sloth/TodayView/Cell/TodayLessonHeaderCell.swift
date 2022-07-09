//
//  TodayLessonHeaderCell.swift
//  Sloth
//
//  Created by user on 2022/07/05.
//

import UIKit
import Combine

final class TodayLessonHeaderCell: UICollectionViewCell {
    static let identifier = "TodayLessonHeaderCell"

    var viewModel: TodayLessonHeaderViewModel! {
        didSet { setUpViewModel() }
    }
    
    lazy var slothImageView = UIImageView()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 3
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubiews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubiews() {
        let subviews = [messageLabel, slothImageView]

        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setUpConstraints() {
        slothImageView.snp.makeConstraints {
            $0.width.height.equalTo(160)
            $0.top.equalToSuperview().inset(24)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        messageLabel.snp.makeConstraints {
            $0.centerY.equalTo(slothImageView.snp.centerY)
            $0.left.equalToSuperview().inset(20)
            $0.right.equalToSuperview().inset(18)
        }
    }

    private func setUpViewModel() {
        messageLabel.text = viewModel.message
        slothImageView.image = viewModel.slothImage
    }
}


final class TodayLessonHeaderViewModel {
    @Published var message: String? = ""
    @Published var slothImage: UIImage? = .none

//    private let message: String
//    private let slothImage: UIImage.Sloth

    init(message: String, slothImage: UIImage) {
        self.message = message
        self.slothImage = slothImage

//        setUpBindings()
    }

//    private func setUpBindings() {
//        message = message
//        slothImageView?.image = slothImage ?? .none
//    }
}
