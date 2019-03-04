//
//  HeaderLabel.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel {

    override func awakeFromNib() {
        self.textColor = UIColor.white
        self.font = UIFont(name: "Helvetica Neue", size: 20)
    }
    
    func setTextColorBlack(){
        DispatchQueue.main.async {
            self.textColor = UIColor.black
        }
    }

}
