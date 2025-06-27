//
//  Extensions.swift
//  SwiftUIAutoScrollingTabs
//
//  Created by 김정민 on 6/27/25.
//

import SwiftUI

extension [Product] {
    // Return the Array's First Product Type
    var type: ProductType {
        if let firstProduct = self.first {
            return firstProduct.type
        }
        
        return .iphone
    }
}

/// Scroll Content Offset
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offset(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .named(coordinateSpace))
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
}
