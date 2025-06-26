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
                        ScrollableTabs()
                    }
                }
            }
        }
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
