//
//  SignInViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse


class SignInViewController: UIViewController {
    @IBOutlet weak var userNameTextView: UITextField!

    @IBOutlet weak var passWordTextView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func onSignUp(sender: AnyObject) {
        
    }
    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userNameTextView.text!, password: passWordTextView.text!) { (user: PFUser?, error: NSError?) -> Void in
            if (user != nil)
            {
                print("You are Signed in to CoffeeSpace! ")
                
                self.performSegueWithIdentifier("signInSegue", sender: nil)
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
