//
//  LectureGoalRegisterViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class LectureGoalRegisterViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "완강 목표를 설정해보세요!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .gray600
        return label
    }()
    
    private var lectureStartDate: String = ""
    private lazy var lectureStartDateField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "강의 시작일"
        field.placeholder = "\(Date())"
        field.onAction = {
            self.handleStartDateButtonTapped()
        }
        return field
    }()
    
    private var lectureEndDate: String = ""
    private lazy var lectureEndDateField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "완강 목표일"
        field.placeholder = "\(Date())"
        field.onAction = {
            self.handleEndDateButtonTapped()
        }
        return field
    }()
    
    private lazy var lectureAmountField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 금액"
        field.placeholder = "예) 10,000원"
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var pushNotiCycleField: TitleInput = {
        let input = TitleInput()
        input.titleText = "푸쉬 알림 주기"
        input.containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return input
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 43, height: 43)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.isScrollEnabled = false
        collectionView.allowsMultipleSelection = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(PushNotiCycleCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PushNotiCycleCollectionViewCell.self))
        return collectionView
    }()
    
    private lazy var lectureResolutionField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "각오 한 마디 (선택)"
        field.placeholder = "최대 30자 까지 입력 가능합니다."
        field.keyboardType = .default
        return field
    }()
    
    private let saveButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        initializeViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewFlowLayout.minimumLineSpacing = (collectionView.frame.width - 43 * 7) / 6
        collectionViewFlowLayout.minimumInteritemSpacing = (collectionView.frame.width - 43 * 7) / 6
    }
    
    private func initializeViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(34)
            $0.centerX.bottom.equalToSuperview()
        }
        
        initializeTitleView()
        initializeFields()
    }
    
    private func setupNavigationBar() {
        title = "새로운 인강 등록"
        
        navigationController?.navigationBar.tintColor = .gray600
        navigationController?.navigationBar.backIndicatorImage = .back
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .back
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    private func initializeTitleView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(30, after: titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(34)
        }
    }
    
    private func initializeFields() {
        stackView.addArrangedSubviews(views: [
            lectureStartDateField,
            lectureEndDateField,
            lectureAmountField,
            pushNotiCycleField,
            lectureResolutionField,
            saveButton])
        lectureStartDateField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        lectureEndDateField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        lectureAmountField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        pushNotiCycleField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        lectureResolutionField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        saveButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    @objc private func handleStartDateButtonTapped() {
        print(#function)
    }
    
    @objc private func handleEndDateButtonTapped() {
        print(#function)
    }
}

extension LectureGoalRegisterViewController: UICollectionViewDelegate {
    
}

extension LectureGoalRegisterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PushNotiCycleCollectionViewCell.self), for: indexPath) as? PushNotiCycleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.config(text: PushNotiCycle.allCases[indexPath.item].rawValue)
        return cell
    }
}
