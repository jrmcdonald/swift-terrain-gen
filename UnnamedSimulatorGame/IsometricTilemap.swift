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
    let tileSize: CGSize
    
    private let tileWidth: CGFloat
    private var tileHeight: CGFloat {
        get {
            return floor(tileWidth / 2.0)
        }
    }
    
    var tilemapSize: CGSize {
        get {
            let width = tileWidth * (mapSize.height + mapSize.width) / 2.0
            let height = tileHeight * (mapSize.height + mapSize.width) / 2.0
            
            return CGSize(width: width, height: height)
        }
    }
    
    init(mapSize: CGSize, tileWidth: CGFloat) {
        self.mapSize = mapSize
        self.tileWidth = tileWidth
        self.tileSize = CGSize(width: tileWidth, height: floor(tileWidth / 2.0))
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tileShapeNode() -> SKShapeNode {
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0.0, -tileHeight / 2.0)
        CGPathAddLineToPoint(path, nil, tileWidth / 2.0, 0.0)
        CGPathAddLineToPoint(path, nil, 0.0, tileHeight / 2.0)
        CGPathAddLineToPoint(path, nil, -tileWidth / 2.0, 0.0)
        CGPathCloseSubpath(path)
        
        return SKShapeNode(path: path, centered: true)
    }
    
    func positionForPoint(point: CGPoint) -> CGPoint {
        let x = (point.x - point.y) * tileWidth / 2.0
        let y = tilemapSize.height - (point.x + point.y) * tileHeight / 2.0
        
        return CGPoint(x: x, y: y)
    }
    
    func pointForPosition(position: CGPoint) -> CGPoint {
        let xs = position.x
        let ys = tilemapSize.height - position.y
        
        let tileWidthHalf = tileWidth / 2.0
        let tileHeightHalf = tileHeight / 2.0
        
        let x = floor(((xs + tileWidthHalf) / tileWidthHalf + ys / tileHeightHalf) / 2.0)
        let y = floor(((ys + tileHeightHalf) / tileHeightHalf - xs / tileWidthHalf) / 2.0)
        
        return CGPoint(x: x, y: y)
    }
}
