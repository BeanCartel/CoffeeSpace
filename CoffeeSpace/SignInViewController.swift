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
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var coffeetitleLabel: UILabel!
    @IBOutlet weak var spacetitleLAbel: UILabel!
    @IBOutlet weak var bigsigninButton: UIButton!
    
    @IBOutlet weak var buttonsUIView: UIView!
    @IBOutlet weak var textfieldsUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textfieldsUIView.alpha = 0
        buttonsUIView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    @IBAction func onSignUp(sender: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            self.signupButton.backgroundColor = UIColor(red: 136, green: 96, blue: 82, alpha: 1)
        })
    }

    
    @IBAction func onSignIn(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(userNameTextView.text!, password: passWordTextView.text!) { (user: PFUser?, error: NSError?) -> Void in
            if (user != nil)
            {
                print("You are Signed in to CoffeeSpace! ")
                
                self.performSegueWithIdentifier("signInSegue", sender: nil)
            }

        }

        
        sender.setTitle("Log In", forState: .Normal)
        
    }
    
    @IBAction func pressSignin(sender: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            self.buttonsUIView.frame = CGRectMake(20, 202, 280, 128)
            self.buttonsUIView.alpha = 1
            
            self.textfieldsUIView.alpha = 1
            self.userNameTextView.alpha = 1
            self.passWordTextView.alpha = 1
            self.signupButton.alpha = 0
            self.bigsigninButton.alpha = 0
            self.coffeetitleLabel.alpha = 0
            self.spacetitleLAbel.alpha = 0
            
            self.textfieldsUIView.frame = CGRectMake(20, 20, self.textfieldsUIView.frame.width, self.textfieldsUIView.frame.height)
        })

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
