//
//  ChannelListView.swift
//  OinkApp
//
//  Created by Joona Viertola on 29.4.2023.
//

import SwiftUI

struct ChannelListView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(menu) { section in
                    Section(section.name) {
                        ForEach(section.items) { item in
                            ChannelItemRow(item: item)
                        }
                    }
                }
            }
            .navigationTitle("Channels")
            .listStyle(.grouped)
        }
        
    }
    
    func deleteItems() {
        print("Delete")
    }
}

struct ChannelListView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelListView()
    }
}
