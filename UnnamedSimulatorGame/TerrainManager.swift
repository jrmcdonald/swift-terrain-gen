//
//  TerrainManager.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 30/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

class TerrainManager {
    static func generateTerrain(size: CGSize) -> [[Int]] {
        var terrainData: [[Int]] = []
        
        for row in 0..<Int(size.height) {
            terrainData.append([Int]())
            for _ in 0..<Int(size.width) {
                terrainData[row].append(1)
            }
        }
        
        return terrainData
    }
}
