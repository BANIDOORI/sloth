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
    
    init(window: UIWindow?) {
        networkManager = NetworkManagerImp()
        urlProvider = URLProvider(
            scheme: "https",
            host: "slothbackend.hopto.org",
            path: "",
            login: "/api/oauth/login",
            logout: "/api/logout")
        endpointProvider = EndpointProvider(urlProvider: urlProvider)
        requestMaker = RequestMaker(endpointProvider: endpointProvider)
        
        kakaoSessionManager = KakaoSessionManager()
        kakaoSessionManager.initSDK()
        googleSessionManager = GoogleSessiongManager()
        appleSessionManager = AppleSessionMananger(window: window)
    }
    
    func makeMainCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
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
            self.makeLectureInformationRegisterCoordinator(navigationController: navigationController)
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
            lectureRegisterCoordinatorFactory: lectureRegisterCoordinatorFactory
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
            self.makeMainCoordinator(navigationController: router.navigationController)
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
            requestMaker: requestMaker
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
        
        let coordinator = LectureGoalRegisterCoordinator(router: router, viewController: viewController)
        
        return coordinator
    }
    
    func makeTodayViewControllerFactory(navigator: TodayViewNavigatorDelegate?) -> TodayViewController {
        let viewController = TodayViewController()
        viewController.navigator = navigator
        return viewController
    }
    
    func makeLectureListViewControllerFactory(navigator: LectureListNavigatorDelegate?) -> LectureListViewController {
        let viewController = LectureListViewController()
        viewController.navigator = navigator
        return viewController
    }
    
    func makeMyPageViewControllerFactory() -> MyPageViewController {
        let viewController = MyPageViewController()
        return viewController
    }
}

