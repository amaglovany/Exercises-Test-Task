//
//  EditSetViewController.swift
//  Exercises
//
//  Created by amaglovany on 8/29/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import UIKit

protocol EditSetViewControllerDelegate: class {
    func editSetViewControllerDidAddSet(_ set: ExerciseSet, at indexPath: IndexPath)
    func editSetViewControllerDidEditSet(_ set: ExerciseSet, at indexPath: IndexPath)
}

class EditSetViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var indexPath: IndexPath = .init(row: 0, section: 0) {
        didSet {
            titleLabel?.text = ExerciseSet.titleAtIndex(indexPath.row)
        }
    }
    
    weak var delegate: EditSetViewControllerDelegate?
    
    var type: ExerciseSet.SetType = .regular {
        didSet {
            typeLabel?.text = type.title
        }
    }
    
    var set: ExerciseSet? {
        didSet {
            if let type = set?.type {
                self.type = type
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = set == nil ? "Add Set" : "Edit Set"
        navigationItem.rightBarButtonItem?.title = set == nil ? "Add" : "Save"
            
        titleLabel.text = ExerciseSet.titleAtIndex(indexPath.row)
        typeLabel.text = type.title
    }
    
    private func close() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func cancelDidPressed(_ semder: UIBarButtonItem) {
        close()
    }
    
    @IBAction func addDidPressed(_ semder: UIBarButtonItem) {
        close()
        
        let set = ExerciseSet(type)
        
        if self.set == nil {
            delegate?.editSetViewControllerDidAddSet(set, at: indexPath)
        } else {
            delegate?.editSetViewControllerDidEditSet(set, at: indexPath)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for type in ExerciseSet.SetType.allCases {
                alert.addAction(UIAlertAction(title: type.title, style: .default, handler: { _ in
                    self.type = type
                    self.tableView.deselectRow(at: indexPath, animated: true)
                }))
            }
            present(alert, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
