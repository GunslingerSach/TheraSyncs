//
//  ProfileViewController.swift
//  TheraSync
//
//  Created by user@54 on 10/11/25.
//

import UIKit

// 1. Add UITableViewDataSource and UITableViewDelegate
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // 2. Add your new outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // 3. This is the data for your list
    let settingsOptions = [
        "Update Profile",
        "Settings",
        "Terms & Conditions",
        "About Us"
    ]
    let logoutOption = "Log out"
    
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Setup Navigation Bar ---
        self.title = "Profile" // This will be the large, white title
        
        // --- Setup TableView ---
        tableView.dataSource = self
        tableView.delegate = self
        
        // (No .xib registration needed!)
        
        // --- Setup UI ---
        setupBackground()
        styleProfileImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        
        // This must be here to make the image view a perfect circle
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func styleProfileImage() {
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    // This adds the gradient *behind* the native nav bar
    private func setupBackground() {
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Make the table view transparent so the gradient shows through
        tableView.backgroundColor = .clear
    }
    
    // MARK: - TableView Functions
    
    // We have 2 sections: one for settings, one for "Log out"
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If section 0, return count of settings. If section 1, return 1.
        return (section == 0) ? settingsOptions.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 4. Get the cell using the Identifier we just typed
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        // 5. Configure the cell (it's much simpler now)
        if indexPath.section == 0 {
            // This is the "Settings" section
            cell.textLabel?.text = settingsOptions[indexPath.row]
            cell.textLabel?.textColor = .black
        } else {
            // This is the "Log out" section
            cell.textLabel?.text = logoutOption
            cell.textLabel?.textColor = .systemRed // Make "Log out" red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 6. Add logic for tapping
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let selectedOption = settingsOptions[indexPath.row]
            print("Tapped on: \(selectedOption)")
            // TODO: Add navigation logic here
        } else {
            print("Tapped on: Log out")
            
            // TODO: Add logout logic here (go back to Login screen)
            // (You can copy this code from your CreateNewPasswordViewController)
        }
    }
}
