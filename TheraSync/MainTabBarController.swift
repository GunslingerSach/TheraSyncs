//
//  MainTabBarController.swift
//  TheraSync
//
//  Created by user@54 on 07/11/25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---
        // 1. Load the "Appointment" screen (This one is DONE)
        // ---
        let appointmentNav = createNavController(
            from: "Appointment",
            with: "AppointmentViewController",
            title: "Appointment",
            image: "calendar"
        )
        
        // ---
        // 2. Load the "Patients" screen (TEMPORARILY COMMENTED OUT)
        // ---
//        let patientsNav = createNavController(
//            from: "Patients",
//            with: "PatientsViewController",
//            title: "Patients",
//            image: "person.2.fill"
//        )
        
        // ---
        // 3. Load the "Chat" screen (TEMPORARILY COMMENTED OUT)
        // ---
//        let chatNav = createNavController(
//            from: "Chat",
//            with: "ChatViewController",
//            title: "Chat",
//            image: "message.fill"
//        )

        // ---
        // 4. Load the "Profile" screen (TEMPORARILY COMMENTED OUT)
        // ---
//        let profileNav = createNavController(
//            from: "Profile",
//            with: "ProfileViewController",
//            title: "Profile",
//            image: "person.crop.circle.fill"
//        )

        // ---
        // 5. Set the tabs
        // ---
        // We are only loading the one tab you built
        self.viewControllers = [appointmentNav]
        
        // (Later, you will change it back to this):
        // self.viewControllers = [appointmentNav, patientsNav, chatNav, profileNav]
        
        // Style the tab bar
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .systemBlue
    }
    
    /// Helper function to load a VC from a storyboard and wrap it in a Nav Controller.
    private func createNavController(from storyboardName: String, with identifier: String, title: String, image: String) -> UINavigationController {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), tag: 0)
        
        // --- Native Nav Bar Styling ---
        let appearance = UINavigationBarAppearance()
        
        // Make the bar transparent so your gradient shows through
        appearance.configureWithTransparentBackground()
        
        // Set the title text colors to white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.tintColor = .white // For the '+' and back buttons
        
        // ---
        // !!! THIS IS THE LINE THAT DOES IT !!!
        // ---
        // This enables the "Large" title and the "Compact" title on scroll
        navController.navigationBar.prefersLargeTitles = true

        return navController
    }
}
