//
//  Box.swift
//  MVVMDemo
//
//  Created by Prashant on 15/03/18.
//

import Foundation

class Box <T> {
    typealias Listener = (T) -> Void
    
    var listener:Listener?
    var value : T {
        didSet {
            listener?(value)
        }
    }
    
    init(value:T) {
        self.value = value
    }
    
    func bind (listner:Listener?) {
        self.listener = listner
        listner?(value)
    }
    
}
