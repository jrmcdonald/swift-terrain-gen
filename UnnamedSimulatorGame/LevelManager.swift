//
//  LevelManager.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 30/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class LevelManager {
    
    weak var tilemap: IsometricTilemap!
    
    let tileset: Tileset
    
    init(tilemap: IsometricTilemap) {
        self.tilemap = tilemap
        
        tileset = Tileset(tilemap: tilemap, filename: "Tileset")
        
        let terrainData = generateTerrain(CGPointZero)
        let terrainLayer = SpriteLayer(tilemap: tilemap, data: terrainData, tileset: tileset)
        terrainLayer.zPosition = -1
        tilemap.addChild(terrainLayer)
        
        var nextTerrainData = generateTerrain(CGPoint(x: -1, y: -1))
        terrainLayer.buildChunk(CGPoint(x: -1, y: -1), data: nextTerrainData)
        
        nextTerrainData = generateTerrain(CGPoint(x: -1, y: 0))
        terrainLayer.buildChunk(CGPoint(x: -1, y: 0), data: nextTerrainData)
        
        nextTerrainData = generateTerrain(CGPoint(x: 0, y: -1))
        terrainLayer.buildChunk(CGPoint(x: 0, y: -1), data: nextTerrainData)
        
        nextTerrainData = generateTerrain(CGPoint(x: 1, y: 0))
        terrainLayer.buildChunk(CGPoint(x: 1, y: 0), data: nextTerrainData)
        
        nextTerrainData = generateTerrain(CGPoint(x: 0, y: 1))
        terrainLayer.buildChunk(CGPoint(x: 0, y: 1), data: nextTerrainData)
        
        nextTerrainData = generateTerrain(CGPoint(x: 1, y: 1))
        terrainLayer.buildChunk(CGPoint(x: 1, y: 1), data: nextTerrainData)
    }
    
    func mapTerrainTiles(n: Double) -> Int {
        switch n {
        case _ where n <= 0.5:
            return 1
        default:
            return 2
        }
    }
    
    func generateTerrain(chunk: CGPoint) -> [[Int]] {
        let width = Int(MapConstants.chunkSize.width)
        let height = Int(MapConstants.chunkSize.height)
        
        var terrain = Array(count: width, repeatedValue: Array(count: height, repeatedValue: 0))
        
        let simplex = SimplexNoise()
        
        let noise = simplex.generatedNoise(chunk, octaves: 3, roughness: 0.6, scale: 0.008)
        
        for x in 0..<noise.count {
            for y in 0..<noise[x].count {
                terrain[x][y] = mapTerrainTiles(noise[x][y])
            }
        }
                
        return terrain
    }
}
