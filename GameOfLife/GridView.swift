

import SwiftUI


struct GridView: View {
    
    @EnvironmentObject var model: LifeGameModel
    @State private var timer = Timer.publish(every: LifeGameModel.refreshInterval, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        return VStack(spacing: .zero) {
            
            HStack(alignment: .top, spacing: .zero) {
                ForEach(0..<self.model.grid.columns, id: \.self) {
                    column in
                    
                    VStack(alignment: .leading, spacing: .zero) {
                        ForEach(0..<self.model.grid.rows, id: \.self) {
                            row in
                            
                            if let cell = self.model.cells.first(where: { $0 == GridCell(column: column, row: row) }) {
                                
                                CellView(cell: cell)
                                    .contextMenu {
                                        
                                        #if DEBUG
                                        
                                        Text("c\(column) r\(row)")
                                        
                                        Divider()
                                        
                                        Text("prediction:")
                                        let predictedCell = self.model.prediction(for: cell)
                                        Text((predictedCell.isAlive ?? false) ? "lives" : "dies")
                                        
                                        Divider()

                                        Text("neighbors:")
                                        let neighbors = self.model.neighbors(for: cell)
                                        ForEach(0..<neighbors.count, id: \.self) {
                                            index in
                                            let neighbor = neighbors[index]
                                            Text("\tc\(neighbor.column) r\(neighbor.row) \((neighbor.isAlive ?? false) ? "alive" : "dead")")
                                        }
                                        
                                        #endif
                                        
                                    }
                                
                            }
                            
                        }
                    }
                    
                }
            }
            .onReceive(timer) {
                _ in
                self.model.simulateLifecycle()
            }
            .padding(24.0)
            
            HStack {
                
                Button(action: {
                    self.timer = Timer.publish(every: LifeGameModel.refreshInterval, on: .main, in: .common).autoconnect()
                }, label: {
                    Image(systemName: "play.fill")
                })
                .help("run")
                
                Button(action: {
                    self.timer.upstream.connect().cancel()
                }, label: {
                    Image(systemName: "pause.fill")
                })
                .help("stop")
                
                Divider()
                
                Button(action: {
                    self.model.simulateLifecycle()
                }, label: {
                    Image(systemName: "forward.end.fill")
                })
                .help("step_forward")
                
            }
            .controlSize(.large)
            .padding([.bottom], 28.0)
            
        }
        .preferredColorScheme(.dark)
        
    }
    
}


