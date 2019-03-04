//
//  BulletinView.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class BulletinView: UIView {

    private var bulletinImage:UIImageView!
    private var textLabel:UILabel!
    var statisticText:String!{
        didSet{
            if let textLabel = textLabel{
                textLabel.text = statisticText
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        bulletinImage = UIImageView(image: UIImage(named: "bullet-p"))
        bulletinImage.contentMode = .scaleAspectFit
        bulletinImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bulletinImage)
        bulletinImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bulletinImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        bulletinImage.widthAnchor.constraint(equalToConstant: 8).isActive = true
        bulletinImage.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        textLabel.numberOfLines = 0
        
        addSubview(textLabel)
        textLabel.leftAnchor.constraint(equalTo: bulletinImage.rightAnchor, constant: 10).isActive = true
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1)
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }

}
