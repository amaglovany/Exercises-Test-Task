//
//  Exercise.swift
//  Exercises
//
//  Created by amaglovany on 8/28/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import Foundation

class Exercise {
    static func titleAtIndex(_ index: Int) -> String {
        return "Exercise #\(index + 1)"
    }
    
    var sets = [ExerciseSet]()
}
