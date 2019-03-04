//
//  TableViewCellProtocols.swift
//  MeltwaterLabsInterview
//
//  Created by Ayeba Amihere on 03/03/2019.
//  Copyright © 2019 Ayeba Amihere. All rights reserved.
//

import Foundation
import UIKit
protocol HeaderProtocol: class {
    var headerTuple:(title:String, byLine:String) { get set }
}
