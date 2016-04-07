//
//  Tile.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

struct Tile {
    
    let id: Int
    let attributes: [String: String]
    
    weak var tilemap: IsometricTilemap!
    
    /**
     * Returns a new SKSpriteNode
     */
    func spriteNode() -> SKSpriteNode? {
        let imageName = attributes["imageName"]!
        
        if imageName == "" {
            return nil
        }
        
        let node = SKSpriteNode(imageNamed: imageName)
        let ratio = MapConstants.tileSize.height / node.size.height
        
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5 * ratio)
        node.texture!.filteringMode = .Nearest
        
        return node
    }
    
    subscript(attribute: String) -> String? {
        get {
            return attributes[attribute]
        }
    }
}
