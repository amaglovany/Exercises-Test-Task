//
//  ExercisesViewController.swift
//  Exercises
//
//  Created by amaglovany on 8/28/19.
//  Copyright © 2019 amaglovany. All rights reserved.
//

import UIKit

class ExercisesViewController: UITableViewController {
    
    var exercises = [Exercise]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AddSetsCell.self)
        tableView.register(SetCell.self)
    }

    // MARK: - Actions
    
    @IBAction func addDidPressed(_ sender: UIBarButtonItem) {
        exercises.append(Exercise())
        tableView.reloadData()
    }
    
}

// MARK: - Navigation

extension ExercisesViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EditSetViewController.segueIdentifier,
            let controller = segue.destination as? EditSetViewController,
            let tuple = sender as? (indexPath: IndexPath, set: ExerciseSet?) {
            controller.delegate = self
            controller.indexPath = tuple.indexPath
            controller.set = tuple.set
        }
    }
    
}

// MARK: - Table view data source

extension ExercisesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises[section].sets.count + 1
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = exercises[indexPath.section]
        if exercise.sets.count == indexPath.row {
            return tableView.dequeueReusableCellFor(indexPath) as AddSetsCell
        } else {
            let set = exercise.sets[indexPath.row]
            let text = NSMutableAttributedString(string: "\(String.bullet) \(ExerciseSet.titleAtIndex(indexPath.row))")
            text.setAttributes([.foregroundColor: set.type.color], range: NSRange(location: 0, length: 1))
            
            let cell: SetCell = tableView.dequeueReusableCellFor(indexPath)
            cell.textLabel?.attributedText = text
            return cell
        }
     }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Exercise.titleAtIndex(section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let set = exercises[indexPath.section].sets.count == indexPath.row ? nil : exercises[indexPath.section].sets[indexPath.row]
        performSegue(withIdentifier: EditSetViewController.segueIdentifier, sender: (indexPath, set))
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (indexPath.row < exercises[indexPath.section].sets.count) {
            exercises[indexPath.section].sets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        } else {
            exercises.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (indexPath.row < exercises[indexPath.section].sets.count) {
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                self.exercises[indexPath.section].sets.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            }
            
            return [delete]
        }
        return nil
    }
    
}

// MARK: - AddSetControllerDelegate

extension ExercisesViewController: EditSetViewControllerDelegate {
    
    func editSetViewControllerDidAddSet(_ set: ExerciseSet, at indexPath: IndexPath) {
        let exercise = exercises[indexPath.section]
        
        let index = set.type == .regular ? indexPath.row : exercise.sets.firstIndex { (set) -> Bool in
            set.type == .regular
            } ?? 0
        
        exercise.sets.insert(set, at: index)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .none)
    }
    
    func editSetViewControllerDidEditSet(_ set: ExerciseSet, at indexPath: IndexPath) {
        let exercise = exercises[indexPath.section]
        let oldSet = exercise.sets[indexPath.row]
        
        guard oldSet.type != set.type else { return }
        
        exercise.sets.remove(at: indexPath.row)
        
        let index = set.type == .regular ? indexPath.row : exercise.sets.firstIndex { (set) -> Bool in
            set.type == .regular
            } ?? 0
        
        exercise.sets.insert(set, at: index)
        
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .none)
    }
    
}
