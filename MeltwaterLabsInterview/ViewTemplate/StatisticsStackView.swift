//
//  StatisticsStackView.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 03/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class StatisticsStackView: UIStackView {
    override func awakeFromNib() {
        self.distribution = .fillEqually
        self.spacing = 20
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
