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
        // 1. Load your "Appointment" screen
        // ---
        let appointmentNav = createNavController(
            from: "Appointment",
            with: "AppointmentViewController",
            title: "Appointment",
            image: "calendar"
        )
        
        // ---
        // 2. Load your teammate's "Patients" screen
        // ---
        let patientsNav = createNavController(
            from: "Patients", // <-- Make sure this is your teammate's storyboard file name
            with: "PatientsViewController", // <-- Make sure this is their Storyboard ID
            title: "Patients",
            image: "person.2.fill"
        )
        
        // ---
        // 3. Load the "Chat" placeholder (still commented out)
        // ---
//        let chatNav = createNavController(
//            from: "Chat",
//            with: "ChatViewController",
//            title: "Chat",
//            image: "message.fill"
//        )

        // ---
        // 4. Load your teammate's "Profile" screen
        // ---
        let profileNav = createNavController(
            from: "Profile", // <-- Make sure this is your teammate's storyboard file name
            with: "ProfileViewController", // <-- Make sure this is their Storyboard ID
            title: "Profile",
            image: "person.crop.circle.fill"
        )

        // ---
        // 5. Set the tabs
        // ---
        // We leave 'chatNav' out for now
        self.viewControllers = [appointmentNav, patientsNav, profileNav]
        
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
        
        // Set the nav bar to be transparent
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // ---
        // !!! --- THIS IS THE FIX --- !!!
        // ---
        // By commenting out this line, the nav bar becomes fully transparent,
        // letting your view's gradient show through.
        // let topColor = UIColor(red: 69/255, green: 147/255, blue: 255/255, alpha: 1.0)
        // appearance.backgroundColor = topColor
        // ---
        
        // This makes the title "Appointment", "Patients", etc. big and white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // For the small title
        
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.tintColor = .white // For the '+' and back buttons
        
        // This enables the large title
        navController.navigationBar.prefersLargeTitles = true

        return navController
    }
}
