# Terrain Generation

## Description

2D isometric terrain generation for iOS with Swift. Uses simplex noise to generate a height map and then marching squares to determine tile borders and assign sprites.

Tile sprites are from http://opengameart.org/content/isometric-64x64-outside-tileset, modified to have grass/water transitions on a single tile.

Unless otherwise stated, code in this repository is available under the MIT License.

## Screenshots

To come...

## Issues

* Panning the camera is restricted to positive global co-ordinates.
* The same terrain is generated each time, need to add a seed system to the co-ordinates.
