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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pageWidth = scrollView.bounds.width
        let pageHeight = scrollView.bounds.height
        
        scrollView.contentSize = CGSizeMake(3*pageWidth, pageHeight)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        let view1 = UIView(frame: CGRectMake(0, 0, pageWidth, pageHeight))
        let usertextfield = UITextField(frame: CGRectMake(20, 100, 300, 30))
        usertextfield.placeholder = "Username"
        usertextfield.font = UIFont.systemFontOfSize(15)
        usertextfield.borderStyle = UITextBorderStyle.RoundedRect
        usertextfield.autocorrectionType = UITextAutocorrectionType.No
        usertextfield.keyboardType = UIKeyboardType.Default
        usertextfield.returnKeyType = UIReturnKeyType.Done
        usertextfield.clearButtonMode = UITextFieldViewMode.WhileEditing;
       // usertextfield.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        usertextfield.delegate = self
        view1.addSubview(usertextfield)
        view1.backgroundColor = UIColor.blueColor()
        
        
        
        let view2 = UIView(frame: CGRectMake(pageWidth, 0, pageWidth, pageHeight))
        view2.backgroundColor = UIColor.orangeColor()
        let passwordTextfield = UITextField(frame: CGRectMake(20, 100, 300, 30))
        passwordTextfield.placeholder = "Enter Password"
        passwordTextfield.font = UIFont.systemFontOfSize(15)
        passwordTextfield.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextfield.autocorrectionType = UITextAutocorrectionType.No
        passwordTextfield.keyboardType = UIKeyboardType.Default
        passwordTextfield.returnKeyType = UIReturnKeyType.Done
        passwordTextfield.clearButtonMode = UITextFieldViewMode.WhileEditing;
        //passwordTextfield.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        passwordTextfield.delegate = self
        view2.addSubview(passwordTextfield)
        
        let view3 = UIView(frame: CGRectMake(2*pageWidth, 0, pageWidth, pageHeight))
        view3.backgroundColor = UIColor.purpleColor()
        
        let doneButton   = UIButton(type: UIButtonType.System) as UIButton
        doneButton.frame = CGRectMake(100, 100, 100, 50)
        doneButton.backgroundColor = UIColor.greenColor()
        doneButton.setTitle("Done!", forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view3.addSubview(doneButton)

        
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        scrollView.addSubview(view3)
        
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
