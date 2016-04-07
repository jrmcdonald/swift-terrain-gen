//
//  GameConstants.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 03/04/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

struct MapConstants {
    static let chunkSize = CGSize(width: 32.0, height: 32.0)
    static let tileSize = CGSize(width: 64.0, height: 32.0)
    static let tileWidth: CGFloat = 64.0
    
    static let minZoom: CGFloat = 3.0
    static let maxZoom: CGFloat = 0.6
    
    enum Layers: String {
        case Terrain = "terrain"
        case Features = "features"
        case Objects = "objects"
    }
}