//
//  ContentView.swift
//  SwiftUIAutoScrollingTabs
//
//  Created by 김정민 on 6/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
