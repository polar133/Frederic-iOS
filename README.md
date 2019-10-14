# Frederic for iOS
--
### Description
App that search a list of artist and shown his profile once selected. It was built using the View Interactor Presenter (VIP) architecture for iOS.

I choosed this architecture because it separates use cases based on the feature, in this case, the view don't know what is showing, so, in the future if we just wanted to change artist to albums, we only change the interactor layer and the viewModel that the view receive. 

For navigation, it will send the model (common model) that is selected, so in this case, the next view will have the full information of the artist. This is done in the router layer, it shares the datastore from the current view (search) to the receiver (artistDetail). Using this approach help us to achieve independency between features. 

[VIP](https://clean-swift.com) is based on POP so that way, each layer only knows the functions that are available through protocols and are optionals so it would not retain cycle in memory.

Swiftlint is implemented so it could check the swift coding style.

### Demo
<image src="Documentation/demo.gif" width=316 height=590/>


### Requirements
- Xcode 11
- Swiftlint

### API
It needs the API.plist file that isn't included in the project. If you have it, paste it on the Networking folder of the project.

### Environment
- iOS 11.4+

### Dependencies
Using Swift Package Manager, i added [Lottie](https://github.com/airbnb/lottie-ios) to add custom animations. 


### Unit Tests
For this app, the unit tests that were made only covers the layers Interactor, Worker and Presenter for each feature. I wanted to be sure to handle most of the cases for each section so i leave the coverage for around +80%

The reason why there is only tests for the interactor, worker and presenter, is because this layers handle the logic busisness implementation (interactor), networking (worker) and the presentation (presenter). Others layers like view, router and model, tends to have less logic implementation. So, to make sure that the app will work as we expected, it's better to cover the layers with more code.
