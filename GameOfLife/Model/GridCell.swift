

import Foundation


struct GridCell: Equatable {
    
    let column: Int
    let row: Int
    var isAlive: Bool? = nil
    
    func isValid(in grid: Grid) -> Bool {
        // Are cell coordinates valid within the given grid?
        if self.column > grid.columns-1 || self.column < 0 {
            return false
        }
        if self.row > grid.rows-1 || self.row < 0 {
            return false
        }
        return true
    }
    
    static func ==(lhs: GridCell, rhs: GridCell) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
    
}
