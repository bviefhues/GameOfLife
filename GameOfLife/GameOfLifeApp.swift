

import SwiftUI


@main
struct GameOfLifeApp: App {
    
    @StateObject private var model: LifeGameModel = LifeGameModel()
    
    var body: some Scene {
        WindowGroup {
            GridView()
                .environmentObject(self.model)
        }
    }
    
}
