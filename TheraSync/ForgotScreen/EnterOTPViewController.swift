//
//  EnterOTPViewController.swift
//  TheraSync
//
//  Created by user@54 on 06/11/25.
//

import UIKit

class EnterOTPViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var enterOTPLabel: UILabel!
    
    // Connect all 4 text fields to this *one* outlet collection
    @IBOutlet var otpTextFields: [UITextField]!
    
    @IBOutlet weak var doneButton: UIButton!
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
        setupTextFields()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // Make the first text field active when the view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        otpTextFields.first?.becomeFirstResponder()
    }

    // MARK: - Setup
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
        enterOTPLabel.textColor = .black // Or .white, depending on your design
        
        doneButton.backgroundColor = .systemBlue
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.layer.cornerRadius = 26
        doneButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        // Disable done button until 4 digits are entered
        doneButton.isEnabled = false
        doneButton.alpha = 0.5
        
        // Style the text fields
        for textField in otpTextFields {
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 10
            textField.textAlignment = .center
            textField.font = .systemFont(ofSize: 24, weight: .bold)
            textField.keyboardType = .numberPad
        }
    }
    
    private func setupTextFields() {
        // Set the delegate for all text fields
        for (index, textField) in otpTextFields.enumerated() {
            textField.delegate = self
            textField.tag = index // Use the tag to know which field we're in
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // If the user is typing (not deleting)
        if !string.isEmpty {
            textField.text = string
            let nextTag = textField.tag + 1
            
            // If there's a next text field, move to it
            if let nextResponder = view.viewWithTag(nextTag) as? UITextField {
                nextResponder.becomeFirstResponder()
            } else {
                // Otherwise, resign (which will check if Done should be enabled)
                textField.resignFirstResponder()
            }
            // Manually call our check function
            textFieldDidChangeSelection(textField)
            return false // We manually set the text
        }
        
        // If the user is deleting
        if string.isEmpty {
            textField.text = ""
            let prevTag = textField.tag - 1
            
            // If there's a previous text field, move to it
            if let prevResponder = view.viewWithTag(prevTag) as? UITextField {
                prevResponder.becomeFirstResponder()
            }
            // Manually call our check function
            textFieldDidChangeSelection(textField)
        }
        
        return true
    }

    // This gets called every time the selection changes
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkDoneButtonStatus()
    }
    
    func checkDoneButtonStatus() {
        // Check if all text fields are filled
        let allFilled = otpTextFields.allSatisfy { $0.text?.isEmpty == false }
        
        doneButton.isEnabled = allFilled
        doneButton.alpha = allFilled ? 1.0 : 0.5
    }

    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Go back to the Forgot Password screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let otp = otpTextFields.map { $0.text ?? "" }.joined()
        print("Verifying OTP: \(otp)")
        
        guard let storyboard = self.storyboard else { return }
        
        if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateNewPasswordViewController") as? CreateNewPasswordViewController {
            createVC.modalPresentationStyle = .fullScreen
            self.present(createVC, animated: true, completion: nil)
        }
    }
}
