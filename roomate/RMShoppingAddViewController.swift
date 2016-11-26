//
//  RMShoppingAddViewController.swift
//  roomate
//
//  Created by Corey Pett on 11/1/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import UIKit

class RMShoppingAddViewController: UIViewController {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func stepperDidChange(sender: AnyObject) {
        
    }
    
    @IBAction func cancelPressed() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func donePressed() {
        
        //TODO Save information
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
