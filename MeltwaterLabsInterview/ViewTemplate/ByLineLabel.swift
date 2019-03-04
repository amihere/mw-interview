//
//  ByLineLabel.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class ByLineLabel: UILabel {
    override func awakeFromNib() {
        self.textColor = UIColor.white
        self.font = UIFont(name: "Helvetica Neue", size: 16)
    }
    
    func setTextColorGray(){
        DispatchQueue.main.async {
            self.textColor = UIColor.darkGray
        }
    }
}
