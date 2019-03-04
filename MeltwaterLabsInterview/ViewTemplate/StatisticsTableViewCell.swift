//
//  StatisticsTableViewCell.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell, HeaderProtocol {

    @IBOutlet weak var brandTitleLabel: HeaderLabel!
    @IBOutlet weak var byLineLabel: ByLineLabel!
    @IBOutlet weak var statisticsStackView: StatisticsStackView!
    
    public static let reuseCellIdentifier = "statisticsListItem";
    static let nibName = "StatisticsViewCell"
    
    var headerTuple:(title:String, byLine:String) = (title:"", byLine: ""){
        didSet{ assignTitleAndByLine(tuple:headerTuple) }
    }
    var statistics:[String]!{
        didSet{ updateValues() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.init(red: 0.37, green: 0.73, blue: 0.86, alpha: 1)
    }
    
    
}

// MARK: didSet methods
extension StatisticsTableViewCell{
    private func assignTitleAndByLine(tuple:(title:String, byLine:String)){
        brandTitleLabel.text = tuple.title
        byLineLabel.text = tuple.byLine
    }
    
    private func updateValues(){
        DispatchQueue.main.async {
            // Clear existing views
            self.statisticsStackView.arrangedSubviews.forEach({ (aView) in
                self.statisticsStackView.removeArrangedSubview(aView)
            })
            // add new views
            self.statistics.forEach { (stat) in
                let aView = BulletinView(frame: self.statisticsStackView.frame)
                aView.statisticText = stat
                self.statisticsStackView.addArrangedSubview(aView)
            }
        }
    }
}
