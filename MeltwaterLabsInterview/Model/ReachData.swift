//
//  ReachData.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 01/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
class ReachData: Codable{
    var companyId:String 
    var value:Double 
    var change:Double 
    
    init(companyId:String, value:Double, change:Double){
        self.companyId = companyId 
        self.value = value 
        self.change = change 
    }
    
    private enum CodingKeys: String, CodingKey {
        case companyId = "company_id"
        case value
        case change
    }
}

// Utility Methods
extension ReachData{
    
    static func parseReachData(withJsonValues json:Any) -> ReachData?{
        if let json = json as? [String: AnyObject],
            let companyId = json["company_id"] as? String,
            let valueStr = json["value"] as? NSString,
            let changeStr = json["change"] as? NSString {
            
            let change = changeStr.doubleValue
            let value = valueStr.doubleValue
            
            return ReachData(companyId: companyId, value: value, change: change) 
        }
        return nil 
    }
}
