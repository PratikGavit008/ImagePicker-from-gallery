//
//  ViewController.swift
//  ImagePicker
//
//  Created by Pratik Gavit on 31/01/23.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedImg()
    }

    @IBAction func gallery(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // recieve image you used delegate and after picking image you assign delegate to VC
        let selectedImg = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imgView.image = selectedImg
        picker.dismiss(animated: true)
        saveImge(img: selectedImg)
    }
    
    func saveImge(img:UIImage){
        //find path to document Directory of your app
        let pathArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        
        //Give name to image to be saved
        let imgPath = pathArray.first! + "/SavedImg.png"
        
        //Convert uiimage to binary data because it can save only binary data
          let imgData = img.pngData()!
        
        //Save binary data of image at imagepath
        let fileManager = FileManager.default
        fileManager.createFile(atPath: imgPath, contents: imgData)
        
    }
    
    func loadSavedImg(){
        
        let pathArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        //get image path to get image
        let imgPath = pathArray.first! + "/SavedImg.png"
        
        let fileManager = FileManager.default
        let imgData = fileManager.contents(atPath: imgPath)!
        let savedImg = UIImage(data: imgData)
        imgView.image = savedImg
    }
    
    
    
    @IBAction func camera(_ sender: Any) {
    }
}

