//
//  Home.swift
//  SwiftUIAutoScrollingTabs
//
//  Created by 김정민 on 6/23/25.
//

import SwiftUI

struct Home: View {
    
    /// View Properties
    @State private var activeTab: ProductType = .iphone
    @Namespace private var animation
    
    var body: some View {
        /// For Auto Scrolling Content's
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                /// Lazy Stack For Pinning View at Top While Scrolling
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                    } header: {
                        ScrollableTabs()
                    }
                }
            }
        }
        .navigationTitle("Apple Store")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.purple), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    /// Scrollable Tabs
    @ViewBuilder
    func ScrollableTabs() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(ProductType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        /// Active Tab Indicator
                        .background(alignment: .bottom, content: {
                            if activeTab == type {
                                Capsule()
                                    .fill(.white)
                                    .frame(height: 5)
                                    .padding(.horizontal, -5)
                                    .offset(y: 15)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                        })
                        .padding(.horizontal, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                activeTab = type
                            }
                        }
                }
            }
            .padding(.vertical, 15)
        }
        .background {
            Rectangle()
                .fill(Color(.purple))
                .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

#Preview {
    ContentView()
}
