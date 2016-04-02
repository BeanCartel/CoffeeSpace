//
//  addCoffeeShopViewController.swift
//  CoffeeSpace
//
//  Created by Luis Liz on 3/12/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit
import Parse

class addCoffeeShopViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MyProtocol {
    
    @IBOutlet weak var shopNameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    
    var arrayOfSelectedCoffees = [PFObject]()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Buttons
    @IBAction func uploadImageButton(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        Shops.postShop(shopNameField.text, description: descriptionTextView.text, shopImage: profileImageView.image, shopLocation: locationField.text, availableCoffee: arrayOfSelectedCoffees, facebook: facebookField.text, withCompletion: nil)
        print("finished opening shop")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelPost(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    //Delegate Functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        profileImageView.image = originalImage
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
   
    
     func sendArrayToPreviousVC(myArray:[PFObject])
    {
        arrayOfSelectedCoffees = myArray
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == "segueFromAddCoffeeShops" {
            let nav = segue.destinationViewController as! UINavigationController
            
            let brandsCollectionViewController = nav.topViewController as! CoffeeBrandsCollectionViewController
            brandsCollectionViewController.mDelegate = self
            brandsCollectionViewController.comesFromAddCoffeeShop = true
            
        }
        
    }
    

}
