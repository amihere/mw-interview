//
//  Company.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 01/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
import UIKit

class Company: Codable {
    var id:String 
    var name:String 
    var color:String
    
    init(id:String, name:String, color:String){
        self.id = id 
        self.name = name 
        self.color = color
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
    }
}

// Utility Methods
extension Company{
    func getColor() -> UIColor?{
        return changeToColor(string:self.color)
    }
    
    func changeToColor(string:String)->UIColor?{
        return UIColor.init(hexString: string) 
    }
    
    static func parseCompany(withJsonValues json:Any) -> Company?{
        if let json = json as? [String: AnyObject],
            let name = json["name"] as? String,
            let color = json["color"] as? String,
            let id = json["id"] as? String{
            return Company(id: id, name: name, color: color)
        }
        return nil 
    }
}
