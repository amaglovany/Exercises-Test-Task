//
//  ReusableTableViewCell.swift
//  Exercises
//
//  Created by amaglovany on 8/28/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func register(_ cellType: UITableViewCell.Type) {
        if let nib = cellType.nib {
            register(nib, forCellReuseIdentifier: cellType.identifier)
        } else {
            register(cellType, forCellReuseIdentifier: cellType.identifier)
        }
    }
    
    func dequeueReusableCellFor<Cell>(_ indexPath: IndexPath) -> Cell where Cell : UITableViewCell {
        return dequeueReusableCell(withIdentifier: Cell.self.identifier, for: indexPath) as! Cell
    }
    
}

extension UITableViewCell : ReusableView { }
