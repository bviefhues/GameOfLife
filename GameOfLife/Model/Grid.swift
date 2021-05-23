

import Foundation


struct Grid {
    
    let columns: Int
    let rows: Int
    
    func makeCells() -> [GridCell] {
        var cells = [GridCell]()
        for column in 0..<columns {
            for row in 0..<rows {
                let cell = GridCell(column: column, row: row, isAlive: Bool.random())
                cells.append(cell)
            }
        }
        return cells
    }
    
}
