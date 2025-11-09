//
//  ForgotPasswordViewController.swift
//  TheraSync
//
//  Created by user@54 on 05/11/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendOTPButton: UIButton!
    
    // MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
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
        emailLabel.textColor = .white
        backButton.tintColor = .white
        
        emailTextField.backgroundColor = .white
        emailTextField.borderStyle = .none
        emailTextField.layer.cornerRadius = 26
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        sendOTPButton.backgroundColor = .systemBlue
        sendOTPButton.setTitleColor(.white, for: .normal)
        sendOTPButton.layer.cornerRadius = 26
        sendOTPButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }

    // MARK: - Actions
    @IBAction func sendOTPButtonTapped(_ sender: UIButton) {
        print("Send OTP Tapped")
        
        // 1. Get the *current* storyboard
        guard let storyboard = self.storyboard else {
            print("Error: Could not find the storyboard.")
            return
        }
        
        // 2. Instantiate the VC using its "Storyboard ID"
        if let otpVC = storyboard.instantiateViewController(withIdentifier: "EnterOTPViewController") as? EnterOTPViewController {
            // 3. Present it
            otpVC.modalPresentationStyle = .fullScreen
            self.present(otpVC, animated: true, completion: nil)
        } else {
            print("Error: Could not find a VC with Storyboard ID 'EnterOTPViewController' in this storyboard.")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        print("Back Tapped")
        
        // --- THIS IS THE FIX ---
        // This dismisses this screen and goes back to the
        // Login screen that presented it.
        self.dismiss(animated: true, completion: nil)
    }
}
