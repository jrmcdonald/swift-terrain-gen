//
//  IsometricTilemap.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class IsometricTilemap: SKNode {
    
    let mapSize: CGSize
    
    var tilemapSize: CGSize {
        get {
            let width = MapConstants.tileSize.width * (mapSize.height + mapSize.width) / 2.0
            let height = MapConstants.tileSize.height * (mapSize.height + mapSize.width) / 2.0
            
            return CGSize(width: width, height: height)
        }
    }
    
    override init() {
        self.mapSize = MapConstants.chunkSize
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tileShapeNode() -> SKShapeNode {
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0.0, -MapConstants.tileSize.height / 2.0)
        CGPathAddLineToPoint(path, nil, MapConstants.tileSize.width / 2.0, 0.0)
        CGPathAddLineToPoint(path, nil, 0.0, MapConstants.tileSize.height / 2.0)
        CGPathAddLineToPoint(path, nil, -MapConstants.tileSize.width / 2.0, 0.0)
        CGPathCloseSubpath(path)
        
        return SKShapeNode(path: path, centered: true)
    }
    
    func positionForPoint(point: CGPoint) -> CGPoint {
        let x = (point.x - point.y) * MapConstants.tileSize.width / 2.0
        let y = tilemapSize.height - (point.x + point.y) * MapConstants.tileSize.height / 2.0
        
        return CGPoint(x: x, y: y)
    }
    
    func pointForPosition(position: CGPoint) -> CGPoint {
        let xs = position.x
        let ys = tilemapSize.height - position.y
        
        let tileWidthHalf = MapConstants.tileSize.width / 2.0
        let tileHeightHalf = MapConstants.tileSize.height / 2.0
        
        let x = floor(((xs + tileWidthHalf) / tileWidthHalf + ys / tileHeightHalf) / 2.0)
        let y = floor(((ys + tileHeightHalf) / tileHeightHalf - xs / tileWidthHalf) / 2.0)
        
        return CGPoint(x: x, y: y)
    }
    
    static func translateFromChunkPosition(point: CGPoint, chunk: CGPoint) -> CGPoint {
        let dX = chunk.x * MapConstants.chunkSize.width
        let dY = chunk.y * MapConstants.chunkSize.height
        
        let x = chunk.x < 0 ? MapConstants.chunkSize.width - (point.x + 1) : point.x
        let y = chunk.y < 0 ? MapConstants.chunkSize.height - (point.y + 1) : point.y
        
        return CGPoint(x: dX + x, y: dY + y)
    }
}
