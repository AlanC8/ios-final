//
//  ProfileViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let themeLabel = UILabel()
    private let themeSegmentedControl = UISegmentedControl(items: ["Light", "Dark", "System"])
    private let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchUserProfile()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        nameLabel.text = "Loading Name..."
        
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textAlignment = .center
        emailLabel.textColor = .gray
        emailLabel.text = "Loading Email..."
        
        themeLabel.text = "Theme"
        themeLabel.font = UIFont.systemFont(ofSize: 16)
        themeLabel.textColor = .darkGray
        
        themeSegmentedControl.selectedSegmentIndex = 2
        themeSegmentedControl.addTarget(self, action: #selector(themeSegmentedControlChanged), for: .valueChanged)
        
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = UIColor.systemGray5
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(themeLabel)
        view.addSubview(themeSegmentedControl)
        view.addSubview(logoutButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            themeLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 32),
            themeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            themeSegmentedControl.topAnchor.constraint(equalTo: themeLabel.bottomAnchor, constant: 8),
            themeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            themeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            logoutButton.topAnchor.constraint(equalTo: themeSegmentedControl.bottomAnchor, constant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func fetchUserProfile() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let userName = "Alan Abzalhanuly"
            let userEmail = "alan@example.com"
            
            self?.nameLabel.text = userName
            self?.emailLabel.text = userEmail
            self?.profileImageView.image = UIImage(named: "profile_picture")
        }
    }
    
    @objc private func themeSegmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            overrideUserInterfaceStyle = .light
        case 1:
            overrideUserInterfaceStyle = .dark
        case 2:
            overrideUserInterfaceStyle = .unspecified
        default:
            break
        }
        print("Theme changed to \(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "Unknown")")
    }
    
    @objc private func logoutTapped() {
        let authService = UserAuthService()
        authService.logout()
        
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
