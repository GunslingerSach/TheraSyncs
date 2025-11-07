//
//  GradientVIEW.swift
//  register
//
//  Created by Garvit Pareek on 07/11/2025.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    // MARK: - Static Color Definitions
    // Define the two color schemes used by the ViewController
    static let blueStart = UIColor(red: 0.12, green: 0.64, blue: 0.94, alpha: 1.0) // OT: Bright Blue
    static let blueEnd = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 0.0)      // OT: Fade to clear/white
    
    static let orangeStart = UIColor(red: 0.98, green: 0.58, blue: 0.12, alpha: 1.0) // Parents: Orange
    static let orangeEnd = UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 0.0)    // Parents: Fade to clear/white

    // MARK: - Private Properties
    private let gradientLayer = CAGradientLayer()

    // MARK: - Initialization & Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }

    private func setupGradient() {
        // Insert at 0 so it's beneath other elements within the view
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Vertical gradient (top to bottom)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        // Set an initial default color
        setGradient(start: GradientView.blueStart, end: GradientView.blueEnd, animated: false)
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensure the gradient layer always matches the view's bounds
        gradientLayer.frame = bounds
    }

    // MARK: - Public Method to Change Colors
    func setGradient(start: UIColor, end: UIColor, animated: Bool = true) {
        let colors = [start.cgColor, end.cgColor]
        
        if animated {
            // Animates the color change for a smooth effect
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = gradientLayer.colors
            animation.toValue = colors
            animation.duration = 0.3
            animation.isRemovedOnCompletion = false
            animation.fillMode = .forwards
            
            gradientLayer.add(animation, forKey: "colorChange")
        }
        // Set the final color value regardless of animation
        gradientLayer.colors = colors
    }
}
