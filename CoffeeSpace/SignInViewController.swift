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
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var buttonsUIView: UIView!
    @IBOutlet weak var textfieldsUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userNameTextView.alpha = 0
        passWordTextView.alpha = 0
        textfieldsUIView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    @IBAction func onSignUp(sender: AnyObject) {
        
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        if signinButton.titleForState(.Normal) == "Log In" {
            
            PFUser.logInWithUsernameInBackground(userNameTextView.text!, password: passWordTextView.text!) { (user: PFUser?, error: NSError?) -> Void in
                if (user != nil)
                {
                    print("You are Signed in to CoffeeSpace! ")
                    
                    self.performSegueWithIdentifier("signInSegue", sender: nil)
                }
            }

        }
        
        UIView.animateWithDuration(0.4, animations: {
            self.buttonsUIView.frame = CGRectMake(40, 202, self.buttonsUIView.frame.width, self.buttonsUIView.frame.height)
            
            self.textfieldsUIView.alpha = 1
            self.textfieldsUIView.frame = CGRectMake(20, 0, self.textfieldsUIView.frame.width, self.textfieldsUIView.frame.height)
            
            
            
        })
        
        signinButton.setTitle("Log In", forState: .Normal)
        
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
