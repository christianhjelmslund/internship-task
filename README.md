# pwc
## A mini project to show for a potential internship at PwC.

**The task:**
A department needs to create an event and they need to register for possible registrations online. You need to be able to attend the event and see an overview of the other attendees for an event

Create a simple register user interface to an event that includes the following:

**An attende:**
  - Full name
  - E-mail
  - Phone number

**Event:**
  - Name (of event)
  - Description
  - Date and time

**Possible events are:**
  - Anniversary Party
  - Introduction to Ruby on Rails
  - Learning on databases
^ (not necessary)

*I chose to create an iOS app for the purpose*

For the database I'm using Google Firebase. I have not used it before, but it's really simple to setup. There might be way more effective ways to handle the data but I haven't taken the time to dive deep into Firebase's way of saving locally and minimizing the number of requests.

To run the project you need to have open PwC_task.xcworkspace in xcode (see demo in bottom). You also need to use Firebase and to use Firebase you need to register yourself and you can follow the https://firebase.google.com/docs/storage/ios/start guide. The reason is that the GoogleService-Info.plist file should not be public (I'm pretty sure at least). I'm using .gitignore to ignore the GoogleService-Info.plist file when pushing to Github.

I'm not going to comment much on the code since you can see it yourself :-)

However, the project is following the classic MVC architecture.

A small demonstration of how the app works:


(Disclaimer: This has real no association with PwC and the logo of PwC in the loading screen is just for the demo's purpose, hope it's alright?)
