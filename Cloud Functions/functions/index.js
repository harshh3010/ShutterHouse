const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { firebaseConfig } = require('firebase-functions');
admin.initializeApp();

// Function to update total product and user rents in database
exports.updateRents = functions.firestore
    .document('Bookings/{locationName}/{categoryName}/{id}')
    .onWrite((change, context) => {
        if (change.before.exists || !change.after.exists) {
            // Booking cancelled

            const city = change.before.data().city;
            const country = change.before.data().country;
            const productId = change.before.data().productId;
            const category = change.before.data().category;
            const ownerEmail = change.before.data().ownerEmail;

            admin.firestore().collection('Products')
                .doc(`${city},${country}`)
                .collection(`${category}`)
                .doc(`${productId}`)
                .update({
                    rents: admin.firestore.FieldValue.increment(-1)
                });

            admin.firestore().collection('Users')
                .doc(`${ownerEmail}`)
                .update({
                    rents: admin.firestore.FieldValue.increment(-1)
                });
            return null;
        } else {
            // Booking added

            const city = change.after.data().city;
            const country = change.after.data().country;
            const productId = change.after.data().productId;
            const category = change.after.data().category;
            const ownerEmail = change.before.data().ownerEmail;

            admin.firestore().collection('Products')
                .doc(`${city},${country}`)
                .collection(`${category}`)
                .doc(`${productId}`)
                .update({
                    rents: admin.firestore.FieldValue.increment(1)
                });

            admin.firestore().collection('Users')
                .doc(`${ownerEmail}`)
                .update({
                    rents: admin.firestore.FieldValue.increment(1)
                });
        }
    });

// Function to update total product and user reviews in database
exports.updateReviews = functions.firestore
    .document('Reviews and Rating/{locationName}/{categoryName}/{productId}/Reviews/{customerEmail}')
    .onWrite((change, context) => {
        const city = change.after.data().city;
        const country = change.after.data().country;
        const productId = change.after.data().productId;
        const category = change.after.data().category;
        const ownerEmail = change.before.data().ownerEmail;

        admin.firestore().collection('Products')
            .doc(`${city},${country}`)
            .collection(`${category}`)
            .doc(`${productId}`)
            .update({
                reviews: admin.firestore.FieldValue.increment(1)
            });

        admin.firestore().collection('Users')
            .doc(`${ownerEmail}`)
            .update({
                reviews: admin.firestore.FieldValue.increment(1)
            });
    });

// Function to update total product and user ratings
exports.updateRating = functions.firestore
    .document('Reviews and Rating/{locationName}/{categoryName}/{productId}/Rating/{customerEmail}')
    .onWrite((change, context) => {
        const city = change.after.data().city;
        const country = change.after.data().country;
        const productId = change.after.data().productId;
        const category = change.after.data().category;
        const ownerEmail = change.before.data().ownerEmail;

        admin.firestore().collection('Reviews and Rating')
            .doc(`${city},${country}`)
            .collection(`${category}`)
            .doc(`${productId}`)
            .collection('Rating')
            .get()
            .then(function(querySnapshot) {
                var sum = 0;
                var n = 0;
                querySnapshot.forEach(function(doc) {
                    n++;
                    sum = sum + doc.data().rating;
                });
                const avgRating = sum / n;

                admin.firestore().collection('Products')
                    .doc(`${city},${country}`)
                    .collection(`${category}`)
                    .doc(`${productId}`)
                    .update({
                        rating: avgRating
                    });

                admin.firestore().collection('Users')
                    .doc(`${ownerEmail}`)
                    .update({
                        rating: avgRating
                    });

            }).catch(function(error) {
                console.log("Error updating rating: ", error);
            });
    });

// Function to send a notification to the user
exports.notifyUser = functions.firestore
    .document('Bookings/{locationName}/{categoryName}/{id}')
    .onWrite((change, context) => {
        const ownerEmail = change.after.data().ownerEmail;
        const customerEmail = change.after.data().customerEmail;
        const productName = change.after.data().productName;
        current_date = new Date();
        const cms = current_date.getMilliseconds();

        admin.firestore().collection('Notifications')
            .doc(ownerEmail)
            .collection('Notifications')
            .add({
                customerEmail: customerEmail,
                productName: productName,
                timeStamp: timeStamp,
            });
    });