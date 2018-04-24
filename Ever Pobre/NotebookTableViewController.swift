//
//  ViewController.swift
//  Ever Pobre
//
//  Created by Manuel Perez Soriano on 21/4/18.
//  Copyright © 2018 Manuel Perez Soriano. All rights reserved.
//

import UIKit
import CoreData
class NotebookTableViewController: UITableViewController, CreateNotebookControllerDelegate {
    
    var tableNotebook = [Notebook]()
    
    private func fetchNotebooks() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Notebook>(entityName: "Notebook")
        
        do {
            let notebooks = try context.fetch(fetchRequest)
            self.tableNotebook = notebooks
            self.tableView.reloadData()
        } catch let errLoad {
            print ("Error load data \(errLoad)")
        }
    }
    
    func sortNotebooks(notebooks: [Notebook], mainNotebook: Notebook?) -> [Notebook] {
        
        if mainNotebook != nil {
            tableNotebook[0].main = false
        }
        
        let sortNotebook = notebooks.sorted(by: { (n0: Notebook, n1: Notebook) -> Bool in
            return n0.title! < n1.title!
            })
        return sortNotebook
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNotebooks()
        tableNotebook = sortNotebooks(notebooks: tableNotebook, mainNotebook: nil)
       
        view.backgroundColor = UIColor.white
        navigationItem.title = "EverPobre"
        
        tableView.backgroundColor = UIColor.backgroundColor
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Notebook", style: .plain, target: self, action: #selector(handleAddNotebook))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))

//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(addNotebook))
    }
    
    func didAddNotebook(newNotebook: Notebook) {
        tableNotebook.append(newNotebook)
        let newIndexPath = IndexPath(row: tableNotebook.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.reloadData()
    }
    
    func didEditNotebook(editNotebok: Notebook) {
        let row = tableNotebook.index(of: editNotebok)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    private func createAlertToDeleteNotebook (indexPath: IndexPath) {
        let alert = UIAlertController(title: "Do you want delete the notebook", message: "if you delete the notebook also delete all notes of it", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default, handler: { action in
            let notebook = self.tableNotebook[indexPath.row]
            
            self.tableNotebook.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(notebook)
            do {
                try context.save()
            } catch let errSave {
                print ("Error to save \(errSave)")
            }
        })
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel , handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleReset() {
        print ("Reset")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        tableNotebook.forEach { (notebook) in
            context.delete(notebook)
        }
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Notebook.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            tableNotebook.removeAll()
            tableView.reloadData()
        } catch let delErr {
            print ("Error to deleted \(delErr)")
        }
    }
    
    @objc func handleAddNotebook() {
        let createNotebookViewController = CreateNotebookViewController()
        let navController = UINavigationController (rootViewController: createNotebookViewController)
        createNotebookViewController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.createAlertToDeleteNotebook (indexPath: indexPath)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editNotebook)
        
        return [deleteAction, editAction]
    }
    
    
    private func editNotebook(action: UITableViewRowAction, indexPath: IndexPath) {
        let editNotebookController = CreateNotebookViewController()
        editNotebookController.delegate = self
        editNotebookController.editNotebook = tableNotebook[indexPath.row]
        let navController = UINavigationController (rootViewController: editNotebookController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.sectionColor
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = tableNotebook[indexPath.row].title
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.backgroundColor = UIColor.bodyColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableNotebook.count
    }
}

