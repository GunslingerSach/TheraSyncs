//
//  AppointmentViewController.swift
//  TheraSync
//
//  Created by user@54 on 09/11/25.
//

import UIKit

// Make sure to add UITableViewDataSource and UITableViewDelegate
class AppointmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var mainDatePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    // Dummy data
    let appointments = [
        ("12:00 PM", "Sudhanshu Therapy", "26.06.24"),
        ("2:00 PM", "Vishal Mentors Meet", "26.06.24"),
        ("2:30 PM", "Rishi Therapy", "26.06.24"),
        ("4:00 PM", "Sahil Therapy", "26.06.24")
    ]
    
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the .xib file for your custom cell
        let nib = UINib(nibName: "AppointmentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AppointmentCell")
        
        // --- Setup Navigation Bar ---
        self.title = "Appointment"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(addReminderTapped))
        
        // --- Setup UI ---
        setupBackground()
        styleUI()
        
        // Make the date picker's background clear
        mainDatePicker.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func setupBackground() {
        // This gradient will now show *behind* the native nav bar
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor.systemGray6.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func styleUI() {
        tableView.layer.cornerRadius = 26
        tableView.layer.masksToBounds = true
        tableView.tableFooterView = UIView() // Hides empty cells
        tableView.backgroundColor = .clear // Let gradient show through
    }

    @objc func addReminderTapped() {
        print("Add Reminder Tapped")
        guard let storyboard = self.storyboard else { return }
        
        if let addReminderVC = storyboard.instantiateViewController(withIdentifier: "AddReminderViewController") as? AddReminderViewController {
            
            // ---
            // !!! THIS IS THE FIX !!!
            // ---
            // This one line tells iOS to present it as a pop-up "sheet"
            // with the rounded corners, exactly like your Figma.
            addReminderVC.modalPresentationStyle = .pageSheet
            // ---
            
            self.present(addReminderVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as? AppointmentTableViewCell else {
            return UITableViewCell()
        }
        
        let (time, title, date) = appointments[indexPath.row]
        cell.configure(time: time, title: title, date: date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
