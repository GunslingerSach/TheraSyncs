//
//  TermsAndConditionsViewController.swift
//  TheraSync
//
//  Created by user@54 on 10/11/25.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        styleUI()
        
        // Set the terms text
        textView.text = """
        1. Introduction & Acceptance of Terms
        Purpose: States that by accessing or using the TheraSync apps (Pro, Connect, Kids), the user agrees to these terms.
        Key points:
        Defines "User" (OT, Patient) and "App/Services."
        Acknowledgment that terms are a legally binding agreement.
        Statement that if the user does not agree, they must not use the apps.
        2. Eligibility and User Accounts
        Purpose: Defines who can use the apps and the responsibilities of account holders.
        Key points:
        OT (TheraSync Pro): Must be a licensed and qualified occupational therapist or similar professional. Account creation, security, confidentiality.
        Mentor (TheraSync Connect): Must be a parent, guardian, or authorized caregiver linked by an OT. Consent to monitor a child's progress. Account security.
        Child (TheraSync Kids): No account creation; access is granted and managed by a Mentor. Age restrictions (e.g., parental consent required for children under 13, per COPPA in the US, or equivalent local laws).
        Accuracy of information provided during registration.
        Responsibility for maintaining account security (passwords, etc.).
        3. Nature of Services and Disclaimers
        Purpose: Clarifies what the app does and, crucially, what it doesn't do (i.e., it's a tool, not a substitute for professional care).
        Key points:
        TheraSync provides tools for OTs to create routines, for Mentors to guide, and for children to follow.
        Crucial Disclaimer: The app is a support tool and does not provide medical, therapeutic, or diagnostic services. It does not replace professional judgment, treatment plans, or direct supervision by a qualified therapist.
        Users are solely responsible for the content they create, use, and the decisions they make based on app usage.
        4. User Responsibilities and Conduct
        Purpose: Outlines acceptable use and prohibited activities.
        Key points:
        Compliance with all applicable laws and regulations (especially regarding healthcare, privacy, and children's data).
        Prohibition of misuse, hacking, distributing malware, or interfering with app functionality.
        Respectful communication.
        Reporting of security vulnerabilities or breaches.
        5. Intellectual Property Rights
        Purpose: Protects the app's software, content, and branding, while addressing user-generated content.
        Key points:
        All content within the app (code, design, trademarks, etc.) belongs to TheraSync (or its licensors).
        Users are granted a limited, non-exclusive, non-transferable license to use the app for its intended purpose.
        User-Generated Content (UGC):
        OTs/Mentors retain ownership of the routines, videos, audio, and notes they create.
        Grant TheraSync a license to host, display, and distribute this content within the app for the intended users (OTs, Mentors, Children).
        Responsibility for ensuring UGC does not infringe on third-party rights (copyright, privacy, etc.).
        6. Privacy Policy Reference
        Purpose: Links to a separate, comprehensive Privacy Policy.
        Key points:
        Explicitly states that data collection, usage, storage, and sharing are governed by the Privacy Policy.
        Highlights the importance of children's privacy (COPPA, GDPR-K, etc.) and parental consent.
        7. Data Security
        Purpose: Outlines the app's commitment to protecting user data.
        Key points:
        Description of security measures taken (encryption, access controls, etc.).
        Acknowledgement that no system is 100% secure.
        User's responsibility to protect their own account credentials.
        8. Fees and Payment (if applicable)
        Purpose: If the TheraSync Pro app has subscription fees or in-app purchases.
        Key points:
        Pricing, billing cycles, payment methods.
        Refund policy.
        Subscription auto-renewal terms.
        9. Termination
        Purpose: Explains conditions under which accounts can be terminated.
        Key points:
        Termination by the user (how to cancel).
        Termination by TheraSync (e.g., for breach of terms, illegal activity, non-payment).
        Effect of termination on data access and storage.
        10. Disclaimers of Warranties
        Purpose: Limits the company's liability regarding the app's performance.
        Key points:
        App provided "as is" and "as available."
        No guarantee of uninterrupted, error-free, or secure service.
        No warranty regarding the accuracy or reliability of results obtained from using the app.
        11. Limitation of Liability
        Purpose: Restricts the amount and types of damages the company can be held responsible for.
        Key points:
        Exclusion of liability for indirect, incidental, consequential damages.
        Maximum liability cap.
        12. Indemnification
        Purpose: Requires users to protect the company from legal claims arising from their misuse of the app.
        Key points:
        User agrees to indemnify and hold harmless TheraSync from any claims, damages, losses, or expenses (including legal fees) resulting from their breach of these terms, violation of law, or infringement of third-party rights.
        13. Governing Law and Dispute Resolution
        Purpose: Specifies which laws apply and how legal disputes will be handled.
        Key points:
        Jurisdiction (e.g., "Laws of the State of Delaware, USA").
        Arbitration clause (often preferred to avoid lengthy court battles).
        Class action waiver.
        14. Changes to Terms
        Purpose: Reserves the right for the company to update the terms.
        Key points:
        Notification method (e.g., in-app notification, email).
        Effective date of changes.
        Continued use implies acceptance of new terms.
        15. Miscellaneous
        Purpose: Standard legal boilerplate clauses.
        Key points:
        Severability (if one part is invalid, the rest remains).
        Entire Agreement (these terms supersede prior agreements).
        Waiver (failure to enforce a right doesn't waive it).
        Assignment (user cannot transfer rights; company can).
        16. Contact Information
        """
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    // MARK: - UI Setup
    
    private func setupBackground() {
        // This is the blue gradient from your screenshot
        let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 0.8).cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func styleUI() {
        // Style UI elements
        titleLabel.textColor = .white
        backButton.tintColor = .white
        doneButton.tintColor = .white
        
        textView.layer.cornerRadius = 20
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }

    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Go back to the Login screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // Go back to the Login screen
        self.dismiss(animated: true, completion: nil)
    }
}
