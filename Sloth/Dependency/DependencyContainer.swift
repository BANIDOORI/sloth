//
//  DependencyContainer.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit

class DependencyContainer {
    typealias OnAction = () -> ()
    
    private let kakaoSessionManager: KakaoSessionManager
    private let googleSessionManager: GoogleSessiongManager
    private let appleSessionManager: AppleSessionMananger
    private let networkManager: NetworkManager
    private let urlProvider: URLProvider
    private let endpointProvider: EndpointProvider
    private let requestMaker: RequestMaker
    private let authStorageManager: StorageManager<LoginResponse>
    
    init(window: UIWindow?) {
        networkManager = NetworkManagerImp()
        urlProvider = URLProvider(
            scheme: "https",
            host: "nanagong-api.com",
            path: "",
            login: "/api/oauth/login",
            logout: "/api/logout")
        endpointProvider = EndpointProvider(urlProvider: urlProvider)
        requestMaker = RequestMaker(endpointProvider: endpointProvider)
        
        kakaoSessionManager = KakaoSessionManager()
        kakaoSessionManager.initSDK()
        googleSessionManager = GoogleSessiongManager()
        appleSessionManager = AppleSessionMananger(window: window)
        authStorageManager = StorageManager<LoginResponse>(type: .token)
    }

    func makeMainCoordinator(window: UIWindow) -> Coordinator {
        let storageManager = StorageManager<LoginResponse>(type: .token)
        guard storageManager.load() != nil else {
            let startCoordinator = makeStartCoordinator(window: window)
            return startCoordinator
        }
        let router = InitNavRouter(window: window)
        return makeMainCoordinator(router: router)
    }
    
    func makeMainCoordinator(router: InitNavRouter) -> Coordinator {
        let viewModel = MainViewModel()
        
        let todayViewControllerFactory: () -> (TodayViewController) = {
            self.makeTodayViewControllerFactory(navigator: viewModel)
        }
        
        let lectureListViewControllerFactory: () -> (LectureListViewController) = {
            self.makeLectureListViewControllerFactory(navigator: viewModel)
        }
        
        let myPageViewControllerFactory: () -> (MyPageViewController) = {
            self.makeMyPageViewControllerFactory()
        }
        
        let lectureRegisterCoordinatorFactory: () -> (Coordinator) = {
            self.makeLectureInformationRegisterCoordinator(navigationController: router.navigationController)
        }
        
        let lectureDetailCoordinatorFactory: () -> Coordinator = {
            self.makeLectureDetailCoordinator(navigationController: router.navigationController)
        }
        
        let viewController = MainViewController(
            viewModel: viewModel,
            todayViewControllerFactory: todayViewControllerFactory,
            lectureListViewControllerFactory: lectureListViewControllerFactory,
            myPageViewControllerFactory: myPageViewControllerFactory
        )
        
        let coordinator = MainViewCoordinator(
            router: router,
            viewController: viewController,
            lectureRegisterCoordinatorFactory: lectureRegisterCoordinatorFactory,
            lectureDetailCoordinatorFactory: lectureDetailCoordinatorFactory
        )
        
        viewModel.navigator = coordinator
        
        return coordinator
    }
    
    func makeMyPageCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = MyPageViewController()
        
        let coordinator = MyPageCoordinator(
            router: router,
            viewController: viewController)
        return coordinator
    }
    
    func makeStartCoordinator(window: UIWindow) -> Coordinator {
        let router = InitNavRouter(window: window)
        
        let viewController = StartViewController()
        let loginCoordinatorFactory: (OnAction?) -> (Coordinator) = { onAction in
            self.makeLoginCoordinator(
                parentViewController: viewController,
                onSuccessActionToLogin: onAction
            )
        }
        
        let informationAgreementCoordinatorFactory: () -> (Coordinator) = {
            self.makeInformationAgreementCoordinator(parentViewController: viewController)
        }
        
        let mainCoordinatorFactory: () -> (Coordinator) = {
            return self.makeMainCoordinator(router: router)
        }
        
        let coordinator = StartCoordinator(
            router: router,
            viewController: viewController,
            loginCoordinatorFactory: loginCoordinatorFactory,
            informationAgreementCoordinatorFactory: informationAgreementCoordinatorFactory,
            mainCoordinatorFactory: mainCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeLoginCoordinator(parentViewController: UIViewController,
                              onSuccessActionToLogin: OnAction?) -> Coordinator {
        let router = PopOverRouter(parentViewController: parentViewController)
        
        let service = LoginService(
            kakaoSessionManager: kakaoSessionManager,
            appleSessionManager: appleSessionManager,
            networkManager: networkManager,
            requestMaker: requestMaker,
            authStorageManager: authStorageManager
        )
        let viewModel = LoginViewModel(service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        
        let informationAgreementCoordinatorFactory: () -> (Coordinator) = {
            self.makeInformationAgreementCoordinator(parentViewController: viewController)
        }
        
        let coordinator = LoginCoordinator(
            router: router,
            viewController: viewController,
            informationAgreementCoordinatorFactory: informationAgreementCoordinatorFactory,
            onSuccessAction: onSuccessActionToLogin
        )
        
        viewModel.navigator = coordinator
        
        return coordinator
    }
    
    
    func makeInformationAgreementCoordinator(parentViewController: UIViewController) -> Coordinator {
        let router = PopOverRouter(parentViewController: parentViewController)
        
        let viewController = InformationAgreementViewController()
        let coordinator = InformationAgreementCoordinator(
            router: router,
            viewController: viewController
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeLectureInformationRegisterCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewModel = LectureInformationRegisterViewModel()
        let viewController = LectureInformationRegisterViewController(viewModel: viewModel)
        
        let lectureGoalRegisterCoordinatorFactory: () -> (Coordinator) = {
            self.makeLectureGoalRegisterCoordinator(navigationController: navigationController)
        }
        
        let coordinator = LectureInformationRegisterCoordinator(
            router: router,
            viewController: viewController,
            lectureGoalRegisterCoordinatorFactory: lectureGoalRegisterCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeLectureGoalRegisterCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = LectureGoalRegisterViewController()
        
        let lectureRegisterSummaryCoordinator: () -> (Coordinator) = {
            self.makeLectureRegisterSummaryCoordinatorFactory(navigationController: navigationController)
        }
        
        let coordinator = LectureGoalRegisterCoordinator(
            router: router,
            viewController: viewController, lectureRegisteSummaryCoordinatorFactory: lectureRegisterSummaryCoordinator
            )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeLectureDetailCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = LectureDetailViewController()
        
        let lectureEditCoordinatorFactory = {
            self.makeLectureEditCoordinatorFactory(navigationController: navigationController)
        }
        
        let coordinator = LectureDetailCoordinator(
            router: router,
            viewController: viewController,
            lectureEditCoordinatorFactory: lectureEditCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeTodayViewControllerFactory(navigator: TodayViewNavigator?) -> TodayViewController {
        let viewController = TodayViewController()
        viewController.navigator = navigator
        return viewController
    }
    
    func makeLectureListViewControllerFactory(navigator: LectureListNavigator?) -> LectureListViewController {
        let viewController = LectureListViewController()
        viewController.navigator = navigator
        return viewController
    }
    
    func makeMyPageViewControllerFactory() -> MyPageViewController {
        let viewController = MyPageViewController()
        return viewController
    }
    
    func makeLectureRegisterSummaryCoordinatorFactory(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = LectureRegisterSummaryViewController()
        
        let coordinator = LectureRegisterSummaryCoordinator(router: router, viewController: viewController)
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeLectureEditCoordinatorFactory(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = LectureEditViewController()
        
        let coordinator = LectureEditCoordinator(router: router, viewController: viewController)
        
        viewController.navigator = coordinator
        
        return coordinator
    }
}

