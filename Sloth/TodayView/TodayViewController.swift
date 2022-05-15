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
    private typealias DataSource = UICollectionViewDiffableDataSource<TodayViewModel.Section, Lesson>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TodayViewModel.Section, Lesson>

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
        snapshot.appendSections([.done])
        snapshot.appendItems(viewModel.lessons)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDataSource

extension TodayViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: todayView.collectionView,
            cellProvider: { (collectionView, indexPath, lesson) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TodayLessonCollectionViewCell.identifier,
                    for: indexPath
                ) as? TodayLessonCollectionViewCell
                cell?.viewModel = TodayLessonCollectionCellViewModel(lesson: lesson)
                return cell
            })
    }
}
