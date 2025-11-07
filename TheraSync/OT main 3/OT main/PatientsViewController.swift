//
//  PatientsViewController.swift
//  OT main
//
//  Created by Garvit Pareek on 07/11/2025.
//

import UIKit

class PatientsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hook up upper-right + button (functionality later)
        if let fab = view.viewWithTag(999) as? UIButton {
            fab.addTarget(self, action: #selector(addPatientTapped), for: .touchUpInside)
        }
    }
    
    @objc private func addPatientTapped() {
        // TODO: Implement later
        print("Upper + tapped")
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

