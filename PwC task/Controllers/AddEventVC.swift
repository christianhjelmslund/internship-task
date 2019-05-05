//
//  AddEventVC.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 04/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit
import Firebase

class AddEventVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    private var datePicker: UIDatePicker?
    private var name: String?
    private var date: Date?
    private var _description: String?
    @IBOutlet weak var attendingSwitch: UISwitch!
    @IBOutlet weak var errorlabel: UILabel!
    private let api = PwCEventAPI()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createDatePicker()
        textView.delegate = self
        dateTextField.delegate = self
        nameTextField.delegate = self
    }
    
    func createDatePicker(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        dateTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
    }
    
    func setupUI(){
        self.view.setGradientBackground()
        errorlabel.textColor = .error
        textView.text = "Tap to write a description"
        textView.textColor = .white
    }
    
    @IBAction func tapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func nameAction(_ sender: UITextField) {
        name = nameTextField.text
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .white {
            textView.text = nil
        }
    }
    
    func updateMessage(message: String){
        errorlabel.text = message
        errorlabel.shake()
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        guard let name = name else {
            updateMessage(message: "Please provide a name for the event")
            return }
        guard let date = date else {
            updateMessage(message: "Please provide a date for the event")
            return }
        guard let _description = _description else {
            updateMessage(message: "Please give a short description of the event")
            return }
        let event = Event(id: "", name: name, description: _description, date: date, attendees: [])
       
        api.createEvent(event: event, isAttending: attendingSwitch.isOn) { status in
            switch status {
            case .SUCCESS:
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            case .FAILURE:
                self.errorlabel.text = "Could not sign up to event. Try again later"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _description = textField.text
        textField.resignFirstResponder()
        return true
    }
    

    func textViewDidEndEditing(_ textView: UITextView) {
        _description = textView.text
        if textView.text.isEmpty {
            textView.text = "Tap to write a description"
            textView.resignFirstResponder()
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        date = datePicker.date
    }
    

}


