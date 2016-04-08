//
//  SignUpViewController.swift
//  CoffeeSpace
//
//  Created by Jorge Cruz on 3/10/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newUserNameTextView: UITextField!
    @IBOutlet weak var newPasswordTextView: UITextField!

    @IBOutlet weak var newEmailTextView: UITextField!
    @IBOutlet weak var newNameTextView: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var smallcheckmarkImage: UIImageView!
    @IBOutlet weak var checkmarkusername: UIImageView!
    @IBOutlet weak var checkmarkpassword: UIImageView!
    @IBOutlet weak var checkmarkemail: UIImageView!
    @IBOutlet weak var firstcontinueButton: UIButton!
    @IBOutlet weak var secondcontinueButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pageWidth = scrollView.bounds.width
        let pageHeight = scrollView.bounds.height
        
        scrollView.contentSize = CGSizeMake(3*pageWidth, pageHeight)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        

        
        scrollView.addSubview(firstView)
        scrollView.addSubview(secondView)
        scrollView.addSubview(thirdView)
        
        //newNameTextView.becomeFirstResponder()
        
        smallcheckmarkImage.alpha = 0
        checkmarkemail.alpha = 0
        checkmarkusername.alpha = 0
        checkmarkpassword.alpha = 0
        firstcontinueButton.alpha = 0
        signupButton.alpha = 0
        secondcontinueButton.alpha = 0
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: - Form Validation Functions
    
    @IBAction func editingChanged(sender: AnyObject) {
        if ((self.newEmailTextView.text?.containsString("@") == true) && (self.newEmailTextView.text?.containsString(".") == true)) {
            print("@ is in the string")
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkemail.alpha = 1
                
                self.newEmailTextView.background = UIImage(named: "activeText")
                self.secondcontinueButton.alpha = 1
            })
            
        } else if ((self.newEmailTextView.text?.containsString("@") == false) || (self.newEmailTextView.text?.containsString(".") == false) && (self.newEmailTextView.text!.characters.count >= 1) ) {
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkemail.alpha = 0
                
                self.newNameTextView.background = UIImage(named: "errorText")
            })
        }
    }
    
    @IBAction func namedidChange(sender: AnyObject) {
        if ((self.newNameTextView.text!.characters.count) >= 2) {
            UIView.animateWithDuration(0.4, animations: {
                
                self.smallcheckmarkImage.alpha = 1
                self.newNameTextView.background = UIImage(named: "activeText")
                self.firstcontinueButton.alpha = 1
            })
        } else if ((self.newNameTextView.text!.characters.count) == 1) {
            UIView.animateWithDuration(0.4, animations: {
                
                self.smallcheckmarkImage.alpha = 0
                self.newNameTextView.background = UIImage(named: "errorText")
            })
        }
    }
    
    @IBAction func usernameChanged(sender: AnyObject) {
        if (self.newUserNameTextView.text!.characters.count >= 4) && (self.newUserNameTextView.text!.characters.count < 21) {
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkusername.alpha = 1
                
                self.newUserNameTextView.background = UIImage(named: "activeText")
            })
        } else if (self.newUserNameTextView.text!.characters.count < 4) || (self.newUserNameTextView.text!.characters.count > 21) {
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkusername.alpha = 0
                
                self.newUserNameTextView.background = UIImage(named: "errorText")
            })
        }
    }
    
    @IBAction func passwordChanged(sender: AnyObject) {
        if (((self.newPasswordTextView.text!.characters.count >= 4) && (self.newPasswordTextView.text!.characters.count < 21)) && (firstcontinueButton.alpha == 1 && secondcontinueButton.alpha == 1)) {
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkpassword.alpha = 1
                
                self.newPasswordTextView.background = UIImage(named: "activeText")
                self.signupButton.alpha = 1
            })
        } else if (self.newPasswordTextView.text!.characters.count < 4) || (self.newUserNameTextView.text!.characters.count > 21) {
            UIView.animateWithDuration(0.4, animations: {
                self.checkmarkpassword.alpha = 0
                
                self.newPasswordTextView.background = UIImage(named: "errorText")
            })
        }
        
        
    }
    
   
    
    
    @IBAction func nameContinueButton(sender: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            self.scrollView.contentOffset.x = self.firstView.frame.width
        })

        
    }
    
    
    @IBAction func emailContinueButton(sender: UIButton) {
        UIView.animateWithDuration(0.4, animations: {
            self.scrollView.contentOffset.x = 640
        })
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
