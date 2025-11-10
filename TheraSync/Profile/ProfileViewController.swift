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
    
    // ---
    // !!! --- THIS IS THE FIX (Part 1) --- !!!
    // ---
    // We've merged all menu items into one array.
    let menuItems = [
        "Update Profile",
        "Settings",
        "Terms & Conditions",
        "About Us",
        "Log out"
    ]
    // (We don't need the separate 'logoutOption' variable anymore)
    
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
        
        // Make the image view a perfect circle based on its current size
        profileImageView.layer.cornerRadius =  profileImageView.bounds.width / 2
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
        
        // This is the 60% fade you wanted
        gradientLayer.locations = [0.0, 0.6]
        
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Make the table view transparent so the gradient shows through
        tableView.backgroundColor = .clear
    }
    
    // MARK: - TableView Functions
    
    // ---
    // !!! --- THIS IS THE FIX (Part 2) --- !!!
    // ---
    // We now only have 1 section.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Just return the total count of our new array
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        // ---
        // !!! --- THIS IS THE FIX (Part 3) --- !!!
        // ---
        // Get the item for the current row
        let item = menuItems[indexPath.row]
        cell.textLabel?.text = item
        
        // Check *what* the item is and style it
        if item == "Log out" {
            // This is the "Log out" row
            cell.textLabel?.textColor = .systemRed
            cell.accessoryType = .none // "Log out" shouldn't have an arrow
        } else {
            // This is a normal settings row
            cell.textLabel?.textColor = .black
            cell.accessoryType = .disclosureIndicator // Add the '>' arrow
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Add logic for tapping
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ---
        // !!! --- THIS IS THE FIX (Part 4) --- !!!
        // ---
        let selectedOption = menuItems[indexPath.row]
        print("Tapped on: \(selectedOption)")

        if selectedOption == "Log out" {
            print("Tapped on: Log out")
            // TODO: Add logout logic here (go back to Login screen)
        } else {
            // This is one of the other settings
            // TODO: Add navigation logic here
        }
    }
}
