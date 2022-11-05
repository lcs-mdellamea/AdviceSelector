//
//  ContentView.swift
//  AdviceSelector
//
//  Created by Madison Dellamea on 2022-11-04.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var currentAdvice: Advice = Advice(id: "",
                                       advice: "Don't give up...",
                                       status: 0)
    
    @State var favorites: [Advice] = []   // empty list to start
    
    @State var currentAdviceAddedTofavorites: Bool = false
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            Text(currentAdvice.advice)
                .font(.title)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            
            Image(systemName: "heart.circle")
                .font(.largeTitle)
                //                      CONDITION                        true   false
                .foregroundColor(currentAdviceAddedTofavorites == true ? .red : .secondary)
                .onTapGesture {
                    
                    // Only add to the list if it is not already there
                    if currentAdviceAddedTofavorites == false {
                        
                        // Adds the current advice to the list
                        favorites.append(currentAdvice)
                        
                        // Record that we have marked this as a favorite
                        currentAdviceAddedTofavorites = true

                    }
                    
                }
            
            Button(action: {
                
                Task {
                    await loadNewAdvice()
                }
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("favorites")
                    .bold()
                
                Spacer()
            }
            
            List(favorites, id: \.self) { currentfavorite in
                Text(currentfavorite.advice)
            }
            
            Spacer()
                        
        }
        
        .task {
            
            await loadNewAdvice()
            
            print("I tried to load new advice")
        }
        .navigationTitle("icanhazAdvice?")
        .padding()
    }
    
    func loadNewAdvice() async {
        let url = URL(string: "https://api.adviceslip.com/advice")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        let urlSession = URLSession.shared
        
        do {
            
            let (data, _) = try await urlSession.data(for: request)
            
            currentAdvice = try JSONDecoder().decode(Advice.self, from: data)
            
            currentAdviceAddedTofavorites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            
            print(error)
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
