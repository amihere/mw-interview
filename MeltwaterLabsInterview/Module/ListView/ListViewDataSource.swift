//
//  ListViewDataSource.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//
//  Responsible for pulling relevant resources from a specified url.

import Foundation

struct DataResponse: Codable{
    var companies:[Company]?
    var analysis:Analysis?
    var reach:Reach?
}

class ListViewDataSource: DataSourceProtocol{
    
    var url: URL?
    
    init(withURL url:URL?){
        self.url = url
    }
    
    init(){
        self.url = URL(string: "https://api.myjson.com/bins/1eenaa")
    }
    
    func retrieveFromCache() {
        // Do nothing for now
    }
    
    func fetch(completion: @escaping (_ result: Result<DataResponse>) -> Void) {
        if let url = url{
            NetworkInteraction.get(url: url) { result in
                completion(result as Result<DataResponse>)
            }
        }
    }
}
