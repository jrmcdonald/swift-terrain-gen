//
//  GridLayer.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class GridLayer: SKNode {
    
    weak var tilemap: IsometricTilemap!
    
    init(tilemap: IsometricTilemap) {
        self.tilemap = tilemap
        
        super.init()
        
        buildLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Generate a grid of shape nodes specified by the Tilemap instance.
     */
    func buildLayer() {
        for i in 0..<Int(tilemap.mapSize.width) {
            for j in 0..<Int(tilemap.mapSize.height) {
                let node = tilemap.tileShapeNode()
                
                node.strokeColor = UIColor.grayColor()
                node.position = tilemap.positionForPoint(CGPoint(x: i, y: j))
                
                addChild(node)
            }
        }
    }
}