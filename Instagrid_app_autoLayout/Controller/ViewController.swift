//
//  ViewController.swift
//  Instagrid_app_autoLayout
//
//  Created by Melissa Briere on 27/08/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //elements of the view
    @IBOutlet weak var bigGridSquare: UIView!
    @IBOutlet weak var buttonTemplate1: UIButton!
    @IBOutlet weak var buttonTemplate2: UIButton!
    @IBOutlet weak var buttonTemplate3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTemplate2.isSelected = true
    }
    
    private var sender: UIButton!

    
    //open the Image picker
    @IBAction func buttonImgPicker(_ sender: UIButton) {
        self.sender = sender
        openImagePicker()
    }
    
    //import the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        sender.setImage(image, for: .normal)
        dismiss(animated: true)
    }
    
    private func openImagePicker() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present (picker, animated: true)
    }
    
    func resetTemplateButtons(){
        buttonTemplate1.isSelected = false
        buttonTemplate2.isSelected = false
        buttonTemplate3.isSelected = false
    }
    

    @IBAction func makeTemplate1(_ sender: UIButton) {
        resetTemplateButtons()
        sender.isSelected = true
        button2.isHidden = true
        button4.isHidden = false
    }
    @IBAction func makeTemplate2(_ sender: UIButton) {
        resetTemplateButtons()
        sender.isSelected = true
        button2.isHidden = false
        button4.isHidden = true
    }
    @IBAction func makeTemplate3(_ sender: UIButton) {
        resetTemplateButtons()
        sender.isSelected = true
        button2.isHidden = false
        button4.isHidden = false
    }
    
    
}

