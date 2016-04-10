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
        
        // Create initial set of chunks
        var chunks: [CGPoint: [[Int]]] = [:]
        chunks[CGPointZero] = generateTerrain(CGPointZero)
        chunks[CGPoint(x: -1, y: -1)] = generateTerrain(CGPoint(x: -1, y: -1))
        chunks[CGPoint(x: -1, y: 0)] = generateTerrain(CGPoint(x: -1, y: 0))
        chunks[CGPoint(x: 0, y: -1)] = generateTerrain(CGPoint(x: 0, y: -1))
        chunks[CGPoint(x: 0, y: 1)] = generateTerrain(CGPoint(x: 0, y: 1))
        chunks[CGPoint(x: 1, y: 0)] = generateTerrain(CGPoint(x: 1, y: 0))
        chunks[CGPoint(x: 1, y: 1)] = generateTerrain(CGPoint(x: 1, y: 1))
        chunks[CGPoint(x: 1, y: -1)] = generateTerrain(CGPoint(x: 1, y: -1))
        chunks[CGPoint(x: -1, y: 1)] = generateTerrain(CGPoint(x: -1, y: 1))
        
        let height = Int(MapConstants.chunkSize.height) * 3
        let width = Int(MapConstants.chunkSize.width) * 3

        var shiftedTerrain: [[Int]] = Array(count: height, repeatedValue: Array(count: width, repeatedValue: 0))
        
        // Merge all the terrain data into a single array and shift the co-ordinates into positive space
        // The shift is done to prevent direction issues with marched terrain and negative co-ordinates
        // TODO: properly calculate the shift distance, should be the distance from the furthest negative point to (0,0)
        let shiftDistance: CGFloat = 32.0
        
        for (chunk, terrain) in chunks {
            for i in 0..<terrain.count {
                for j in 0..<terrain[i].count {
                    let point = IsometricTilemap.translateFromChunkPosition(CGPoint(x: j, y: i), chunk: chunk)
                    let sX = Int(point.x + shiftDistance)
                    let sY = Int(point.y + shiftDistance)
                    shiftedTerrain[sY][sX] = terrain[i][j]
                }
            }
        }

        // Generate tile transitions
        let transitions = MarchingSquares.march(shiftedTerrain)
        
        for i in 0..<transitions.count {
            for j in 0..<transitions[i].count {
                let tileId = tileset.getTileForMarch(transitions[i][j], layer: MapConstants.Layers.Terrain)
                // Shift the point back back to it's original co-ordinates
                let sX = CGFloat(j) - shiftDistance
                let sY = CGFloat(i) - shiftDistance
                // Work out which chunk the point came from
                let chunk = CGPoint(x: floor(sX / MapConstants.chunkSize.width), y: floor(sY / MapConstants.chunkSize.height))
                let point = IsometricTilemap.translateToChunkPosition(CGPoint(x: sX, y: sY), chunk: chunk)
                // Update the tileId in the original chunk
                chunks[chunk]![Int(point.y)][Int(point.x)] = tileId
            }
        }
        
        let terrainLayer = SpriteLayer(tilemap: tilemap, tileset: tileset)
        terrainLayer.zPosition = -1
        tilemap.addChild(terrainLayer)
        
        for (chunk, terrain) in chunks {
            terrainLayer.buildChunk(chunk, data: terrain)
        }
    }
    
    func generateTerrain(chunk: CGPoint) -> [[Int]] {
        let width = Int(MapConstants.chunkSize.width)
        let height = Int(MapConstants.chunkSize.height)
        
        let simplex = SimplexNoise()
        let noise = simplex.generatedNoise(chunk, octaves: 3, roughness: 0.6, scale: 0.008)
        
        var terrain = Array(count: width, repeatedValue: Array(count: height, repeatedValue: 0))
        for i in 0..<noise.count {
            for j in 0..<noise[i].count {
                terrain[i][j] = tileset.getTileForHeight(noise[i][j], layer: MapConstants.Layers.Terrain)
            }
        }
        
        return terrain
    }
    
    func prettyPrint2d(arr: [[Int]]) {
        for i in 0..<arr.count {
            for j in 0..<arr[i].count {
                print("\(arr[i][j])", terminator:"")
                if (j != (arr[i].count - 1)) {
                    print(", ", terminator:"")
                }
            }
            print("")
        }
    }
}
