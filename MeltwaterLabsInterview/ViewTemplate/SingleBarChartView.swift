//
//  SingleBarChartView.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class SingleBarChartView: UIView {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var barChartLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueChangedLabel: UILabel!
    @IBOutlet weak var growthImageView: UIImageView!

    var value:(color:UIColor, value:Double, valueChanged:Double)!{
        didSet{
            barChartLabel.backgroundColor = value.color
            valueLabel.text = Double.formatPoints(num:value.value)
            checkGrowth(number:value.valueChanged)
            
//            let number = (value.value / 10000000) * 250
//            heightConstraint.constant = CGFloat(number)
        }
    }
    
    override func awakeFromNib() {
        valueLabel.textColor = UIColor.white
        valueChangedLabel.textColor = UIColor.red
        growthImageView.image = UIImage(named: "red-triangle")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

extension SingleBarChartView{
    private func checkGrowth(number:Double){
        if(number.isLess(than: 0.0)){
            negativeGrowth(number: number)
        }
        else{
            positiveGrowth(number: number)
        }
    }
    
    // Creates the visual for a negative growth percentage
    private func negativeGrowth(number:Double){
        changePercentage(number:number)
        valueChangedLabel.textColor = UIColor.red
        growthImageView.image = UIImage(named: "red-triangle")
    }
    
    private func positiveGrowth(number:Double){
        changePercentage(number:number)
        valueChangedLabel.textColor = UIColor.green
        growthImageView.image = UIImage(named: "green-triangle")
    }
    
    private func changePercentage(number:Double){
        let nf = NumberFormatter()
        valueChangedLabel.text = nf.createPercentageString(number: number)
    }
}
