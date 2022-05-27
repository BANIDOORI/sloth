//
//  DependencyContainer.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit

class DependencyContainer {
    
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
    
    func makeLoginCoordinator(window: UIWindow) -> Coordinator {
        let router = InitNavRouter(window: window)
        
        let service = LoginService(
            kakaoSessionManager: kakaoSessionManager,
            appleSessionManager: appleSessionManager,
            networkManager: networkManager,
            requestMaker: requestMaker
        )
        let viewModel = LoginViewModel(service: service)
        let viewController = LoginViewController(viewModel: viewModel)
        
        let coordinator = LoginCoordinator(
            router: router,
            viewController: viewController
        )
        
        return coordinator
    }
    
}

