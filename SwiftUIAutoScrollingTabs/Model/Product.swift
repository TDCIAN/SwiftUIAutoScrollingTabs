//
//  Product.swift
//  SwiftUIAutoScrollingTabs
//
//  Created by 김정민 on 6/23/25.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    var id: UUID = UUID()
    var type: ProductType
    var title: String
    var subtitle: String
    var price: String
    var productImage: String = ""
}

enum ProductType: String, CaseIterable {
    case iphone = "iPhone"
    case ipad = "iPad"
    case macbook = "MacBook"
    case desktop = "Mac Desktop"
    case appleWatch = "Apple Watch"
    case airpods = "Airpods"
}

var products: [Product] = [
    /// Apple Watch
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Ultra: Alphine Loop", price: "$999", productImage: "image1"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 8: Black", price: "$599", productImage: "image2"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 6: Red", price: "$399", productImage: "image3"),
    Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 4: Black", price: "$250", productImage: "image4"),
    
    /// iPhone's
    Product(type: .iphone, title: "iPhone 14 Pro Max", subtitle: "A16 - Purple", price: "$1299", productImage: "image5"),
    Product(type: .iphone, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "image6"),
    Product(type: .iphone, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "image7"),
    Product(type: .iphone, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "image8"),
    Product(type: .iphone, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399", productImage: "image9"),
    
    /// MacBook's
    Product(type: .macbook, title: "MacBook Pro 16", subtitle: "M2 Max - Silver", price: "$2499", productImage: "image10"),
    Product(type: .macbook, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "image11"),
    Product(type: .macbook, title: "MacBook Air", subtitle: "M1 - Gold", price: "$999", productImage: "image12"),
    
    /// iPad's
    Product(type: .ipad, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999", productImage: "1"),
    Product(type: .ipad, title: "iPad Air 4", subtitle: "A14 - Pink", price: "$699", productImage: "2"),
    Product(type: .ipad, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599", productImage: "3"),
    
    /// Desktop's
    Product(type: .desktop, title: "Mac Studio", subtitle: "M1 Max - Silver", price: "$1999", productImage: "4"),
    Product(type: .desktop, title: "Mac Mini", subtitle: "M2 Pro - Space Grey", price: "$999", productImage: "5"),
    Product(type: .desktop, title: "iMac", subtitle: "M1 - Purple", price: "$1599", productImage: "6"),
    
    /// Airpods
    Product(type: .airpods, title: "Airpods", subtitle: "Pro 2nd Gen", price: "$249", productImage: "7"),
    Product(type: .airpods, title: "Airpods", subtitle: "3rd Gen", price: "$179", productImage: "8"),
    Product(type: .airpods, title: "Airpods", subtitle: "2nd Gen", price: "$129", productImage: "9"),
]
