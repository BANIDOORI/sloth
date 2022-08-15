//
//  LectureListViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/23.
//

import UIKit
import SnapKit
import Combine

final class LectureListViewController: UIViewController {
    weak var navigator: LectureListNavigatorDelegate?

    enum Section: String, Hashable {
        case ing = "진행중인 강의"
        case will = "예정된 강의"
        case done = "지난 강의"
    }

    enum Item: Hashable {
        case ingLesson(Lesson)
        case willLesson(Lesson)
        case doneLesson(Lesson)
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    private lazy var lectureListView = LectureListView()
    private let viewModel: LectureListViewModel
    private var bindings = Set<AnyCancellable>()
    private var dataSource: DataSource!

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setImage(.actionPlus, for: .normal)
        button.addTarget(
            self,
            action: #selector(handleRegisterButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(.actionBell, for: .normal)
        button.addTarget(
            self,
            action: #selector(handleNotificationButtonTapped),
            for: .touchUpInside
        )
        return button
    }()

    init(viewModel: LectureListViewModel = LectureListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = lectureListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUpCollectionView()
        configureDataSource()
        setUpBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrySearch()
    }

    private func setUpCollectionView() {
        lectureListView.collectionView.register(
            LectoureListCollectionCell.self,
            forCellWithReuseIdentifier: LectoureListCollectionCell.identifier
        )

        lectureListView.collectionView.register(
            LectureListSectionHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: LectureListSectionHeaderCell.identifier
        )
    }

    private func setUpBindings() {
        func bindViewToViewModel() {
            viewModel.search()
        }

        func bindViewModelToView() {
            viewModel.$lessons
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)

            let stateValueHandler: (LectureListViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.lectureListView.startLoading()
                case .finishedLoading:
                    self?.lectureListView.finishLoading()
                case .error(let error):
                    self?.lectureListView.finishLoading()
                    self?.showError(error)
                }
            }

            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }

        bindViewToViewModel()
        bindViewModelToView()
    }

    private func showError(_ error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        let alertAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)

        present(
            alertController,
            animated: true,
            completion: nil
        )
    }

    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.ing, .will, .done])

        let ing = viewModel.lessons
            .filter{ $0.untilTodayFinished ?? true }
            .map{ Item.ingLesson($0) }
        snapshot.appendItems(ing, toSection: .ing)

        let will = viewModel.lessons
            .filter{ $0.untilTodayFinished ?? true }
            .map{ Item.willLesson($0) }
        snapshot.appendItems(will, toSection: .will)

        let done = viewModel.lessons
            .filter{ $0.untilTodayFinished ?? true }
            .map{ Item.doneLesson($0) }
        snapshot.appendItems(done, toSection: .done)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDataSource

extension LectureListViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: lectureListView.collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                switch item {
                case .ingLesson(let lesson):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: LectoureListCollectionCell.identifier,
                        for: indexPath
                    ) as? LectoureListCollectionCell
                    cell?.viewModel = LectoureListCollectionCellViewModel(lesson: lesson, isDone: false)
                    return cell
                case .willLesson(let lesson):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: LectoureListCollectionCell.identifier,
                        for: indexPath
                    ) as? LectoureListCollectionCell
                    cell?.viewModel = LectoureListCollectionCellViewModel(lesson: lesson, isDone: false)
                    return cell
                case .doneLesson(let lesson):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: LectoureListCollectionCell.identifier,
                        for: indexPath
                    ) as? LectoureListCollectionCell
                    cell?.viewModel = LectoureListCollectionCellViewModel(lesson: lesson, isDone: true)
                    return cell
                }
            })

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: LectureListSectionHeaderCell.identifier,
                for: indexPath
            ) as? LectureListSectionHeaderCell
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]

            // NOTE: 수정 필요
            view?.titleLabel.text = "\(section.rawValue) \(collectionView.numberOfItems(inSection: indexPath.section))개"
            return view
        }
    }
}

// MARK: - navigation
extension LectureListViewController {
    private func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.tintColor = .gray600

        let stackView = UIStackView()
        stackView.addArrangedSubviews(views: [registerButton, notificationButton])
        stackView.spacing = 16

        let rightBarButton = UIBarButtonItem(customView: stackView)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }

    @objc private func handleRegisterButtonTapped() {
        navigator?.showLectureRegister()
    }

    @objc private func handleNotificationButtonTapped() {
        print(#function)
    }
}
