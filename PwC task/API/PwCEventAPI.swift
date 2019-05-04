//
//  PwCEventAPI.swift
//  PwC task
//
//  Created by Christian Hjelmslund on 04/05/2019.
//  Copyright © 2019 Christian Hjelmslund. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON

class PwCEventAPI {
    private var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
    }
    
    func signupToEvent(event: String, completion: @escaping (_ status: Status) -> Void){
        if let user = Auth.auth().currentUser?.uid {
            ref.child("events").child(event).child("attendees").child(user).setValue(true)
            completion(Status.SUCCESS)
        } else {
            completion(Status.FAILURE)
        }
    }
    
    func createUser(email: String, password: String, firstname: String, lastname: String, phone: String, completion: @escaping (_ status: Status, _ _description: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(Status.FAILURE, (error?.localizedDescription)!)
            } else {
                if authResult?.user.uid != nil {
                    self.ref.child("users").child((authResult?.user.uid)!).setValue(["firstname": firstname, "lastname": lastname, "phone": phone])
                    completion(Status.SUCCESS, "")
                }
            }
        }
    }
    
    func fetchEvents(completion: @escaping (_ events: [Event], _ status: Status) -> Void) {
        ref.child("events").observe(.value, with: { (snapshot) in
            let events = JSON(snapshot.value as Any)
            var returnEvents: [Event] = []
            let myGroup = DispatchGroup()
            for event in events {
                guard let name = event.1["name"].string else { continue }
                guard let description = event.1["description"].string else { continue }
                guard let date = event.1["date"].string else { continue }
                guard let dateObject = self.convertToDateObject(date: date) else { continue }
                let id = event.0
                var returnAttendees: [Attendee] = []
                
                let attendees = event.1["attendees"]
                for attendee in attendees {
                    let userId = attendee.0
                    myGroup.enter()
                    self.ref.child("users").child(userId).observe(.value, with: { (snapshot) in
                        let user = JSON(snapshot.value as Any)
                        guard let firstname = user["firstname"].string else { return }
                        guard let lastname = user["lastname"].string else { return }
                        guard let phone = user["phone"].string else { return }
                        guard let email = Auth.auth().currentUser?.email else { return }
                        let returnAttendee = Attendee(firstname: firstname, lastname: lastname, email: email, phoneNumber: phone)
                        returnAttendees.append(returnAttendee)
                        myGroup.leave()
                    })
                }
                myGroup.notify(queue: .main) {
                    let returnEvent = Event(id: id, name: name, description: description, date: dateObject, attendees: nil )
                    if !returnAttendees.isEmpty {
                        returnEvent.attendees = returnAttendees
                    }
                    returnEvents.append(returnEvent)
                }
            }
            myGroup.notify(queue: .main) {
                completion(returnEvents, Status.SUCCESS)
            }
        })
        completion([], Status.FAILURE)
    }
    
    func convertToDateObject(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "CET")
        formatter.dateFormat = "dd.MM.yy HH:mm"
        let dateObject = formatter.date(from: date)
        return dateObject
    }
}
