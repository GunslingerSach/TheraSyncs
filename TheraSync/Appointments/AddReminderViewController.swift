//
//  AddReminderViewController.swift
//  TheraSync
//
//  Created by user@54 on 09/11/25.
//

import UIKit

class AddReminderViewController: UIViewController {

    // MARK: - Outlets
    // (You will connect these in your Appointment.storyboard)
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subHeadingTextField: UITextField!
    
    @IBOutlet weak var dateTimeContainerView: UIView! // The rounded white view
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background to light gray, just like your Figma
        self.view.backgroundColor = .systemGroupedBackground
        
        // Style the text fields
        titleTextField.layer.cornerRadius = 26
        subHeadingTextField.layer.cornerRadius = 26
        
        // Style the container
        dateTimeContainerView.layer.cornerRadius = 26
        
        // Add padding
        addPadding(to: titleTextField)
        addPadding(to: subHeadingTextField)
    }
    
    // ---
    // !!! THIS IS THE NEW FUNCTION !!!
    // ---
    // This function is called after the view is laid out
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // This is how you round only the top corners
        
        // 1. Set the corner radius you want
        view.layer.cornerRadius = 20.0 // You can change 20 to any value
        
        // 2. Tell it to *only* apply the radius to the top-left and top-right
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // 3. (Optional) This clips the subviews to the rounded shape
        view.layer.masksToBounds = true
    }
    
    func addPadding(to textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        // This dismisses the pop-up
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 1. TODO: Add logic to save the reminder
        let title = titleTextField.text ?? "No Title"
        print("Saving reminder: \(title)")
        
        // 2. Dismiss the pop-up
        self.dismiss(animated: true, completion: nil)
    }
}
