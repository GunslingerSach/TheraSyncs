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
    
    // (Optional: for show/hide password buttons)
    @IBOutlet weak var newPasswordToggleButton: UIButton!
    @IBOutlet weak var confirmPasswordToggleButton: UIButton!

    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
        
        // Make passwords secure by default
        newPasswordField.isSecureTextEntry = false
        confirmPasswordField.isSecureTextEntry = true
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
        // --- Style Labels and Buttons ---
        titleLabel.textColor = .white
        backButton.tintColor = .white
        
        // --- Style Text Fields ---
        styleTextField(newPasswordField, placeholder: "New Password")
        styleTextField(confirmPasswordField, placeholder: "Confirm Password")
        
        // --- Style Toggle Buttons (Optional) ---
        // (Set the image to 'eye.slash' in storyboard)
        //newPasswordToggleButton.tintColor = .gray
        //confirmPasswordToggleButton.tintColor = .gray

        // --- Style Submit Button ---
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
        textField.isSecureTextEntry = true // Make it a password field
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        // (This assumes you have a container view for the right-side toggle button)
        // If not, you can set textField.rightView instead
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
            // TODO: Show an error message to the user
            return
        }
        
        guard newPassword == confirmPassword else {
            print("Error: Passwords do not match.")
            // TODO: Show an error message to the user
            return
        }
        
        // ---
        // 1. TODO: Add logic to save the newPassword to your server
        // ---
        
        
        // 2. On success, reset the app back to the Login screen.
        
        // --- ASSUMPTIONS (Confirm with your teammate!) ---
        let loginStoryboardName = "Login" // <-- Your teammate's storyboard *file* name
        let loginVCIdentifier = "LoginViewController" // <-- Your teammate's *Storyboard ID*
        
        // ---
        
        let storyboard = UIStoryboard(name: loginStoryboardName, bundle: nil)
        
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: loginVCIdentifier) as? UIViewController else {
            print("---")
            print("Error: Could not find '\(loginVCIdentifier)' in '\(loginStoryboardName).storyboard'.")
            print("This is OK if your teammate hasn't added their file yet. Your code is ready!")
            print("---")
            return
        }

        // --- The Clean Reset ---
        // This finds the main app window and replaces its root
        // controller with the Login screen. This is the correct
        // way to "log out" or "reset" the app flow.
        
        if let window = self.view.window {
            window.rootViewController = loginVC
            // Add a nice fade transition
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        } else {
            // Fallback (e.g., if window isn't available)
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    // (Optional: Connect these to your 'eye' buttons)
    @IBAction func toggleNewPasswordVisibility(_ sender: UIButton) {
        newPasswordField.isSecureTextEntry.toggle()
        let imageName = newPasswordField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func toggleConfirmPasswordVisibility(_ sender: UIButton) {
        confirmPasswordField.isSecureTextEntry.toggle()
        let imageName = confirmPasswordField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
