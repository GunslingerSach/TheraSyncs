//
//  CreateNewPasswordViewController.swift
//  TheraSync
//
//  Created by user@54 on 07/11/25.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {

    // MARK: - Outlets
    
    // (Connect these from your storyboard)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // (We've removed the outlets for the "eye" buttons)

    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
        
        // Make passwords visible (as requested)
        newPasswordField.isSecureTextEntry = false
        confirmPasswordField.isSecureTextEntry = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - UI Setup
    
    private func setupBackground() {
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.6]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func styleUI() {
        titleLabel.textColor = .white
        backButton.tintColor = .white
        
        styleTextField(newPasswordField, placeholder: "New Password")
        styleTextField(confirmPasswordField, placeholder: "Confirm Password")

        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 14
        submitButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    // Helper function to style text fields
    private func styleTextField(_ textField: UITextField, placeholder: String) {
        textField.backgroundColor = .white
        textField.borderStyle = .none
        textField.layer.cornerRadius = 14
        textField.placeholder = placeholder
        textField.isSecureTextEntry = false // Make it a regular text field
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }

    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Go back to the OTP screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        print("Submit New Password Tapped")
        
        guard let newPassword = newPasswordField.text, !newPassword.isEmpty,
              let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty else {
            print("Error: Fields cannot be empty.")
            return
        }
        
        guard newPassword == confirmPassword else {
            print("Error: Passwords do not match.")
            return
        }
        
        // 1. TODO: Add logic to save the newPassword
        
        
        // 2. On success, reset the app back to the Login screen.
        
        // --- THIS IS THE FINAL FIX ---
        // We use the file names we found from your screenshot.
        
        let loginStoryboardName = "LoginViewController" // The .storyboard file
        let loginVCIdentifier = "LoginViewController"   // The Storyboard ID
        
        // ---
        
        let storyboard = UIStoryboard(name: loginStoryboardName, bundle: nil)
        
        // Cast to LoginViewController to fix the warning
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: loginVCIdentifier) as? LoginViewController else {
            print("---")
            print("Error: Could not find '\(loginVCIdentifier)' in '\(loginStoryboardName).storyboard'.")
            print("Check that the Storyboard ID is set in your teammate's storyboard file.")
            print("---")
            return
        }

        // --- The Clean Reset ---
        if let window = self.view.window {
            window.rootViewController = loginVC
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        } else {
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
// (All "eye" button actions have been removed)
}
