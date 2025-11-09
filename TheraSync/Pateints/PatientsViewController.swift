//
//  PatientsViewController.swift
//  TheraSync
//
//  Created by user@54 on 10/11/25.
//

import UIKit

// 1. Add 'UISearchBarDelegate' to make the search bar work
class PatientsViewController: UIViewController, UISearchBarDelegate {
    
    // 2. Add outlets for both your new UI elements
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Setup Navigation Bar ---
        self.title = "Patients" // This will be the large, white title
        
        // This adds the '+' button to the nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(addPatientTapped))
        
        // --- Setup UI ---
        setupBackground()
        
        // 3. Set the delegate for the search bar
        searchBar.delegate = self
        
        // 4. Style the search bar to match the gradient
        searchBar.backgroundImage = UIImage() // Removes the 1px border
        searchBar.barTintColor = .clear // Makes it blend with the gradient
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // This adds the gradient *behind* the native nav bar
    private func setupBackground() {
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // This function is called by the new '+' button in the nav bar
    @objc func addPatientTapped() {
        print("Add New Patient Tapped!")
        // TODO: Add logic here to present the "Add New Patient" screen
    }
    
    // ---
    // 5. These functions run when you use the search bar
    // ---
    
    // This is called when you tap the "Search" button on the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // This hides the keyboard
    }
    
    // This is called every time you type a letter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // No text: show the placeholder
            placeholderLabel.isHidden = false
            // TODO: Show all patients
        } else {
            // Text exists: hide the placeholder
            placeholderLabel.isHidden = true
            // TODO: Filter your list of patients based on the searchText
        }
        
        print("Searching for: \(searchText)")
    }
}
