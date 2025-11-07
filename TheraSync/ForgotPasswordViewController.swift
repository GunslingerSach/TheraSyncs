//
//  ForgotPasswordViewController.swift
//  TheraSync
//
//  Created by user@54 on 05/11/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - Outlets
    // (Connect these from your storyboard)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendOTPButton: UIButton!
    
    // MARK: - Properties
    
    // Fixed typo: was "CAG_radientLayer"
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set up the gradient background
        setupBackground()
        
        // 2. Style the UI elements (since storyboard shows them as black/default)
        styleUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Make sure gradient resizes on layout changes (like rotation)
        gradientLayer.frame = view.bounds
    }

    // MARK: - UI Setup
    
    private func setupBackground() {
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.6]
        gradientLayer.frame = view.bounds
        
        // Add the gradient as the very first layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func styleUI() {
        // Style text and back button
        titleLabel.textColor = .white
        emailLabel.textColor = .white
        backButton.tintColor = .white
        
        // Style email field
        emailTextField.backgroundColor = .white
        emailTextField.borderStyle = .none
        emailTextField.layer.cornerRadius = 14 // Changed from 26 to match screenshot
        
        // Add padding to email field
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        // Style Send OTP button
        sendOTPButton.backgroundColor = .systemBlue
        sendOTPButton.setTitleColor(.white, for: .normal)
        sendOTPButton.layer.cornerRadius = 14 // Changed from 26 to match screenshot
        sendOTPButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }

    // MARK: - Actions
    // (Connect these from your storyboard)
    
    @IBAction func sendOTPButtonTapped(_ sender: UIButton) {
        print("Send OTP Tapped")
        
        // --- This code loads the next VC from the SAME storyboard ---
        
        // 1. Get the *current* storyboard
        guard let storyboard = self.storyboard else {
            print("Error: Could not find the storyboard.")
            return
        }
        
        // 2. Instantiate the VC using its "Storyboard ID"
        //    (You must set this ID in the Identity Inspector for your OTP screen)
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "EnterOTPViewController") as? EnterOTPViewController {
        
            // 3. Present it
            otpVC.modalPresentationStyle = .fullScreen
            self.present(otpVC, animated: true, completion: nil)
        } else {
            print("Error: Could not find a VC with Storyboard ID 'EnterOTPViewController' in this storyboard.")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        print("Back Tapped - Resetting to Login Screen")
        
        // --- This code will reset the app back to the Login screen ---
        
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
        // controller with the Login screen.
        
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
}
