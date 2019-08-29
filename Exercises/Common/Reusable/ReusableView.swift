//
//  ReusableView.swift
//  Exercises
//
//  Created by amaglovany on 8/28/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import UIKit

public protocol ReusableView {
    static var identifier: String { get }
    static var nibName: String? { get }
    static var nib: UINib? { get }
}

public extension ReusableView {
    static var identifier: String { return String(describing: self) }
    
    static var nibName: String? { return String(describing: self) }
    
    static var nib: UINib? {
        if let nibName = nibName, let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: Bundle.main)
        }
        return nil
    }
}
