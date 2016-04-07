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
    
    var chunkedLayerData: [CGPoint: [[Int]]]
    let tileset: Tileset
    
    init(tilemap: IsometricTilemap, data: [[Int]], tileset: Tileset) {
        self.chunkedLayerData = [CGPointZero: data]
        self.tilemap = tilemap
        self.tileset = tileset
        
        super.init()
        
        // built starting chunk at (0,0)
        buildLayerForChunk(CGPointZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildNewChunk(chunk: CGPoint, layerData: [[Int]]) {
        chunkedLayerData[chunk] = layerData
        buildLayerForChunk(chunk)
    }
    
    /**
     * Construct and place SKSpriteNodes on the parent SKNode. Sprites are
     * generated based on the tile type in the layerData. Sprites are positioned
     * based on their position in the layerData array.
     */
    func buildLayerForChunk(chunk: CGPoint) {
        guard let layerData = chunkedLayerData[chunk] else {
            abort()
        }
        
        for i in 0..<layerData.count {
            for j in 0..<layerData[i].count {
                if let node = tileset[layerData[i][j]]?.spriteNode() {
                    // convert the array position to global coordinates
                    let chunkPosition = IsometricTilemap.translateFromChunkPosition(CGPoint(x: j, y: i), chunk: chunk)
                    // calculate position in SKNode
//                    node.position = tilemap.positionForPoint(CGPoint(x: j, y: i))
                    node.position = tilemap.positionForPoint(chunkPosition)
                    // zPosition based on how far down the screen the sprite is
                    node.zPosition = tilemap.tilemapSize.height - node.position.y
                    
                    addChild(node)
                }
            }
        }
    }
}

extension CGPoint: Hashable {
    public var hashValue: Int {
        return self.x.hashValue << sizeof(CGFloat) ^ self.y.hashValue
    }
}

// Hashable requires Equatable, so define the equality function for CGPoints.
public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return CGPointEqualToPoint(lhs, rhs)
}