//
//  Analysis.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 01/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation

class Analysis: Codable{
    var id: String 
    var title: String 
    var subTitle: String 
    var text: String 
    var phrases: [String:String]?
    
    init(id: String, title: String, subTitle: String, text: String, phrases: [String:String]?){
        self.id = id 
        self.title = title 
        self.subTitle = subTitle 
        self.text = text 
        self.phrases = phrases
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subTitle = "sub_title"
        case text
        case phrases
    }
}

// Utility Methods
extension Analysis{
    
    static func parseAnalysis(withJsonValues json:Any) -> Analysis?{
        if let json = json as? [String: AnyObject],
            let id = json["id"] as? String,
            let title = json["title"] as? String,
            let subTitle = json["sub_title"] as? String,
            let text = json["text"] as? String,
            let phrases = json["phrases"] as? [String:String]{
            
            return Analysis(id: id, title: title, subTitle: subTitle, text: text, phrases: phrases)
        }
        return nil 
    }
}
