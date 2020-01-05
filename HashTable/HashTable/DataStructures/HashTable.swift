//
//  HashTable.swift
//  MyProgress
//
//  Created by Kostas Filios on 3/1/20.
//  Copyright © 2020 Kostas Filios. All rights reserved.
//

import Foundation

public struct HashTable<Key: Hashable, Value> {
    private typealias Item = (key: Key, value: Value)
    private typealias Element = (key: Key, linkedList: LinkedList<Item>)
    private var buckets = ContiguousArray<Element?>()
    
    private(set) public var count = 0
    private var capacity = 1
    public var isEmpty: Bool {
        return count == 0
    }
    
    init(estCapacity: Int) {
        capacity = estCapacity
        for _ in 0...capacity {
            buckets.append(nil)
        }
    }
    
    // 1
    public subscript(key: Key) -> Value? {
        mutating get {
            return value(for: key)
        }
        
        set {
            if let value = newValue {
                update(value: value, for: key)
            }
        }
    }
    
    // 2
    private mutating func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        guard index < buckets.endIndex else {
            return nil
        }
        return find(key: key, at: buckets[index]?.linkedList)
    }
    
    private mutating func update(value: Value, for key: Key) {
        let index = self.index(for: key)
        let item = (key, value)
        count += 1
        if index >= buckets.endIndex {
            for i in 0...index {
                guard buckets.endIndex > i else {
                    buckets.append(nil)
                    continue
                }
            }
        }
        var linkedList = buckets[index]?.linkedList ?? LinkedList<Item>.end
        linkedList.push(item)
        buckets[index] = (key, linkedList)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue % capacity)
    }
    
    private func find(key: Key, at linkedList: LinkedList<Item>?) -> Value? {
        guard let linkedList = linkedList else {
            return nil
        }
        let listNode = linkedList.get()
        guard (listNode.item?.key == key) else {
            return find(key: key, at: listNode.tail)
        }
        return listNode.item?.value
    }

}

extension String {
    var djb2hash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }

    var sdbmhash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(0) {
            (Int($1) &+ ($0 << 6) &+ ($0 << 16)).addingReportingOverflow(-$0).partialValue
        }
    }
}

