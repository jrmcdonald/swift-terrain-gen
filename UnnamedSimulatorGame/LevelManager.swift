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
    
    private static func mapTerrainTiles(n: Double) -> Int {
        switch n {
        case _ where n <= 0.5:
            return 1
        default:
            return 2
        }
    }
    
    static func generateTerrain(size: CGSize) -> [[Int]] {
        let width : Int = Int(size.width)
        let height: Int = Int(size.height)
        
        var terrain: [[Int]] = Array(count: width, repeatedValue: Array(count: height, repeatedValue: 0))
        
        let simplex : SimplexNoise = SimplexNoise()
        
        let noise : [[Double]] = simplex.generatedNoise(height, width: width, octaves: 3, roughness: 0.6, scale: 0.008)
        
        for x in 0..<noise.count {
            for y in 0..<noise[x].count {
                terrain[x][y] = mapTerrainTiles(noise[x][y])
            }
        }
                
        return terrain
    }
}
