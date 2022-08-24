//
//  LectureEditViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

final class LectureEditViewController: UIViewController {
    weak var navigator: LectureEditNavigator?
    
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
    
    private let fieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()
    
    private let lectureNameField: TitleTextField = {
        let field = TitleTextField()
        field.titleText = "강의 이름"
        field.placeholder = "수강할 인강 이름을 입력하세요."
        field.keyboardType = .default
        return field
    }()
    
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
        
        stackView.addArrangedSubviews(views: [fieldStackView, saveButton])
        saveButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        initializeFields()
    }
    
    private func initializeFields() {
        fieldStackView.addArrangedSubviews(views: [
            lectureNameField,
            lectureCountField,
            lectureCategoryField,
            lectureSiteField,
            lectureStartDateField,
            lectureEndDateField,
            lectureAmountField,
            pushNotiCycleField,
            lectureResolutionField])
        
        lectureStartDateField.snp.makeConstraints {
            $0.height.equalTo(86)
        }
    }
    
    private func setupNavigationBar() {
        title = "강의 정보 수정"
        
        navigationController?.navigationBar.tintColor = .gray600
        navigationController?.navigationBar.backIndicatorImage = .back
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .back
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    private func handleCategoryButtonTapped() {
        
    }
    
    private func handleLectureSiteButtonTapped() {
        
    }
    
    
    @objc private func handleStartDoneTapped() {
        
    }
    
    @objc private func handleStartDatePicker(_ sender: UIDatePicker) {
        print("Start Date Updated", sender.date.format())
    }
    
    
    @objc private func handleEndDoneTapped() {
        
    }
    
    @objc private func handleEndDatePicker(_ sender: UIDatePicker) {
        print("End Date Updated", sender.date.format())
    }
    
    @objc func handleSaveButtonTapped() {
        navigator?.close()
    }
    
}
