//
//  AdviceSelectorApp.swift
//  AdviceSelector
//
//  Created by Madison Dellamea on 2022-11-04.
//

import SwiftUI

@main
struct AdviceSelectorApp: App {
    
    @State private var savedAdvice: [SavedAdvice] = [] // empty
    
    var body: some Scene {
        WindowGroup {
            TabView {
                // Loose ends. (Models aren't done correctly, which correspond to ContentView)
                ContentView(savedAdvice: $savedAdvice)
                    .tabItem {
                        Image(systemName: "swatchpalette")
                        Text("Browse")
                    }
                
                SavedAdviceView(savedAdvice: $savedAdvice)
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Review")
                    }
                
            }
        }
    }
}
