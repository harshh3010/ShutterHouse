# Shutter House
A flutter application for renting photography and cinematography equipments.

## Tech Stack
<br>
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/flutter-logo.png" width="200px"><img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/dart-logo.png" width="200px">
<br>
This application has been designed in flutter (dart). The UI and main functioning of the app is achieved through dart. The authentication and storage requirements are met using firebase by google.
<br>
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/firebase-logo.png" width="200px">
The sign-in methods used in this app are -<br>
1. Email and Password verification<br>
2. Phone number verification<br>
<br>
The storage requirements are met by firebase storage and cloud firestore database.
<br>
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/nodejs-logo.png" width="200px">
Certain back-end tasks like updating the total user and product reviews, rents and rating are achieved using firebase cloud functions deployed using node js.
<br>

[You can find the cloud functions here](https://github.com/harshh3010/ShutterHouse/blob/master/Cloud%20Functions/functions/index.js)
<br>

## Flutter Packages used
1. **flutter_custom_clippers**: To create containers with clipper boundary
2. **rflutter_alert**: To show custom alert dialog boxes
3. **modal_progress_hud**: To display progress indicators while data is being fetched
4. **geolocator & geocoder**: To get user's location and convert the latitude and longitude obtained to address placemark
5. **image_picker**: To pick up an image from the gallery
6. **intl**: For formatting the DateTime values chosen while booking a product
7. **flutter_rating_bar**: To allow user's to rate a product

## Firestore database structure
1. **User data**: Users/{userEmail}/
2. **Product bookings**: Bookings/{city,country}/{productCategory}/{bookingId}
3. **Product data**: Products/{city,country}/{productCategory}/{productId}
4. **Reviews**: Reviews and Rating/{city,country}/{productCategory}/{productId}/Reviews/{customerEmail}
5. **Rating**: Reviews and Rating/{city,country}/{productCategory}/{productId}/Rating/{customerEmail}
6. **Notifications**: Notifications/{receiverEmail}/Notifications

## Mock-ups
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/HomeScreen.png" width="300px">
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/ProfileScreen.png" width="300px">
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/RentScreen.png" width="300px">
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/CategoryScreen.png" width="300px">
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/ProductScreen1.png" width="300px">
<img src="https://github.com/harshh3010/ShutterHouse/blob/master/Mockups/ProductScreen2.png" width="300px">

### Final APK
[You can find the final apk files here](https://github.com/harshh3010/ShutterHouse/tree/master/Release%20APK%20Files)
<br>
Due to google's change in policy for deploying cloud functions for firebase. You may experience some issues (eg- Reviews/rents/rating not being updated, not receiving notification,etc) within the app.


