//
//  ViewController.swift
//  Register Screen
//
//  Created by Garvit Pareek on 06/11/2025.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.selectedSegmentIndex = 0
        updateUI(animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI(animated: false)  // Ensures no white flash
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        updateUI(animated: true)
    }

    private func updateUI(animated: Bool) {
        let isTherapist = segmentControl.selectedSegmentIndex == 0
        showForm(isTherapist: isTherapist)
        updateGradient(animated: animated)
    }

    private func showForm(isTherapist: Bool) {
        for subview in containerView.subviews {
            if subview.tag == 100 {
                subview.isHidden = !isTherapist
            } else if subview.tag == 200 {
                subview.isHidden = isTherapist
            }
        }
    }

    private func updateGradient(animated: Bool) {
        let topColor = segmentControl.selectedSegmentIndex == 0 ? UIColor.systemBlue : UIColor.systemOrange
        let bottomColor = segmentControl.selectedSegmentIndex == 0 ? UIColor(white: 0.95, alpha: 1) : UIColor(white: 0.9, alpha: 1)
        gradientView.setColors(top: topColor, bottom: bottomColor, animated: animated)
    }
}
