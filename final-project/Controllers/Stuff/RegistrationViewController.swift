//
//  RegistrationViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//


import UIKit

class RegistrationViewController: UIViewController {
    private let authService = UserAuthService()
    
    private let usernameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        usernameField.placeholder = "Username"
        emailField.placeholder = "Email"
        emailField.keyboardType = .emailAddress
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [usernameField, emailField, passwordField, registerButton])
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
    
    @objc private func registerTapped() {
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text else { return }
        
        authService.register(username: username, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("Registration Success: \(message)")
                case .failure(let error):
                    print("Registration Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
