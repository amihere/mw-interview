//
//  ChartTableViewCell.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell, HeaderProtocol {
    
    @IBOutlet weak var headerLabel: HeaderLabel!
    @IBOutlet weak var byLineLabel: ByLineLabel!
    @IBOutlet weak var companyTitleStackView: UIStackView!
    @IBOutlet weak var chartStackView: UIStackView!
    
    public static let reuseCellIdentifier = "chartListItem";
    static let nibName = "ChartViewCell"
    
    var headerTuple:(title:String, byLine:String) = (title:"", byLine: ""){
        didSet{ assignTitleAndByLine(tuple:headerTuple) }
    }
    var values:[(company:String, value:Double, valueChanged:Double)]!{
        didSet{ updateValues() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.white
        headerLabel.setTextColorBlack()
        byLineLabel.setTextColorGray()
        
        // TODO pick from data
        headerLabel.text = "Brand Rew"
        byLineLabel.text = "Jan"
    }
    
    private func getHeight(value:Double) -> CGFloat{
        return 4
    }
}
// MARK: didSet methods
extension ChartTableViewCell{
    private func assignTitleAndByLine(tuple:(title:String, byLine:String)){
        headerLabel.text = tuple.title
        byLineLabel.text = tuple.byLine
    }
    
    private func updateValues(){
        DispatchQueue.main.async {
            // Clear existing views
            self.chartStackView.arrangedSubviews.forEach({ (aView) in
                self.chartStackView.removeArrangedSubview(aView)
            })
            self.companyTitleStackView.arrangedSubviews.forEach { (aView) in
                self.companyTitleStackView.removeArrangedSubview(aView)
            }
            
            var firstPass = true
            var isBlue = true
            var x:Int = 0
            let width = 80
            let height = 275
            let spacing = 10
            self.values.forEach { (tuple) in
                let color = isBlue ? UIColor.blue : UIColor.orange
                let barChartView = SingleBarChartView(frame: CGRect(x: x, y: 0, width: width, height: height))
                
                barChartView.value = (color:color, value:tuple.value, valueChanged:tuple.valueChanged)
                self.chartStackView.addArrangedSubview(barChartView)
                
                let number = CGFloat(tuple.value / 10000000) * CGFloat(height)
                barChartView.heightConstraint.constant = (number)
                barChartView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                let label = UILabel()
                label.text = tuple.company
                label.textColor = color
                
                if(!firstPass){
                    self.companyTitleStackView.addSeparator(color: .black)
                }
                else {
                    firstPass = false
                }
                self.companyTitleStackView.addArrangedSubview(label)
                
                isBlue.toggle()
                x += width + spacing
            }
        }
    }
}
