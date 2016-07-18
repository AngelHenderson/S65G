//: Playground - noun: a place where people can play

import UIKit

var rows = 10
var cols = 10
typealias Position = (row:Int, col:Int)

let offsets:[Position] = [
(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]

func neighbors(pos: Position) -> [Position] {
    return offsets.map { ((pos.row + rows + $0.row) % rows, (pos.col + cols + $0.col) % cols)}
}