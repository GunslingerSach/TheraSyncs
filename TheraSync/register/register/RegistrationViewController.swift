//
//  ViewController.swift
//  register
//
//  Created by Garvit Pareek on 07/11/2025.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var headerGradientView: GradientView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Form container stack views
    @IBOutlet weak var occupationalTherapistForm: UIStackView!
    @IBOutlet weak var parentsForm: UIStackView!
    
    // Register button (optional to connect, but good practice)
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial state to the first segment (Occupational Therapist)
        segmentControl.selectedSegmentIndex = 0
        
        // Apply initial UI setup without animation
        updateUIForSelectedSegment(animated: false)
        
        // Customize the segmented control appearance
        customizeSegmentControlAppearance()
    }

    // MARK: - Appearance Setup
    func customizeSegmentControlAppearance() {
        // Sets the background color of the segmented control (the track) to clear
        segmentControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // Sets the divider image to be transparent (removing lines)
        segmentControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // Initial selected color (for the text in the selected segment)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        
        // Initial normal color (for the text in the unselected segment)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.7),
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        
        segmentControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        // Set the initial tint color for the selected segment track
        segmentControl.selectedSegmentTintColor = GradientView.blueStart
    }

    // MARK: - Actions
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        // Called when the user taps a segment
        updateUIForSelectedSegment(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let segmentName = segmentControl.selectedSegmentIndex == 0 ? "Occupational Therapist" : "Parents"
        print("Register button tapped for: \(segmentName)")
        // Implement navigation or form submission here
    }
    
    // MARK: - UI Update Logic
    
    func updateUIForSelectedSegment(animated: Bool) {
        let selectedIndex = segmentControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            // MARK: Occupational Therapist Selected (Blue Theme)
            headerGradientView.setGradient(start: GradientView.blueStart, end: GradientView.blueEnd, animated: animated)
            segmentControl.selectedSegmentTintColor = GradientView.blueStart // Updates the highlight color
            
            // Show/Hide Forms
            occupationalTherapistForm.isHidden = false
            parentsForm.isHidden = true
            
        } else {
            // MARK: Parents Selected (Orange Theme)
            headerGradientView.setGradient(start: GradientView.orangeStart, end: GradientView.orangeEnd, animated: animated)
            segmentControl.selectedSegmentTintColor = GradientView.orangeStart // Updates the highlight color
            
            // Show/Hide Forms
            occupationalTherapistForm.isHidden = true
            parentsForm.isHidden = false
        }
        
        // Animate the layout change if a form's height changes
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
