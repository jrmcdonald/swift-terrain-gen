//
//  SpriteLayer.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteLayer: SKNode {
    
    weak var tilemap: IsometricTilemap!
    
    let layerData: [[Int]]
    let tileset: Tileset
    
    init(tilemap: IsometricTilemap, data: [[Int]], tileset: Tileset) {
        self.tilemap = tilemap
        self.layerData = data
        self.tileset = tileset
        
        super.init()
        
        buildLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * Construct and place SKSpriteNodes on the parent SKNode. Sprites are
     * generated based on the tile type in the layerData. Sprites are positioned
     * based on their position in the layerData array.
     */
    func buildLayer() {
        for i in 0..<layerData.count {
            for j in 0..<layerData[i].count {
                if let node = tileset[layerData[i][j]]?.spriteNode() {
                    node.position = tilemap.positionForPoint(CGPoint(x: j, y: i))
                    // zPosition based on how far down the screen the sprite is
                    node.zPosition = tilemap.tilemapSize.height - node.position.y
                    
                    addChild(node)
                }
            }
        }
    }
}