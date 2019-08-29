//
//  ExerciseSet.swift
//  Exercises
//
//  Created by amaglovany on 8/28/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import UIKit

class ExerciseSet {
    
    static func titleAtIndex(_ index: Int) -> String {
        return "Set #\(index + 1)"
    }
    
    let type: SetType
    
    init(_ type: SetType) {
        self.type = type
    }
    
    enum SetType: CaseIterable {
        case regular
        case warmUp
        
        var title: String {
            switch self {
            case .regular:
                return "Regular"
            case .warmUp:
                return "Warm-up"
            }
        }
        
        var color: UIColor {
            switch self {
            case .regular:
                return .blue
            case .warmUp:
                return .orange
            }
        }
    }
}
