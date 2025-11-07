//
//  EnterOTPViewController.swift
//  TheraSync
//
//  Created by user@54 on 06/11/25.
//

import UIKit

class EnterOTPViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    
    // Header
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // OTP Label
    @IBOutlet weak var enterOTPLabel: UILabel!
    
    // Text Fields
    @IBOutlet var otpTextFields: [UITextField]!
    
    // --- NEW ---
    // (Connect this to your new "Done" button)
    @IBOutlet weak var doneButton: UIButton!
    // -----------
    
    private let gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
        
        // Set delegates for all text fields
        for (index, textField) in otpTextFields.enumerated() {
            textField.delegate = self
            textField.tag = index
        }
        
        // --- NEW ---
        // Start with the "Done" button disabled
        doneButton.isEnabled = false
        doneButton.alpha = 0.5
        // -----------
        
        // Make the keyboard pop up immediately
        otpTextFields.first?.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - UI Setup
    
    private func setupBackground() {
        // (Same as before)
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.6]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func styleUI() {
        // (Same as before)
        titleLabel.textColor = .white
        backButton.tintColor = .white
        enterOTPLabel.textColor = .white
        
        for textField in otpTextFields {
            textField.layer.cornerRadius = 15
            textField.backgroundColor = .white
            textField.textAlignment = .center
            textField.font = .systemFont(ofSize: 24, weight: .bold)
            textField.keyboardType = .numberPad
        }
    }
    
    // MARK: - OTP Logic

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let fieldTag = textField.tag

        if newText.count > 1 {
            // User is trying to paste, only take the first character
            let firstChar = String(newText.prefix(1))
            textField.text = firstChar
            // Manually trigger the next field
            if fieldTag < 3 {
                otpTextFields[fieldTag + 1].becomeFirstResponder()
            }
            checkOTPCompletion() // Check if OTP is complete
            return false
        }
        
        if string.isEmpty {
            // --- User Tapped Backspace ---
            textField.text = "" // Clear current field
            if fieldTag > 0 {
                otpTextFields[fieldTag - 1].becomeFirstResponder()
            }
        } else {
            // --- User Tapped a Number ---
            textField.text = string // Set text to the new number
            if fieldTag < 3 {
                otpTextFields[fieldTag + 1].becomeFirstResponder()
            } else {
                // Last field was filled, hide keyboard
                textField.resignFirstResponder()
            }
        }
        
        // --- NEW ---
        // Check if we should enable the button *after* the change
        // We use a slight delay to let the text field update
        DispatchQueue.main.async {
            self.checkOTPCompletion()
        }
        // -----------
        
        return false // We manually set the text
    }
    
    // --- NEW ---
    private func checkOTPCompletion() {
        let otp = otpTextFields.map { $0.text ?? "" }.joined()
        
        if otp.count == 4 {
            // Enable the button
            doneButton.isEnabled = true
            doneButton.alpha = 1.0
        } else {
            // Disable the button
            doneButton.isEnabled = false
            doneButton.alpha = 0.5
        }
    }
    
    // --- NEW ---
    private func presentCreateNewPasswordScreen() {
        guard let storyboard = self.storyboard else {
            print("Error: Could not find the storyboard.")
            return
        }
        
        // (We will create this in Part 3)
        if let newPasswordVC = storyboard.instantiateViewController(withIdentifier: "CreateNewPasswordViewController") as? CreateNewPasswordViewController {
            newPasswordVC.modalPresentationStyle = .fullScreen
            self.present(newPasswordVC, animated: true, completion: nil)
        } else {
            print("Error: Could not find 'CreateNewPasswordViewController'. Make sure you set its Storyboard ID.")
        }
    }

    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Go back to the "Forgot Password" screen
        self.dismiss(animated: true, completion: nil)
    }
    
    // --- NEW ---
    // (Connect this to your "Done" button)
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let otp = otpTextFields.map { $0.text ?? "" }.joined()
        
        print("Verifying OTP: \(otp)")
        
        // ---
        // Here, you would make your *real* network call to verify the OTP.
        // For now, we will assume it's always successful.
        // ---
        
        // On success, present the next screen
        presentCreateNewPasswordScreen()
    }
    // -----------
}


