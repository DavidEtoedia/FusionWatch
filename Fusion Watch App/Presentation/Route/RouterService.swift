//
//  RouterService.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 25/08/2023.
//

import Foundation


final class Router<T: Hashable>: ObservableObject {
    @Published var root: T
    @Published var paths: [T] = []
    @Published var values: [T: Any?] = [:]

    init(root: T) {
        self.root = root
    }

    func push(_ path: T, value: Any?) {
         paths.append(path)
         values[path] = value
     }
    
    func popUntil(predicate: (T) -> Bool) {
        if let last = paths.popLast() {
            guard predicate(last) else {
                popUntil(predicate: predicate)
                return
            }
        }
    }

    func pop() {
        paths.removeLast()
    }

    func updateRoot(root: T) {
        self.root = root
    }

    func popToRoot(){
       paths = []
    }
}

enum Path {
    case MainScreen
    case HistoryScreen
    case EnergyScreen
    case chartScreen
    case FlightScreen
    case LogisticsScreen
}
