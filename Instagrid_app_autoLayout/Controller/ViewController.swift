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
    @IBOutlet weak var swipeText: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTemplate2.isSelected = true
        // Make view recognizing gesture
        bigGridSquare.addGestureRecognizer(swipeGesture)
    }
    
    // Initialisation of swipeGesture
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(sharePicture(_:)))
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
        button1.imageView?.contentMode = .scaleAspectFill
        button3.imageView?.contentMode = .scaleAspectFill
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
    
    func sendAction() {
        if sender.image(for: .normal) == UIImage(named:"Plus") {
           print("L'image est PLUS")
        }
    }
    

    @IBAction func makeTemplate(_ sender: UIButton) {
        resetTemplateButtons()
        sender.isSelected = true
        
        switch sender.tag {
        case 1:
            button2.isHidden = true
            button4.isHidden = false
        case 2:
            button2.isHidden = false
            button4.isHidden = true
        case 3:
            button2.isHidden = false
            button4.isHidden = false
        default:
            button2.isHidden = false
            button4.isHidden = true
        }
    }
    
    
    // Little changes with transition between portrait and landscape
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            swipeText.text = "Swipe left to share"
            swipeGesture.direction = .left
        } else if UIDevice.current.orientation.isPortrait {
            swipeText.text = "Swipe up to share"
            swipeGesture.direction = .up
        }
    }
    
    // Render image
        func renderPicture() {
            let render = UIGraphicsImageRenderer(size: bigGridSquare.bounds.size)
            let renderingImage = render.image {
                (ctx) in
                bigGridSquare.drawHierarchy(in: bigGridSquare.bounds, afterScreenUpdates: true)
            }
            let activityController = UIActivityViewController (activityItems: [renderingImage], applicationActivities: nil)
            present(activityController, animated: true)
            activityController.completionWithItemsHandler = { _ , _ , _, _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.bigGridSquare.transform = .identity
                })
            }
        }
    
    // Animation of Swipe with orientation constrains
        func animateSwipe() {
            if UIDevice.current.orientation.isLandscape {
                UIView.animate(withDuration: 0.2, animations: {
                    self.bigGridSquare.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.bigGridSquare.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
                })
            }
        }
    
    @objc func sharePicture(_ sender: UISwipeGestureRecognizer){
         //animateSwipe()
         //renderPicture()
        print("L'action est faite")
    }
    
}

