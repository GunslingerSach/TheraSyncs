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
    
    // Register button
    @IBOutlet weak var registerButton: UIButton!
    
    // ---
    // !!! --- ADD THIS NEW OUTLET --- !!!
    // ---
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.selectedSegmentIndex = 0
        updateUIForSelectedSegment(animated: false)
        customizeSegmentControlAppearance()
    }

    // MARK: - Appearance Setup
    func customizeSegmentControlAppearance() {
        segmentControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.7),
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        
        segmentControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        segmentControl.selectedSegmentTintColor = GradientView.blueStart
    }

    // MARK: - Actions
    
    // ---
    // !!! --- ADD THIS NEW FUNCTION --- !!!
    // ---
    @IBAction func backButtonTapped(_ sender: UIButton) {
        print("Back button tapped, dismissing Registration.")
        // This dismisses this screen and reveals the Login screen again
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        updateUIForSelectedSegment(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let segmentName = segmentControl.selectedSegmentIndex == 0 ? "Occupational Therapist" : "Parents"
        print("Register button tapped for: \(segmentName)")
    }
    
    // MARK: - UI Update Logic
    
    func updateUIForSelectedSegment(animated: Bool) {
        let selectedIndex = segmentControl.selectedSegmentIndex
        
        if selectedIndex == 0 {
            // MARK: Occupational Therapist Selected (Blue Theme)
            headerGradientView.setGradient(start: GradientView.blueStart, end: GradientView.blueEnd, animated: animated)
            segmentControl.selectedSegmentTintColor = GradientView.blueStart
            
            occupationalTherapistForm.isHidden = false
            parentsForm.isHidden = true
            
        } else {
            // MARK: Parents Selected (Orange Theme)
            headerGradientView.setGradient(start: GradientView.orangeStart, end: GradientView.orangeEnd, animated: animated)
            segmentControl.selectedSegmentTintColor = GradientView.orangeStart
            
            occupationalTherapistForm.isHidden = true
            parentsForm.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
