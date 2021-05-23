

import SwiftUI


struct CellView: View {
    
    var cell: GridCell
    
    private var foregroundColor: Color {
        if let isAlive = self.cell.isAlive {
            return isAlive ? Color.green : Color(NSColor.windowBackgroundColor)
        } else {
            return Color.red
        }
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(foregroundColor)
            .frame(width: 11.0, height: 11.0)
            .overlay(
                Rectangle()
                    .strokeBorder(Color.black.opacity(0.3), lineWidth: 0.5, antialiased: true)
            )
            .help("c\(cell.column) r\(cell.row)")
    }
    
}


struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        CellView(cell: GridCell(column: 0, row: 0, isAlive: true))
        CellView(cell: GridCell(column: 0, row: 0, isAlive: false))
    }
    
}
