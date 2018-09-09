
# Synopsis
This is a group project developed by a team of 4 students in CS 506, Software Engineering. We lost contact with the owner of the initial repository, and therefore could not make it public to preserve our commit history. 

## iOS Application

### Requirements
* Xcode 8
* OSX 10.11+
* iOS 9.2+
* Cocoapods (see note below)

**NOTE:** We use cocoapods as the third party library management tool. If you do not have cocoapods installed, please visit [here](https://guides.cocoapods.org/using/getting-started.html) before continuing.

### Installing the app
In your root directory for the project, run 
```sh
pod install
```

### Launching the app
Open up the project by clicking on the ```roomate.xcworkspace``` file.
Click run application on the simulator or select a connected device (requires entitlement).

### Warning
The simulator clears the cache every time the app is run, hence the Facebook login info is lost.
