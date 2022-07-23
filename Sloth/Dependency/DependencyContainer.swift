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
    
    func makeMainCoordinator(window: UIWindow) -> Coordinator {
        let router = InitNavRouter(window: window)
        
        let viewController = MainViewController()
        
        let myPageCoordinatorFactory: () -> Coordinator = {
            self.makeMyPageCoordinator(navigationController: router.navigationController)
        }
        
        let coordinator = MainViewCoordinator(
            router: router,
            viewController: viewController,
            myPageCoordinatorFactory: myPageCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
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
        
        let lectureListCoordinatorFactory: () -> (Coordinator) = {
            self.makeLectureListCoordinator(navigationController: router.navigationController)
        }
        
        let coordinator = StartCoordinator(
            router: router,
            viewController: viewController,
            loginCoordinatorFactory: loginCoordinatorFactory,
            informationAgreementCoordinatorFactory: informationAgreementCoordinatorFactory,
            lectureListCoordinatorFactory: lectureListCoordinatorFactory
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
    
    func makeLectureListCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        let viewController = LectureListViewController()
        
        let lectureRegisterCoordinatorFactory: () -> (Coordinator) = {
            self.makeLectureInformationRegisterCoordinator(navigationController: navigationController)
        }
        
        let coordinator = LectureListCoordinator(
            router: router,
            viewController: viewController,
            lectureRegisterCoordinatorFactory: lectureRegisterCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
}

