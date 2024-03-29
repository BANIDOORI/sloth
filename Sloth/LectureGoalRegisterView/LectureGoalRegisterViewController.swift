//
//  LectureGoalRegisterViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class LectureGoalRegisterViewController: UIViewController {
    weak var navigator: LectureGoalRegisterNavigator?
    
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
    
    // MARK: Lecture Start Date Properties
    
    private lazy var startDateToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(handleStartDoneTapped))
        toolBar.setItems([done], animated: true)
        return toolBar
    }()
    
    private lazy var lectureStartDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        picker.addTarget(self, action: #selector(handleStartDatePicker(_:)), for: .valueChanged)
        return picker
    }()
    
    private lazy var lectureStartDateField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "강의 시작일"
        field.placeholder = "\(Date().format())"
        field.isActionEnabled = false
        field.textField.inputAccessoryView = startDateToolBar
        field.textField.inputView = lectureStartDatePicker
        return field
    }()
    
    // MARK: Lecture End Date Properties
    
    private lazy var endDateToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(handleEndDoneTapped))
        toolBar.setItems([done], animated: true)
        return toolBar
    }()
    
    private lazy var lectureEndDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        picker.addTarget(self, action: #selector(handleEndDatePicker(_:)), for: .valueChanged)
        return picker
    }()
    
    private lazy var lectureEndDateField: TitleActionField = {
        let field = TitleActionField()
        field.titleText = "완강 목표일"
        field.placeholder = "\(Date().format())"
        field.isActionEnabled = false
        field.textField.inputAccessoryView = endDateToolBar
        field.textField.inputView = lectureEndDatePicker
        return field
    }()
    
    private lazy var lectureAmountField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 금액"
        field.placeholder = "예) 10,000원"
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var pushNotiCycleField: TitleDaySelector = {
        let input = TitleDaySelector()
        input.titleText = "푸쉬 알림 주기"
        return input
    }()
    
    private lazy var lectureResolutionField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "각오 한 마디 (선택)"
        field.placeholder = "최대 30자 까지 입력 가능합니다."
        field.keyboardType = .default
        return field
    }()
    
    private lazy var saveButton: ConfirmButton = {
        let button = ConfirmButton()
        button.setTitle("완료", for: .normal)
        button.addTarget(self, action: #selector(handleSaveButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    @objc private func handleStartDatePicker(_ sender: UIDatePicker) {
        print("Start Date Updated", sender.date.format())
    }
    
    @objc private func handleEndDatePicker(_ sender: UIDatePicker) {
        print("End Date Updated", sender.date.format())
    }
    
    @objc func handleStartDoneTapped() {
        lectureStartDateField.text = lectureStartDatePicker.date.format()
        self.view.endEditing(true)
    }
    
    @objc func handleEndDoneTapped() {
        lectureEndDateField.text = lectureEndDatePicker.date.format()
        self.view.endEditing(true)
    }
    
    @objc func handleSaveButtonTapped() {
        navigator?.showRegisterSummary()
    }
}
