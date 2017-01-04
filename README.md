This is a group project developed by a team of myself and 3 other students in CS 506, Software Engineering. This is a temporary public repo that we made to hold us over until we regain contact with the owner of our old private repo. We'd like to maintain our commit history so our respective contributions are easier to access. This repo will likely be deleted once the private one is made public.

#Heroku Backend

##### In order to see the test content on the heroku app, visit the following links:

* https://damp-plateau-63440.herokuapp.com/dbRMUsers
* https://damp-plateau-63440.herokuapp.com/dbRMGroceryUserLists
* https://damp-plateau-63440.herokuapp.com/dbRMGroceryGroupLists
* https://damp-plateau-63440.herokuapp.com/dbRMGroceries
* https://damp-plateau-63440.herokuapp.com/dbRMFinanceBills
* https://damp-plateau-63440.herokuapp.com/dbRMChores

##### To test the API end points use the following links

* https://damp-plateau-63440.herokuapp.com/createRMUser **Adds RMUser specified in dummy JSON to database**
* https://damp-plateau-63440.herokuapp.com/createRMGroup **Adds RMGroup specified in dummy JSON to database**
* https://damp-plateau-63440.herokuapp.com/createRMPost **Adds RMUser specified in dummy JSON to database**

**NOTE:** We do not have the HTML test views for RMGroup or RMPost, only for RMUsers. 

##### Please revisit the /dbRMUsers URL to verify the added record. (userid = 20)

* https://damp-plateau-63440.herokuapp.com/dbRMUsers

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
