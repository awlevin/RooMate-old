--- A brief message from Aaron Levin ---

This is a group project developed by a team of myself and 3 other students in CS 506, Software Engineering. This is a temporary public repo that we made to hold us over until we regain contact with the owner of our old private repo. We'd like to maintain our commit history so our respective contributions are easier to access. This repo will likely be deleted once the private one is made public.

Also, we'd like to point out that we're aware of the imperfections in our code. Two members of our team dropped early in the semester, and we did not have much time to fine-tune code, as we were still operating in an Agile environment (push back features, not deadlines). Fortunately, we all balanced our busy schedules well enough to meet most of our deadlines, but at the expense of code efficiency/optimization and readability.

If I were to go back and redo this entire project now, I would use optional initializers for most (if not all) of the structs we used. Resultingly, I would remove the static keyword from most of the edit/delete functions within our models. Upon investigation at the end of the semester, I discovered that overusing static methods can lead to poor app performance. Since our app was so basic, we never experienced these effects. But it is an important note to keep in mind for future projects.

--- end message ---

#iOS Application

####Requirements
* Xcode 8
* OSX 10.11+
* iOS 9.2+
* Cocoapods (see note below)

**NOTE:** We use cocoapods as the third party library management tool. If you do not have cocoapods installed, please visit [here](https://guides.cocoapods.org/using/getting-started.html) before continuing.

####Installing the app
In your root directory for the project, run 
```sh
pod install
```

####Launching the app
Open up the project by clicking on the ```roomate.xcworkspace``` file.
Click run application on the simulator or select a connected device (requires entitlement).

###Warning
The simulator clears the cache every time the app is run, hence the facebook login info is lost. We are porting the storage to coredata and till then have disabled the login feature. You are automatically asked to join a group!
