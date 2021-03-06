//
//  GameScene.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright (c) 2016 Qwyck. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    var tilemap: IsometricTilemap!
    var cameraManager: CameraManager!
    var levelManager: LevelManager!
    
    var highlight: SKShapeNode!
    
    override func didMoveToView(view: SKView) {
        tilemap = IsometricTilemap()
        addChild(tilemap)
        
        levelManager = LevelManager(tilemap: tilemap)
        
        cameraManager = CameraManager(position: tilemap.positionForPoint(CGPointZero), tilemap: tilemap)
        camera = cameraManager.camera
        tilemap.addChild(cameraManager.camera)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: .handlePinch)
        pinchGesture.delegate = self
        self.view?.addGestureRecognizer(pinchGesture)
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
        if sender.numberOfTouches() == 2 {
            let locationInView = sender.locationInView(self.view)
            if sender.state == .Changed {
                cameraManager.zoomCameraAtLocation(sender.scale, location: locationInView)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let tilemapPosition = touch.locationInNode(tilemap)
//        print(tilemap.pointForPosition(tilemapPosition))
//        highlight.position = tilemap.positionForPoint(tilemap.pointForPosition(tilemapPosition))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let previousLocation = touch.previousLocationInNode(self)
            
            cameraManager.moveCamera(location, previousLocation: previousLocation)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}

private extension Selector {
    static let handlePinch = #selector(GameScene.handlePinch(_:))
}
