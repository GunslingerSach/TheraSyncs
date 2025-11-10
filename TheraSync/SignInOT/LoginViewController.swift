//
//  ViewController.swift
//  SignInOT
//
//  Created by Alishri Poddar on 02/11/25.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckbox()
        setupStyling()
    }
    
    func setupStyling() {
        // We explicitly set the text visibility here
        emailTextField.isSecureTextEntry = false
        passwordTextField.isSecureTextEntry = true
        
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        loginButton.layer.cornerRadius = 26
        styleOutlineButton(appleSignInButton)
        styleOutlineButton(googleSignInButton)
    }
    
    func styleTextField(_ textField: UITextField) {
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 25
            textField.layer.borderWidth = 0
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOpacity = 0.1
            textField.layer.shadowOffset = CGSize(width: 0, height: 4)
            textField.layer.shadowRadius = 5
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
    
    func styleOutlineButton(_ button: UIButton) {
            button.backgroundColor = .white
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray4.cgColor
        }
    
    
    // Configures the checkbox button's images
    func setupCheckbox() {
        termsButton.setImage(UIImage(systemName: "square"), for: .normal)
        termsButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
    }

    // MARK: - IBActions
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        print("Forgot Password tapped")
        
        let storyboardName = "ForgotPassword"
        let vcIdentifier = "ForgotPasswordViewController"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        guard let forgotVC = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? ForgotPasswordViewController else {
            print("Error: Could not find \(vcIdentifier) in \(storyboardName).storyboard")
            return
        }
        
        forgotVC.modalPresentationStyle = .fullScreen
        self.present(forgotVC, animated: true, completion: nil)
    }
    
    
    @IBAction func termsButtonTapped(_ sender: UIButton) {
        // This is for the checkbox
        sender.isSelected.toggle()
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        print("Login tapped")
        
        // 1. VALIDATE THE INPUT (NOW WITH ALERTS)
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Email field cannot be empty.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Password field cannot be empty.")
            return
        }
        
        // Use the validation code!
        guard email.validateEmailId() else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        guard password.validatePassword() else {
            showAlert(message: "Password must be at least 8 characters long and contain one letter and one number.")
            return
        }
        
        // 2. IF VALIDATION SUCCEEDS, LOG IN
        print("Login validation successful!")
        
        // TODO: Add real login logic here (e.g., check with Firebase)
        
        // On success, go to the main app
        if let window = self.view.window {
            let mainTabBarController = MainTabBarController()
            window.rootViewController = mainTabBarController
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    
    @IBAction func appleSignInTapped(_ sender: UIButton) {
        print("Apple Sign In tapped")
    }
    
    
    @IBAction func googleSignInTapped(_ sender: UIButton) {
        print("Google Sign In tapped")
    }
    
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        print("Create Account tapped")
        
        // ---
        // !!! --- THIS IS THE NEWLY ADDED CODE --- !!!
        // ---
        
        // 1. Get the current storyboard (which is LoginViewController.storyboard)
        guard let storyboard = self.storyboard else {
            print("Error: Could not find the storyboard.")
            return
        }
        
        // 2. Instantiate the new VC using its Storyboard ID
        if let regVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController {
            
            // 3. Present it
            regVC.modalPresentationStyle = .fullScreen
            self.present(regVC, animated: true, completion: nil)
        } else {
            print("Error: Could not find 'RegistrationViewController' in this storyboard.")
        }
        // --- END OF NEW CODE ---
    }
    
    
    @IBAction func showTermsTapped(_ sender: UIButton) {
        print("Show Terms Tapped")
        
        // 1. Get the current storyboard (LoginViewController.storyboard)
        guard let storyboard = self.storyboard else {
            print("Error: Could not find the storyboard.")
            return
        }
        
        // 2. Instantiate the new VC
        if let termsVC = storyboard.instantiateViewController(withIdentifier: "TermsAndConditionsViewController") as? TermsAndConditionsViewController {
            
            // 3. Present it
            termsVC.modalPresentationStyle = .fullScreen
            self.present(termsVC, animated: true, completion: nil)
        } else {
            print("Error: Could not find 'TermsAndConditionsViewController' in this storyboard.")
        }
    }
    
    
    private func showAlert(title: String = "Login Error", message: String) {
        // Create the alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create the "OK" button
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        // Add the button to the alert
        alertController.addAction(okAction)
        
        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
}

//
// MARK: - String Validation Extension
//
extension String{
    
    func validateEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword(mini: Int = 8, max: Int = 8) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        var passRegEx = ""
        if mini >= max{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        }else{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
   
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
