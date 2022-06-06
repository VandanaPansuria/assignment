//
//  Dynamic.swift
//  assignment
//
//  Created by MacV on 06/06/22.
//

import Foundation
/// Dynamic Used for Data Parsing from ViewModel to View
class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener = Array<Listener?>()

    func bind(listener: Listener?) {
        self.listener.append(listener)
    }

    func bindAndFire(listener: Listener?) {
        self.listener.append(listener)
        listener?(value)
    }

    var value: T {
        didSet {
            self.listener.forEach { (listener) in
                listener?(value)
            }
        }
    }

    init(_ v: T) {
        value = v
    }
}
