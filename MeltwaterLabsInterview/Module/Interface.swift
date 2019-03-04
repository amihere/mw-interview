//
//  Interface.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 02/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation

protocol DataSourceProtocol: AnyObject{
    var url:URL? { get }
    func retrieveFromCache()
    func fetch(completion: @escaping (_ result: Result<DataResponse>) -> Void)
}

protocol ViewModel{
    
}

protocol ViewModelDelegate: AnyObject{
    func willLoadData()
    func didLoadData()
}
