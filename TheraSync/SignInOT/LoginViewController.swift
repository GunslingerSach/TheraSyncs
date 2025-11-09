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
    @IBOutlet weak var loginButton: UIButton! // Fixed a typo here too
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckbox()
        // Call setupStyling()
        setupStyling()
    }
    
    func setupStyling() {
        // The typo was likely here, trying to style a variable that didn't exist
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        
        loginButton.layer.cornerRadius = 25
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
        
        // 1. Define your storyboard and VC names
        let storyboardName = "ForgotPassword" // Or "ForgotScreen"
        let vcIdentifier = "ForgotPasswordViewController"
        
        // 2. Load the storyboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        // 3. Load your VC
        guard let forgotVC = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? ForgotPasswordViewController else {
            print("Error: Could not find \(vcIdentifier) in \(storyboardName).storyboard")
            return
        }
        
        // 4. Present it
        forgotVC.modalPresentationStyle = .fullScreen
        self.present(forgotVC, animated: true, completion: nil)
    }
    
    
    @IBAction func termsButtonTapped(_ sender: UIButton) {
    
    sender.isSelected.toggle()
        
        if sender.isSelected {
            print("User agreed to terms")
        } else {
            print("User un-agreed to terms")
        }
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
    
        print("Login tapped")
        
        // This is the code to launch your Schedule screen
        if let window = self.view.window {
            
            // Create the Tab Bar Controller from code
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
    }
}
