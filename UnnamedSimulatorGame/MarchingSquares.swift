/*
 Algorithm for generating terrain transitions using Marching Squares.
 Based on this post by VortexCortex at Project Retrograde.
 
 http://blog.project-retrograde.com/2013/05/marching-squares/
 
 This is free and unencumbered software released into the public domain.
 
 Anyone is free to copy, modify, publish, use, compile, sell, or
 distribute this software, either in source code form or as a compiled
 binary, for any purpose, commercial or non-commercial, and by any
 means.
 
 In jurisdictions that recognize copyright laws, the author or authors
 of this software dedicate any and all copyright interest in the
 software to the public domain. We make this dedication for the benefit
 of the public at large and to the detriment of our heirs and
 successors. We intend this dedication to be an overt act of
 relinquishment in perpetuity of all present and future rights to this
 software under copyright law.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 For more information, please refer to <http://unlicense.org>
 
 */

import Foundation

class MarchingSquares {    
    static func march(map: [[Int]]) -> [[Int]] {
        var metadata = Array(count: map.count + 1, repeatedValue: Array(count: map[0].count + 1, repeatedValue: 0))
        var march = Array(count: map.count, repeatedValue: Array(count: map[0].count, repeatedValue: 0))
        
        var x, y : Int
        
        for i in 0..<metadata.count {
            for j in 0..<metadata.count {
                x = i >= map.count ? i - 1 : i
                y = j >= map[x].count ? j - 1 : j
                metadata[i][j] = map[x][y]
            }
        }
        
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                let sTL : Int = metadata[i][j]
                let sTR : Int = metadata[i + 1][j]
                let sBL : Int = metadata[i][j + 1]
                let sBR : Int = metadata[i + 1][j + 1]
                
                let hTL = sTL >> 1;
                let hTR = sTR >> 1;
                let hBL = sBL >> 1;
                let hBR = sBR >> 1;
                
                let saddle = ( (sTL & 1) + (sTR & 1) + (sBL & 1) + (sBR & 1) + 1 ) >> 2;
                let shape = (hTL & 1) | (hTR & 1) << 1 | (hBL & 1) << 2 | (hBR & 1) << 3;
                let ring = ( hTL + hTR + hBL + hBR ) >> 2;
                march[i][j] = shape | (saddle << 4) | (ring << 5);
            }
        }
        
        return march
    }
}
