//
//  SignUpViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {
    @IBOutlet weak var newUserNameTextView: UITextField!
    @IBOutlet weak var newPasswordTextView: UITextField!

    @IBOutlet weak var newEmailTextView: UITextField!
    @IBOutlet weak var newNameTextView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /** Sign up button pressed, user data is written on the DataBase
     
     To-Do: Message displays succesful sign up, some fields need to be added to db and animations etc...
    **/
    @IBAction func onSignUp(sender: AnyObject) {
        
        print("pressed second Sign Up Button")
        let newUser = PFUser()
        newUser.email = self.newEmailTextView.text
        newUser.username = self.newUserNameTextView.text
        newUser.password = self.newPasswordTextView.text
        newUser.signUpInBackgroundWithBlock { (success: Bool,  error: NSError?) -> Void in
            if success {
                
                print("Created a user in CoffeeSpace! ")
                
                self.performSegueWithIdentifier("signupSegue", sender: nil)
            } else {
                print("failed")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
