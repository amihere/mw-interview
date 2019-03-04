//
//  AnalysisData.swift
//  mestLabsIdea
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
class AnalysisData: Codable{
    var id:String
    var text:String
    
    init(id:String, text:String){
        self.id = id
        self.text = text
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
    }
}

// Utility Methods
extension AnalysisData{
    
    static func parseAnalysisData(withJsonValues json:Any) -> AnalysisData?{
        if let json = json as? [String: AnyObject],
            let id = json.first?.key,
            let text = json.first?.value as? String {
            
            return AnalysisData(id: id, text: text)
        }
        return nil 
    }
}
