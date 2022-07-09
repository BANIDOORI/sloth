//
//  TodayViewController.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit
import Combine
import SnapKit

final class TodayViewController: UIViewController {
    enum Section: Hashable {
        case header
        case will
        case done
    }

    enum Item: Hashable {
        case headerInformation
        case willLesson(Lesson)
        case doneLesson(Lesson)
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    private lazy var todayView = TodayView()
    private let viewModel: TodayViewModel
    private var bindings = Set<AnyCancellable>()
    private var dataSource: DataSource!
    weak var navigator: TodayViewNavigatorDelegate?

    init(viewModel: TodayViewModel = TodayViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = todayView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        configureDataSource()
        setUpBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrySearch()
    }

    private func setUpCollectionView() {
        todayView.collectionView.register(
            TodayLessonHeaderCell.self,
            forCellWithReuseIdentifier: TodayLessonHeaderCell.identifier
        )
        todayView.collectionView.register(
            TodayLessonCollectionViewCell.self,
            forCellWithReuseIdentifier: TodayLessonCollectionViewCell.identifier
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

            let stateValueHandler: (TodayViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.todayView.startLoading()
                case .finishedLoading:
                    self?.todayView.finishLoading()
                case .error(let error):
                    self?.todayView.finishLoading()
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
        snapshot.appendSections([.header, .will, .done])
        snapshot.appendItems([.headerInformation], toSection: .header)

        let done = viewModel.lessons
            .filter{ $0.untilTodayFinished ?? true }
            .map{ Item.doneLesson($0) }
        snapshot.appendItems(done, toSection: .done)

        let will = viewModel.lessons
            .filter{ !($0.untilTodayFinished ?? true) }
            .map{ Item.willLesson($0) }
        snapshot.appendItems(will, toSection: .will)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDataSource

extension TodayViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: todayView.collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                switch item {
                case .headerInformation:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TodayLessonHeaderCell.identifier,
                        for: indexPath
                    ) as? TodayLessonHeaderCell
                    cell?.viewModel = TodayLessonHeaderViewModel(
                        message: "시작이 반인데...\n너 설마 아직도\n시작 안했어?",
                        slothImage: UIImage.Sloth.todayLose
                    )
                    return cell
                case .willLesson(let lesson):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TodayLessonCollectionViewCell.identifier,
                        for: indexPath
                    ) as? TodayLessonCollectionViewCell
                    cell?.viewModel = TodayLessonCollectionCellViewModel(lesson: lesson)
                    return cell
                case .doneLesson(let lesson):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TodayLessonCollectionViewCell.identifier,
                        for: indexPath
                    ) as? TodayLessonCollectionViewCell
                    cell?.viewModel = TodayLessonCollectionCellViewModel(lesson: lesson)
                    return cell
                }
            })
    }
}
