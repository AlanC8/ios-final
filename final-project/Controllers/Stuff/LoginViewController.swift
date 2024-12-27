//
//  LoginViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//


import UIKit

class LoginViewController: UIViewController {
    private let authService = UserAuthService()
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        emailField.placeholder = "Email"
        emailField.keyboardType = .emailAddress
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    @objc private func loginTapped() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("Email or password is empty")
            return
        }
        
        authService.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    print("Login Success: Token saved")
                    self.authService.saveToken(token) 
                    self.dismiss(animated: true, completion: nil)
                    
                case .failure(let error):
                    print("Login Error: \(error.localizedDescription)")
                    self.showErrorAlert(message: "Invalid email or password. Please try again.")
                }
            }
        }
    }

}
