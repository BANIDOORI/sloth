//
//  LectureInformationRegisterViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/11.
//

import UIKit

final class LectureInformationRegisterViewController: UIViewController {
    weak var navigator: LectureInformationRegisterNavigator?
    
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
        label.text = "어떤 강의를 들으시나요?"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .gray600
        return label
    }()
    
    private var lectureName: String = ""
    private let lectureNameField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 이름"
        field.placeholder = "수강할 인강 이름을 입력하세요."
        field.keyboardType = .default
        return field
    }()
    
    private var lectureCount: String = ""
    private let lectureCountField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 개수"
        field.placeholder = "전체 강의 개수를 입력하세요."
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var lectureCategoryField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "카테고리"
        field.placeholder = "인강 카테고리를 선택하세요."
        field.onAction = { [weak self] in
            self?.handleCategoryButtonTapped()
        }
        return field
    }()
    
    private lazy var lectureSiteField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "강의 사이트"
        field.placeholder = "강의 사이트를 선택하세요."
        field.onAction = { [weak self] in
            self?.handleLectureSiteButtonTapped()
        }
        return field
    }()
    
    private lazy var nextButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(handleNextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: LectureInformationRegisterViewBinder
    
    init(viewModel: LectureInformationRegisterViewBinder) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        initializeViews()
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
        stackView.addArrangedSubview(lectureNameField)
        lectureNameField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        stackView.addArrangedSubview(lectureCountField)
        lectureCountField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        stackView.addArrangedSubview(lectureCategoryField)
        lectureCategoryField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        stackView.addArrangedSubview(lectureSiteField)
        stackView.setCustomSpacing(54, after: lectureSiteField)
        lectureSiteField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
        
        stackView.addArrangedSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    @objc private func handleCategoryButtonTapped() {
        let lectureCategories = LectureCategory.allCases
        presentActionSheet(
            title: nil,
            message: nil,
            actionTitles: lectureCategories.map { $0.rawValue },
            cancelTitle: "취소") { index in
                print("\(lectureCategories[index])")
            } cancelAction: {
                print("취소")
            }
    }
    
    @objc private func handleLectureSiteButtonTapped() {
        let lectureSites = LectureSite.allCases
        presentActionSheet(
            title: nil,
            message: nil,
            actionTitles: lectureSites.map { $0.rawValue },
            cancelTitle: "취소") { index in
                if lectureSites[index] == .userInput {
                    self.lectureSiteField.snp.updateConstraints {
                        $0.height.equalTo(86 + 56)
                    }
                    self.lectureSiteField.showDirectInputField()
                }
            } cancelAction: {
                print("취소")
            }
    }
    
    @objc private func handleNextButtonTapped() {
        navigator?.showLectureGoalRegister()
    }
}
