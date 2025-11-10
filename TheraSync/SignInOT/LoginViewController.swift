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
    
    // (You will need to add a new outlet for your "Show Terms" button)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckbox()
        setupStyling()
    }
    
    func setupStyling() {
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
    }
    
    // ---
    // !!! --- THIS IS THE NEW FUNCTION --- !!!
    // ---
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
}
