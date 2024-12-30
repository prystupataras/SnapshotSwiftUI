//
//  ContentView.swift
//  SnapshotSwiftUI
//
//  Created by Taras Prystupa on 30.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var trigger: Bool = false
    @State private var snapshot: UIImage?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0...20, id: \.self) {
                    Text("List Cell \(Int($0))")
                }
            }
            .navigationTitle("List View")
            .toolbar {
                ToolbarItem {
                    Button("Take Snapshot") {
                        trigger.toggle()
                    }
                }
            }
        }
        .snapshot(trigger: trigger) {
            snapshot = $0
        }
        .ignoresSafeArea()
        .overlay {
            if let  snapshot {
                Image(uiImage: snapshot)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        Rectangle()
                            .fill(.black.opacity(0.3))
                            .ignoresSafeArea()
                            .onTapGesture {
                                self.snapshot = nil
                            }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
