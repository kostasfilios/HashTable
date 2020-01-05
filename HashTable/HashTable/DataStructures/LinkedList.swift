//
//  LinkedList.swift
//  MyProgress
//
//  Created by Kostas Filios on 3/1/20.
//  Copyright © 2020 Kostas Filios. All rights reserved.
//

import Foundation

enum LinkedList<T> {
    case end
    indirect case node(T, LinkedList<T>)
}

extension LinkedList {
    mutating func push(_ item: T) {
        self = self.add(item)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        switch self {
        case .end:
            return nil
        case  let .node(item, tail):
            self = tail
            return item
        }
    }
    
    func get() -> (item: T?, tail: LinkedList?) {
        switch self {
        case .end:
            return (nil, nil)
        case  let .node(item, tail):
            return (item, tail)
        }
    }
    
    private func add(_ item: T) -> LinkedList<T> {
        switch self {
        case .end:
            return .node(item, .end)
        case .node(_, _):
            return .node(item, self)
        }
    }
}
