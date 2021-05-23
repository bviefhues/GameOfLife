

import Foundation


final class LifeGameModel: ObservableObject {
    
    
    let grid: Grid
    @Published var cells: [GridCell]
    static let refreshInterval = 1.0
    
    
    init() {
        self.grid = Grid(columns: 24, rows: 24)
        self.cells = self.grid.makeCells()
    }
    
    
    func simulateLifecycle() {
        var cells = [GridCell]()
        for cell in self.cells {
            let predictedCell = self.prediction(for: cell)
            cells.append(predictedCell)
        }
        self.cells = cells
    }
    
    
    func prediction(for cell: GridCell) -> GridCell {
        
        var cell = cell
        
        let neighbors = self.neighbors(for: cell)
        
        let neighborsAlive = neighbors.filter { $0.isAlive == true }
        
        if cell.isAlive == false && neighborsAlive.count == 3 {
            
            // Becomes alive
            cell.isAlive = true
            
        } else if cell.isAlive == true && neighborsAlive.count < 2 {
            
            // Dies of lonliness
            cell.isAlive = false
            
        } else if cell.isAlive == true && (neighborsAlive.count == 2 || neighborsAlive.count == 3) {
            
            // Stays alive
            cell.isAlive = true
            
        } else if cell.isAlive == true && neighborsAlive.count > 3 {
            
            // Dies of overpopulation
            cell.isAlive = false
            
        } else {
            
            // Stays dead
            cell.isAlive = false
            
        }
        
        return cell
        
    }
    
    
    func neighbors(for cell: GridCell) -> [GridCell] {
        
        let topCell = GridCell(column: cell.column, row: cell.row - 1)
        let bottomCell = GridCell(column: cell.column, row: cell.row + 1)
        
        let leftCell = GridCell(column: cell.column - 1, row: cell.row)
        let rightCell = GridCell(column: cell.column + 1, row: cell.row)
        
        let topLeftCell = GridCell(column: cell.column - 1, row: cell.row - 1)
        let topRightCell = GridCell(column: cell.column + 1, row: cell.row - 1)
        
        let bottomLeftCell = GridCell(column: cell.column - 1, row: cell.row + 1)
        let bottomRightCell = GridCell(column: cell.column + 1, row: cell.row + 1)
        
        let calculatedNeighbors: [GridCell] = [topCell, bottomCell, leftCell, rightCell, topLeftCell, topRightCell, bottomLeftCell, bottomRightCell]
        
        var neighbors = [GridCell]()
        for neighbor in calculatedNeighbors {
            
            if !neighbor.isValid(in: self.grid) {
                continue
            }
            
            if let cell = self.cells.first(where: { $0 == neighbor }) {
                neighbors.append(cell)
            }
        }
        
        return neighbors
        
    }
    
    
}

