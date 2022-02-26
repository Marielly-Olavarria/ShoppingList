//
//  Categories.swift
//  ShoppingList
//
//  Created by Jonatan Ortiz on 25/02/22.
//

import Foundation

enum Categories: Int, CaseIterable {
    case hortiFruti = 0, meat = 1, frozen = 2, cleaning = 3, hygiene = 4
    
    var name: String {
        switch self {
        case .hortiFruti:
            return "HortiFruti"
        case .meat:
            return "Carnes"
        case .frozen:
            return "Congelados"
        case .cleaning:
            return "Limpeza"
        case .hygiene:
            return "Higiene"
        }
    }
    
//    func checkNewCategories() {
//        if let ca = categoriesArray {
//            if ca.count < Categories.allCases.count {
//                
//            }
//        }
//    }
//    
//    func checkRemovedCategories() {
//        
//    }
    
}
