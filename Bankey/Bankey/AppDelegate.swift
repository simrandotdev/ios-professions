//
//  AppDelegate.swift
//  Bankey
//
//  Created by Simran Preet Singh Narang on 2023-10-18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        window?.rootViewController = loginViewController
        return true
    }
}


// MARK: - LoginViewControllerDelegate


extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("✅ Did Login")
        setRootViewController(onboardingContainerViewController)
//        window?.rootViewController = onboardingContainerViewController
    }
}


// MARK: - OnboardingContainerViewControllerDelegate


extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        dummyViewController.title = "Welcome"
        dummyViewController.view.backgroundColor = .systemBackground
        setRootViewController(UINavigationController(rootViewController: dummyViewController))
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}


// MARK: - LogoutDelegate


extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(LoginViewController())
    }
}
