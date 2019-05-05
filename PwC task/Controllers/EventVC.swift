//
//  EventVC.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 04/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit

class EventVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var attendeeTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    private var api = PwCEventAPI()
    var event: Event?
    var attendees: [Attendee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.attendeeTableView.delegate = self
        self.attendeeTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let attendees = attendees {
            return attendees.count
        } else {
            return 0
        }
    }
    
    func setupUI(){
        navigationController?.navigationBar.barStyle = .black
        self.view.setGradientBackground()
        attendees = event?.attendees
        errorLabel.textColor = .error
        attendeeTableView.separatorStyle = .none
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .clear
        name.text = event?.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificEvent", for: indexPath) as! SpecificEventCell
        if let firstname = attendees?[safe: indexPath.row]?.firstname,
            let lastname = attendees?[safe: indexPath.row]?.lastname,
            let email = attendees?[safe: indexPath.row]?.email,
            let phone = attendees?[safe: indexPath.row]?.phoneNumber
        {
            cell.name.text = "name: \(firstname) \(lastname)"
            cell.email.text = "email: \(email)"
            cell.phone.text = "phone: \(phone)"
            return cell
        }
        return cell
    }
    
    
    

    
    @IBAction func signUpAction(_ sender: Any) {
        if let id = event?.id {
            api.signupToEvent(event: id) { status in
                switch status {
                case .SUCCESS:
                    if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                    }
                case .FAILURE:
                    self.errorLabel.text = "Could not sign up to event. Try again later"
                }
            }
        }
    }
}
