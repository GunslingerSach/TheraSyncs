//
//  AppointmentTableViewCell.swift
//  TheraSync
//
//  Created by user@54 on 10/11/25.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coloredBarView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(time: String, title: String, date: String) {
        timeLabel.text = time
        titleLabel.text = title
        dateLabel.text = date
        
        // This is the logic to change the bar color
        if title.contains("Therapy") {
            coloredBarView.backgroundColor = .systemOrange
        } else {
            coloredBarView.backgroundColor = .systemOrange
        }
    }
}
