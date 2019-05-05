//
//  MainVC.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 03/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    @IBAction func signOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "goToLogin", sender: nil)
        }
        catch let error as NSError {
            print (error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventCell
        if let name = events[safe: indexPath.row]?.name,
            let _description = events[safe: indexPath.row]?._description,
            let date =  events[safe: indexPath.row]?.date {
            if let dateString = convertToDateObject(date: date) {
                cell.name.text = name
                cell._description.text = _description
                cell.date.text = dateString
                if let attendeesCount = events[safe: indexPath.row]?.attendees?.count {
                    cell.attendees.text = "number of attendees \(attendeesCount)"
                } else {
                   cell.attendees.text = "no attendees"
                }
                return cell
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeEvent" {
            if let vc = segue.destination as? EventVC {
                vc.event = events[safe: selectedIdx]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        performSegue(withIdentifier: "seeEvent", sender: nil)
    }
    

    private var events: [Event] = []
    private var api = PwCEventAPI()
    private var selectedIdx = 0
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchEvents()
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
    }
    
    func fetchEvents(){
        api.fetchEvents() { events, status in
            switch status {
            case .SUCCESS:
                self.events = events
                if self.spinner.isAnimating {
                    self.stopSpinner()
                    self.eventTableView.restore()
                }
                self.eventTableView.reloadData()
            case .FAILURE:
                self.startSpinner()
                return
            }
        }
    }
    
    func setupUI(){
        eventTableView.separatorStyle = .none
        navigationController?.navigationBar.barStyle = .black
        self.view.setGradientBackground()
    }
    
    func convertToDateObject(date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "CET")
        formatter.dateFormat = "dd.MM.yy HH:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func stopSpinner(){
        spinner.stopAnimating()
        eventTableView.willRemoveSubview(spinner)
    }
    func startSpinner(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        eventTableView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: eventTableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: eventTableView.centerYAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.spinner.isAnimating {
                self.stopSpinner()
                self.eventTableView.setEmptyView(title: "Could not establish connection", message: "Try again later")
            }
        }
    }
}
