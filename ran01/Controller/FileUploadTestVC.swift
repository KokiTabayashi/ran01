//
//  FileUploadTestVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/06/05.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FileUploadTestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        ud.set(0, forKey: "count")
    }
    
    @IBAction func buttonWasPressed(_ sender: Any) {
    }
    
    func countPhoto() -> String {
        let ud = UserDefaults.standard
        let count = ud.object(forKey: "count") as! Int
        ud.set(count + 1, forKey: "count")
        return String(count)
    }
}

// MARK: UINavigationControllerDelegate
extension FileUploadTestVC: UINavigationControllerDelegate {
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary

            present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: UIImagePickerControllerDelegate
extension FileUploadTestVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [String : Any]) {
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://<YOUR-GS-APP>.appspot.com")

        if let data = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage) {
            let reference = storageRef.child("image/" + NSUUID().uuidString + "/" + countPhoto() + ".jpg")
            
            reference.putData(data, metadata: nil) { (metaData, error) in
                print(metaData as Any)
                print(error as Any)
            }
            
//            reference.put(data, metadata: nil, completion: { metaData, error in
//                print(metaData)
//                print(error)
//            })
            
            dismiss(animated: true, completion: nil)
        }
    }
}
