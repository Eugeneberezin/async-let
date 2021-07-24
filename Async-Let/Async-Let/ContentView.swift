//
//  ContentView.swift
//  Async-Let
//
//  Created by Eugene Berezin on 7/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var organizations = [Organization]()
    @State private var results = [Result]()
    
    var body: some View {
        List {
            Section("Organizations") {
                ForEach(organizations) { org in
                    Text(org.name)
                }
            }
            
            Section("Apps") {
                ForEach(results) {result in
                    Text(result.trackName)
                }
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        guard let orgURL = URL(string: "https://opencollective.com/webpack/members/organizations.json") else { return }
        guard let appsURL = URL(string: "https://itunes.apple.com/search?term=gr&entity=software") else { return }
        async let (orgData, _) = URLSession.shared.data(from: orgURL)
        async let (appsData, _) = URLSession.shared.data(from: appsURL)
        
        do {
            let decoder = JSONDecoder()
            
            let orgs = try await decoder.decode([Organization].self, from: orgData)
            organizations = orgs.suffix(3)
            
            let apps = try await decoder.decode(SearchResult.self, from: appsData)
            results = apps.results
            
        } catch {
            print("Failed to decode")
        }
        
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
