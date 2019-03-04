//
//  Reach.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 01/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
class Reach: Codable {
    var id:String 
    var title:String 
    var subTitle:String 
    var data:[ReachData]?
    
    init(id:String, title:String, subTitle:String, data:[ReachData]?){
        self.id = id 
        self.title = title 
        self.subTitle = subTitle 
        self.data = data 
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subTitle = "sub_title"
        case data
    }
    
    func getReachData(withIndex index:Int) -> ReachData? {
        if let data = data,
            index >= 0 && index < data.count {
            return data[index]
        }
        return nil
    }
}

// Utility Methods
extension Reach{
    static func parseReach(withJsonValues json:Any) -> Reach?{
        if let json = json as? [String: AnyObject],
            let id = json["id"] as? String,
            let title = json["title"] as? String,
            let subTitle = json["sub_title"] as? String,
            let data = json["data"] as? [Any]{
            
            var reachData = [ReachData]()
            data.forEach({ (json) in
                if let reachDataSingle = ReachData.parseReachData(withJsonValues: json){
                    reachData.append(reachDataSingle)
                }
            })
            return Reach(id: id, title: title, subTitle: subTitle, data: reachData)
        }
        return nil 
    }
}
