//
//  Register.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 10/24/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
class Register: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var userStorage:StorageReference!
    var ref : DatabaseReference!
   
    @IBOutlet var img: UIImageView!
    @IBOutlet var fullnametf: UITextField!
    @IBOutlet var passtf: UITextField!
    @IBOutlet var comfirmtf: UITextField!
    @IBOutlet var emailtf: UITextField!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        // Do any additional setup after loading the view.
        let storage = Storage.storage().reference(forURL: "gs://sidemenu-45f6f.appspot.com/")
        ref = Database.database().reference()
        userStorage = storage.child("users")
        picker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var registernow: AnimateButton!
    
    @IBAction func registernow(_ sender: Any) {
        guard fullnametf.text != "", emailtf.text != "", passtf.text != "", comfirmtf.text != "" else {return}
        if passtf.text == comfirmtf.text {
            Auth.auth().createUser(withEmail: emailtf.text!, password: passtf.text!, completion: { (user, err) in
                if let error = err {
                    print(error.localizedDescription)
                }
                if let user = user {
                    let changerequest = Auth.auth().currentUser!.createProfileChangeRequest()
                    changerequest.displayName = self.fullnametf.text
                    changerequest.commitChanges(completion: nil)
                    let imgRef = self.userStorage.child("\(user.uid).jpg")
                    let data = UIImageJPEGRepresentation(self.img.image!, 0.5)
                    let uploadTask = imgRef.putData(data!, metadata: nil, completion: { (metadata, err) in
                        if err != nil {
                            print(err?.localizedDescription as Any)
                        }
                        imgRef.downloadURL(completion: { (url, err) in
                            if  err != nil {
                                print(err?.localizedDescription as Any) 
                            }
                            if let url = url {
                                let userInfo: [String:Any] = ["uid":user.uid , "fullname":self.fullnametf.text!,"urlToImage":url.absoluteString]
                                self.ref.child("users").child(user.uid).setValue(userInfo)
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
                                self.present(vc, animated: true, completion: nil)
                            }
                        })
                    })
                    uploadTask.resume()
                }
            })
        }else{
            print("Pass does not confirm")
        }
    }
    @IBAction func SelectIMG(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.img.image = image
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
