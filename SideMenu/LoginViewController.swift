//
//  LoginViewController.swift
//  SideMenu
//
//  Created by Truong Son Nguyen on 10/1/17.
//  Copyright © 2017 Truong Son Nguyen. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper
class LoginViewController: UIViewController,GIDSignInUIDelegate {
    
    

    @IBOutlet var imgFB: UIImageView!
    
    @IBOutlet var proID: UITextField!
    
    @IBOutlet var propass: UITextField!
    
 
    @IBOutlet weak var registerlabel:UILabel!

    var scaleHeight:CGFloat = UIScreen.main.bounds.size.height/667
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //RoundImage
        self.imgFB.layer.cornerRadius = imgFB.frame.size.height/2.0
        self.imgFB.clipsToBounds = true
        //AutoLayout font
        registerlabel.font = registerlabel.font.withSize(scaleHeight*20)
        //Google login
        GIDSignIn.sharedInstance().uiDelegate = self

        // Setup the FB Login/Logout Button  FB will take care of the
        // verbiage based on the current access token
        // If we have an access token, then let's display some info
       
        
        if let _ = KeychainWrapper.standard.string(forKey: Key_UID) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
            self.present(vc, animated: true, completion: nil)
        }
        
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.perform(#selector(setStyleCircleImage(image:)), with: imgFB, afterDelay: 1.0)
    }
    @objc func setStyleCircleImage(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width/2.0
        image.clipsToBounds = true

    }
   

    @IBAction func logorightgo(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    
    }
    @IBAction func logoleft(_ sender: Any) {
        let faceLogin = FBSDKLoginManager()
        faceLogin.logIn(withReadPermissions: ["public_profile","user_friends","email"], from: self) {(result, error) in
            if error != nil {
                print("JESS:Unable to authenticate with Facebook - \(String(describing: error))")
            }else if result?.isCancelled == true {
                print("JESS:FB authentication is missout")
            }else{
                print("Succesfully")
                let crenden = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(crenden)
                self.getFBUserData()
            }
            
        }
    }
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential, completion: {(user,error) in
            if error != nil {
                print("JESS:Unable to authenticate with Firebase -\(String(describing: error))")
            } else {
                print("JESS:Succesfullt authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignin(id:user.uid, userData: userData)
                }
                
            }
        })
    }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result!)
                }
            })
        }
        
    }
    @IBAction func SignINPress(_ sender: Any) {
        guard proID.text != "" , propass.text != ""  else {
            return
        }
        Auth.auth().signIn(withEmail: proID.text!, password: propass.text!) { (user, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            if let user = user {
                let userData = ["provider": user.providerID]
                self.completeSignin(id:user.uid, userData: userData)
            }
        }

    }
    
    func completeSignin(id:String,userData:Dictionary<String,String>){
        DataServices.ds.createFirebaseDBUser(uid: id, userDATA: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey:Key_UID)
        print("JESS: DATA to keychain \(keychainResult)")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
        self.present(vc, animated: true, completion: nil)
    }
    
    
 
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension LoginViewController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google",err)
            return
        }
        print("Succesfully to log into Google account")
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let name = user.profile.name
        let email = user.profile.email
        if user.profile.hasImage
        {
            let pic = user.profile.imageURL(withDimension: 100)
            print(pic as Any)
        }
        // [START_EXCLUDE]
        print(userId as Any,name as Any,email as Any, idToken as Any,fullName as Any, givenName as  Any, familyName as Any)
//     KeychainWrapper.standard.set(user.userID, forKey: Key_UID)
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let err = error {
                print("Failed to create a  Firebase user with Google account",err)
                return
            }
            let userData = ["provider": user?.providerID]
            self.completeSignin(id:(user?.uid)!, userData: userData as! Dictionary<String, String>)
            guard let uid = user?.uid else {return}
            print("Successfully to create a Firebase user with Google account",uid)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension LoginViewController:FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, email, name"])
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                if ((error) != nil) {
                    print("Error: \(String(describing: error))")
                }
                print(result as Any)
            })
        }
    }
}
