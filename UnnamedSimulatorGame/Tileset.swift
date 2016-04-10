//
//  Tileset.swift
//  UnnamedSimulatorGame
//
//  Created by Jamie McDonald on 29/03/2016.
//  Copyright © 2016 Qwyck. All rights reserved.
//

import Foundation
import SpriteKit

struct Tileset {
    
    weak var tilemap: IsometricTilemap!
    
    private let tiles: [Int: Tile]
    
    /**
     * Initialise a Tileset instance and load the tileset from the given plist file.
     *
     * - parameter tilemap: Tilemap
     * - parameter filename: String
     */
    init(tilemap: IsometricTilemap, filename: String) {
        self.tilemap = tilemap
        
        var tiles = [Int: Tile]()
        
        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")!
        let plistSet = NSDictionary(contentsOfFile: filePath)!
        
        for (k, v) in plistSet {
            let tileType = Int(k as! String)!
            let tileAttrs = v as! NSDictionary
            
            var tileDict = [String: String]()
            
            for (ak, av) in tileAttrs {
                let attrKey = ak as! String
                let attrVal = av as! String
                tileDict[attrKey] = attrVal
            }
            
            tiles[tileType] = Tile(id: tileType, attributes: tileDict, tilemap: tilemap)
        }
        
        self.tiles = tiles
    }
    
    func getTileForHeight(height: Double, layer: MapConstants.Layers) -> Int {
        var tilesInRange = [Int]()
        
        for (id, tile) in tiles {
            guard let tileLayer = tile["layer"],
                let minAttr = tile["minHeight"],
                let maxAttr = tile["maxHeight"],
                let min = Double(minAttr),
                let max = Double(maxAttr) else {
                    continue
            }
            
            if tileLayer == layer.rawValue && min..<max ~= height {
                tilesInRange.append(id)
            }
        }
        
        if tilesInRange.count > 0 {
            return tilesInRange[0]
        } else {
            print("No tiles matching height value.")
            return 0
        }
    }
    
    func getTileForMarch(march: Int, layer: MapConstants.Layers) -> Int {
        var tilesInRange = [Int]()
        
        for (id, tile) in tiles {
            guard let tileLayer = tile["layer"],
                let marchAttr = tile["marchValue"],
                let marchValue = Int(marchAttr) else {
                    continue
            }
            
            if tileLayer == layer.rawValue && marchValue == march {
                tilesInRange.append(id)
            }
        }
        
        if tilesInRange.count > 0 {
            return tilesInRange[0]
        } else {
            print("No tiles matching march value.")
            return 0
        }
    }
    
    subscript(tileType: Int) -> Tile? {
        get {
            return tiles[tileType]
        }
    }
    
}
