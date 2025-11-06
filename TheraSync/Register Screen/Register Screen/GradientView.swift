//
//  GradientView.swift
//  Register Screen
//
//  Created by Garvit Pareek on 06/11/2025.
//
import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor: UIColor = .clear {
        didSet { updateGradient() }
    }
    @IBInspectable var bottomColor: UIColor = .clear {
        didSet { updateGradient() }
    }

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        updateGradient() // initial
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updateGradient() // every resize
    }

    // MARK: - Force update
    private func updateGradient() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }

    // Optional: expose for animation
    func setColors(top: UIColor, bottom: UIColor, animated: Bool = true) {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = [top.cgColor, bottom.cgColor]
        animation.duration = animated ? 0.35 : 0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        gradientLayer.colors = [top.cgColor, bottom.cgColor]
        if animated {
            gradientLayer.add(animation, forKey: "colorChange")
        }
    }
}
