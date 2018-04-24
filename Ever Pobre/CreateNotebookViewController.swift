//
//  CreateNotebookViewController.swift
//  Ever Pobre
//
//  Created by Manuel Perez Soriano on 21/4/18.
//  Copyright © 2018 Manuel Perez Soriano. All rights reserved.
//

import UIKit
import CoreData

protocol CreateNotebookControllerDelegate {
    func didAddNotebook(newNotebook: Notebook)
    func didEditNotebook(editNotebok: Notebook)
}

class CreateNotebookViewController: UIViewController {
    
    var editNotebook: Notebook? {
        didSet {
            titleTextField.text = editNotebook?.title
            mainSwitch.isOn = (editNotebook?.main)!
        }
    }
    
    var delegate: NotebookTableViewController?
    
    let backgroundtitleLabelView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.sectionColor
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter the title of a new Notebook"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundtitleTextFieldView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.sectionColor
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Do you want to be your main:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainSwitch: UISwitch = {
        let mainSwitch = UISwitch()
        mainSwitch.isOn = false
        mainSwitch.translatesAutoresizingMaskIntoConstraints = false
        return mainSwitch
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
    
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        view.backgroundColor = UIColor.bodyColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationItem.title = editNotebook == nil ? "Create Notebook" : "Edit Notebook"
    }
    
    private func setupUI() {
        view.addSubview(backgroundtitleLabelView)
        backgroundtitleLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        backgroundtitleLabelView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        backgroundtitleLabelView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        backgroundtitleLabelView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: backgroundtitleLabelView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(backgroundtitleTextFieldView)
        backgroundtitleTextFieldView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        backgroundtitleTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        backgroundtitleTextFieldView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        backgroundtitleTextFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.topAnchor.constraint(equalTo: backgroundtitleTextFieldView.topAnchor, constant: 10).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
    
        view.addSubview(switchLabel)
        switchLabel.centerYAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50).isActive = true
        switchLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
    
        view.addSubview(mainSwitch)
        mainSwitch.centerYAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50).isActive = true
        mainSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
    
    
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        if editNotebook == nil {
            createNotebook()
        } else {
            saveNotebookChanges()
        }
    }

    private func saveNotebookChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        editNotebook?.title = titleTextField.text
        editNotebook?.main = mainSwitch.isOn
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didEditNotebook(editNotebok: self.editNotebook!)
            }
        } catch let saveErr {
            print ("Error to save data \(saveErr)")
        }
    }
    
    private func createNotebook() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let notebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: context)
        notebook.setValue(titleTextField.text, forKey: "title")
        notebook.setValue(mainSwitch.isOn, forKey: "main")
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddNotebook(newNotebook: notebook as! Notebook)
            }
            
        } catch let saveErr {
            print ("Error to save data \(saveErr)")
        }
    }
}
