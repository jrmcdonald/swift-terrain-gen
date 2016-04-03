//
//  CameraManager.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class CameraManager {
    
    let camera: SKCameraNode
    
    var previousScale: CGFloat = CGFloat(1.0)
    
    weak var tilemap: IsometricTilemap!
    
    init(position: CGPoint, tilemap: IsometricTilemap) {
        camera = SKCameraNode()
        camera.position = position
        self.tilemap = tilemap
    }
    
    func moveCamera(location: CGPoint, previousLocation: CGPoint) {
        let newY = camera.position.y - (location.y - previousLocation.y)
        let newX = camera.position.x - (location.x - previousLocation.x)
        
        let position = CGPoint(x: newX, y: newY)
        let tilemapPosition = tilemap.pointForPosition(position)
        
        if tilemapPosition.x >= 0.0 && tilemapPosition.x <= tilemap.mapSize.width {
            if tilemapPosition.y >= 0.0 && tilemapPosition.y <= tilemap.mapSize.height {
                camera.position = position
            }
        }
    }
    
    func zoomCamera(scale: CGFloat) {
        var deltaScale: CGFloat
        
        deltaScale = 1 - (previousScale - scale)
        deltaScale = min(deltaScale, 3.0 / camera.xScale)
        deltaScale = max(deltaScale, 0.6 / camera.xScale)
        
        let newScale = camera.xScale * deltaScale
        
        camera.setScale(newScale)
    }
    
    func zoomCameraAtLocation(scale: CGFloat, location: CGPoint) {
        zoomCamera(scale)
//        moveCamera(location, previousLocation: camera.position)
    }
}
