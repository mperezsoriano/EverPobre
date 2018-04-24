//
//  ModifyDatePickerController.swift
//  Ever Pobre
//
//  Created by Manuel Perez Soriano on 22/4/18.
//  Copyright © 2018 Manuel Perez Soriano. All rights reserved.
//

import UIKit
import CoreData

class ModifyDatePickerController: UIViewController {
    
//    var editData: Note? {
//        didSet {
//            // Introducir valores
//        }
//    }
//
    
    let backgroundtitleLabelView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.sectionColor
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of conclusion of the task"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePiker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.bodyColor
    }
    
    private func setupUI() {
        view.addSubview(backgroundtitleLabelView)
        backgroundtitleLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        backgroundtitleLabelView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        backgroundtitleLabelView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        backgroundtitleLabelView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: backgroundtitleLabelView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(datePiker)
        datePiker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePiker.topAnchor.constraint(equalTo: backgroundtitleLabelView.bottomAnchor, constant: 30).isActive = true
        datePiker.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
//        if editNotebook == nil {
//            createNotebook()
//        } else {
//            saveNotebookChanges()
//        }
        
 //       datePiker.date
    }
    
//    private func saveNotebookChanges() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        editNotebook?.title = titleTextField.text
//        editNotebook?.main = mainSwitch.isOn
//        
//        do {
//            try context.save()
//            dismiss(animated: true) {
//                self.delegate?.didEditNotebook(editNotebok: self.editNotebook!)
//            }
//        } catch let saveErr {
//            print ("Error to save data \(saveErr)")
//        }
//    }
//    
//    private func createNotebook() {
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        let notebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: context)
//        notebook.setValue(titleTextField.text, forKey: "title")
//        notebook.setValue(mainSwitch.isOn, forKey: "main")
//        
//        do {
//            try context.save()
//            dismiss(animated: true) {
//                self.delegate?.didAddNotebook(newNotebook: notebook as! Notebook)
//            }
//            
//        } catch let saveErr {
//            print ("Error to save data \(saveErr)")
//        }
//    }
}
