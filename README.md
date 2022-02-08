# tiqets_t
First checkout the project and start the **Tiq_T.xcodeproj** file, there are no third party dependencies so no CocoaPods and similar and so it’s pretty simple. In case you want to build on a real device, add your bundle ID project settings. 

Based on the project request, the following has been done:

# User Interface:
* Just build the app and you will see the loading screen while the Venues collections data is being fetched from the local file simulating the API with a 1 second delay. When the data of venues and exhibitions is fetched, Loading Screen will disappear. 
* The main screen is a list of all of the venues and exhibitions
* Tap on any venue or exhibition to go to his detail page
* Tap on a image to go to a simple gallery 
* Pull down on a list to reveal the FILTER functionality where you can search by Name, Venue or Exibiton, Price and Rating
* There is a STAR next to the venue or exhibition image, indicating is he a favourite or not
* In venue or exhibition details page you have some info. Also there is an option to add it to favourites (currently this feature is doing the local caching only)
* Title of the button here changes to reflect the state (Add or Remove)
* In the upper right corner, you have a Wish list where you can toggle between all the Venues and Exibitions and the ones added to the wish list. You can also go to the details when tapping on any wish in the wish list and remove it. 

# Architecture:
* MMVM is used as an app design pattern since it complements Apple's native, out of the box, MVC for UIKit and its new MVVM in SwiftUI.
* Networking module is independent and can be implemented anywhere. It is based on Apple's “URLSession” and generics so no third party libs have been used. It has been implemented as a local swift package intentionally and IS NOT USED in this app, but as per request of the project requirements, I added it there to illustrate the future expansion of the "VenueAndExibitionProtocol"
* Unit tests are made for view models. They are just examples and many more tests can be done. The test structure mimics the app files structure. Also each class should have its corresponding test class. For example "VenuesAndExibitionsVM.swift" has "VenuesAndExibitionsVMTests.swift" and so on...

* File organisation: 
    * App - App related data 
    * Models
    * Views
    * ViewModels
    * Lib - all custom made libraries with the main one being the networking module under “Networking” 
    * Resources - images and other stuff
    * Packets - swift packages

# To be done and improve:
Due to the lack of time, I didn't get the chance to implement several tings, but what comes to my mind would be would be:
    * Possibility to add favourite / unfavourite to real persistence using Core Data or Realm for example.
    * Better UI and UX. Definitely SwiftUI gave me a lot of issues here and it took some energy which was not planned on my side for this project
