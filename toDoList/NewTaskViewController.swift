//
//  ViewController.swift
//  toDoList
//
//  Created by Erick Lui on 7/12/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var descrTextView: UITextView!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    descrTextView.delegate = self
    textViewInit()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  func textViewInit() {
    descrTextView.text = "Description"
    descrTextView.textColor = UIColor.lightGray
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textViewInit()
    }
  }
}

