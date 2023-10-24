//
//  LoginViewController.swift
//  Bankey
//
//  Created by Simran Preet Singh Narang on 2023-10-18.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let bankeyLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton()
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    // Local properties to access username and password text fields from `LoginView` conveniently
    var username: String? {
        get {
            return loginView.usernameTextField.text
        }
        set {
            loginView.usernameTextField.text = newValue
        }
    }
    
    var password: String? {
        get {
            return loginView.passwordTextField.text
        }
        set {
            loginView.passwordTextField.text = newValue
        }
    }
    
    var errorMessage: String? {
        get {
            return errorMessageLabel.text
        }
        set {
            errorMessageLabel.isHidden = newValue == nil || newValue == ""
            errorMessageLabel.text = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}


// MARK: - UI style and layout


extension LoginViewController {
    private func style() {
        
        // `bankeyLabel` styling
        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        bankeyLabel.textAlignment = .center
        bankeyLabel.font = .systemFont(ofSize: 48, weight: .heavy)
        bankeyLabel.text = "Bankey"
        
        // `loginView` styling
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // `signInButton` styling
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        // `errorLabel` styling
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(bankeyLabel)
        
        // `loginView` constraints
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // `signInButton` constraints
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2)
        ])
        
        // `errorMessageLabel` constraints
        NSLayoutConstraint.activate([
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2)
        ])
        
        // `bankeyLabel` constraints
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: bankeyLabel.bottomAnchor, multiplier: 4),
            bankeyLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            bankeyLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}


// MARK: - Actions


extension LoginViewController {
    
    @objc func signInTapped() {
        // if `errorMessageLabel` is visible before, lets hide it first
        errorMessage = nil
        login()
    }
    
    private func login() {
        guard let username, let password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank.")
            return
        }
        
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            signInButton.configuration?.showsActivityIndicator = false
            self.username = ""
            self.password = ""
        } else {
            configureView(withMessage: "Incorrect username / password.")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
