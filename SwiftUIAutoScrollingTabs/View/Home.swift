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
    @State private var productsBasedOnType: [[Product]] = []
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        /// For Auto Scrolling Content's
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                /// Lazy Stack For Pinning View at Top While Scrolling
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(productsBasedOnType, id: \.self) { products in
                            ProductSectionView(products)
                        }
                    } header: {
                        ScrollableTabs(proxy)
                    }
                }
            }
        }
        /// For Scroll Content Offset Detection
        .coordinateSpace(name: "CONTENTVIEW")
        .navigationTitle("Apple Store")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.purple), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .background {
            Rectangle()
                .fill(Color(.systemGray6))
                .ignoresSafeArea()
        }
        .onAppear {
            /// Filtering Products Based on Product Type (Only Once)
            guard productsBasedOnType.isEmpty else { return }
            
            for type in ProductType.allCases {
                let products = products.filter { $0.type == type }
                productsBasedOnType.append(products)
            }
        }
    }
    
    /// Products Sectioned View
    @ViewBuilder
    func ProductSectionView(_ products: [Product]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            /// Safe Check
            if let firstProduct = products.first {
                Text(firstProduct.type.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            
            ForEach(products) { product in
                ProductRowView(product)
            }
        }
        .padding(15)
        /// - For Auto Scrolling VIA ScrollViewProxy
        .id(products.type)
        .offset("CONTENTVIEW") { rect in
            let minY = rect.minY
            /// Whene the content reaches it's top then updating the current active Tab
            if (minY < 30 && minY < (rect.midY / 2) && activeTab != products.type) && animationProgress == 0 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    /// Safety Check
                    activeTab = (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.type)
                    ? products.type
                    : activeTab
                }
            }
        }
    }
    
    /// Product Row View
    @ViewBuilder
    func ProductRowView(_ product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white)
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title3)
                
                Text(product.subtitle)
                    .font(.callout)
                    .foregroundStyle(Color.gray)
                
                Text(product.price)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.purple)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Scrollable Tabs
    @ViewBuilder
    func ScrollableTabs(_ proxy: ScrollViewProxy) -> some View {
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
                        /// Scrolling tabs when ever the active tab is updated
                        .id(type.tabID)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                activeTab = type
                                animationProgress = 1.0
                                /// Scrolling to the selected content
                                proxy.scrollTo(type, anchor: .topLeading)
                            }
                        }
                }
            }
            .padding(.vertical, 15)
            .onChange(of: activeTab) { oldValue, newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    proxy.scrollTo(newValue.tabID, anchor: .center)
                }
            }
            .checkAnimationEnd(for: animationProgress) {
                /// Resetting to default when the animation was finished
                animationProgress = 0.0
            }
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
