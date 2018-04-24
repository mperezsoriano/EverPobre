import UIKit
import CoreData

import UIKit
import CoreData

class CreateNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var editNote: Notebook? {
        didSet {
//            titleTextField.text = editNotebook?.title
//            mainSwitch.isOn = (editNotebook?.main)!
        }
    }
    
    //    var delegate: NotebookTableViewController?
    
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
    
    let backgroundDataView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.sectionColor
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    let titleDataLabel: UILabel = {
        let label = UILabel()
        label.text = "12/12/2034"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrayView: UIView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "borde"))
        let array = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        array.addSubview(image)
        array.translatesAutoresizingMaskIntoConstraints = false
        return array
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let contentTextView: UITextView = {
        let text = UITextView()
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse urna elit, tempor ut tincidunt non, commodo at odio. Integer convallis orci ligula, et eleifend lectus dignissim in. Aliquam eu fermentum nulla. Aenean interdum vulputate lorem sit amet auctor. Nullam id libero eu erat convallis sollicitudin. Vestibulum sagittis eu turpis vitae accumsan. Curabitur aliquam sodales mauris, sed auctor nibh dapibus eget. Cras venenatis dolor at blandit rutrum. Sed at purus quis magna fermentum fringilla."
        text.backgroundColor = UIColor.sectionColor
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let mapsKit: UITextView = {
        let map = UITextView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    let imageButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setTitle("Add image", for: .normal)
        button.backgroundColor = UIColor.sectionColor
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mapsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setTitle("Add maps", for: .normal)
        button.backgroundColor = UIColor.sectionColor
        button.addTarget(self, action: #selector(handleMaps), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    let arrayImage: [UIImageView] = {
//        let image = UIImageView()
//        image.backgroundColor = .red
//        image.isUserInteractionEnabled = true
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return [image]
//    }()
    
        let arrayImage: UIImageView = {
            let image = UIImageView()
            image.backgroundColor = .red
            image.isUserInteractionEnabled = true
            image.translatesAutoresizingMaskIntoConstraints = false
            let moveViewGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveImage))
            image.addGestureRecognizer(moveViewGesture)
            let tapMoveViewGeture = UITapGestureRecognizer(target: self, action: #selector(moveImage))
            
            return image
        }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        setupUI()
        mapsKit.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        view.backgroundColor = UIColor.bodyColor
    
    
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeKeyboard))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func closeKeyboard() {
        if titleTextField.isFirstResponder {
            titleTextField.resignFirstResponder()
        } else if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        navigationItem.title = editNote == nil ? "Create Note" : "Edit Note"
    }
    
    private func setupUI() {
        view.addSubview(backgroundDataView)
        backgroundDataView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        backgroundDataView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        backgroundDataView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        backgroundDataView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(titleDataLabel)
        titleDataLabel.centerYAnchor.constraint(equalTo: backgroundDataView.centerYAnchor).isActive = true
        titleDataLabel.centerXAnchor.constraint(equalTo: backgroundDataView.centerXAnchor).isActive = true
        
        view.addSubview(backgroundtitleTextFieldView)
        backgroundtitleTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        backgroundtitleTextFieldView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        backgroundtitleTextFieldView.rightAnchor.constraint(equalTo: backgroundDataView.leftAnchor, constant: -10).isActive = true
        backgroundtitleTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.centerYAnchor.constraint(equalTo: backgroundtitleTextFieldView.centerYAnchor).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: backgroundtitleTextFieldView.leftAnchor, constant: 10).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: backgroundtitleTextFieldView.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(imageButton)
        imageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 20).isActive = true
        imageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        imageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(mapsButton)
        mapsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        mapsButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 20).isActive = true
        mapsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mapsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        view.addSubview(verticalStackView)
        //stackHorizontalForImage
        contentTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive =  true
        contentTextView.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive =  true
        mapsKit.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive =  true
        mapsKit.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive =  true
        
        verticalStackView.addArrangedSubview(contentTextView)
        verticalStackView.addArrangedSubview(mapsKit)

        verticalStackView.topAnchor.constraint(equalTo: backgroundDataView.bottomAnchor, constant: 10).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: imageButton.topAnchor, constant: -10).isActive = true

    }
    
    @objc func moveImage() {
        print( "Aqio")
    }
    
    override func viewDidLayoutSubviews() {
       
        var rect = view.convert(arrayImage.frame, to: view)
        rect = rect.insetBy(dx: -25, dy: -25)
        let path = UIBezierPath(rect: arrayImage.frame)
        contentTextView.textContainer.exclusionPaths = [path]
    }
    
    @objc func handlePhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleMaps() {
        mapsKit.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print ("Ccancel")
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            arrayImage.image = originalImage
            
            contentTextView.addSubview(arrayImage)
            arrayImage.centerXAnchor.constraint(equalTo: contentTextView.centerXAnchor, constant: -50).isActive = true
            arrayImage.centerYAnchor.constraint(equalTo: contentTextView.centerYAnchor, constant: -120).isActive = true
            arrayImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
            arrayImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            
//            arrayImage[0].image = originalImage
//
//            contentTextView.addSubview(arrayImage[0])
//            arrayImage[0].centerXAnchor.constraint(equalTo: contentTextView.centerXAnchor, constant: -50).isActive = true
//            arrayImage[0].centerYAnchor.constraint(equalTo: contentTextView.centerYAnchor, constant: -120).isActive = true
//            arrayImage[0].widthAnchor.constraint(equalToConstant: contentTextView.frame.width / 4).isActive = true
//            arrayImage[0].heightAnchor.constraint(equalToConstant: contentTextView.frame.height / 4).isActive = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave() {
        print ("adlkfjldkj")
        contentTextView.isHidden =  true
        //        if editNotebook == nil {
        //            createNotebook()
        //        } else {
        //            saveNotebookChanges()
        //        }
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
