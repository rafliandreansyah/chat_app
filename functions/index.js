const functions = require("firebase-functions");
const admin = require("firebase-admin");
const {applicationDefault} = require("firebase-admin/app");
admin.initializeApp({
  credential: applicationDefault(),
});
exports.createChat = functions.firestore
    .document("chat/{messageId}")
    .onCreate((snapshot, context) => {
        return admin.messaging().sendToTopic("chat", {
            notification: {
                title: snapshot.data().username,
                body: snapshot.data().text,
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
        }, {
            priority: "high",
            timeToLive: 60 * 60 * 2,
        }).catch((error) => {
            console.log(`Error => ${error}`);
        });
    });
