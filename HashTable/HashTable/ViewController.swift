//
//  ViewController.swift
//  HashTable
//
//  Created by Kostas Filios on 5/1/20.
//  Copyright © 2020 Kostas Filios. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var linkedTest = LinkedList<Int>.end
        linkedTest.push(1)
        linkedTest.push(2)
        linkedTest.push(3)
        linkedTest.pop()
        
        var hashTest = HashTable<Int, String>(estCapacity: 4)
        hashTest["Name".djb2hash] = "kostas"
        hashTest["job".djb2hash] = "Mobile dev"
        hashTest["Pets".djb2hash] = "Cats"
        let name = hashTest["Name".djb2hash]
        let noInsert = hashTest["".djb2hash]
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

