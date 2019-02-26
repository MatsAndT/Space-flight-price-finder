const functions = require('firebase-functions');

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.onWay = functions.https.onRequest((request, response) => {
    data = [        
            {"class":"First", "company-name":"SpaceX", "from":"Earth", "logo":"", "pris":"60'000", "to":"Mars", "when":""},
            {"class":"First", "company-name":"LunaCorp", "from":"Mars", "logo":"", "pris":"60'000", "to":"Earth", "when":""}
        ];
    response.send(data);
});

exports.toAndBack = functions.https.onRequest((request, response) => {
    data = [        
            {"class":"First", "company-name":"SpaceX", "from":"Earth", "logo":"", "pris":"135'000", "to":"Mars", "when":""},
            {"class":"First", "company-name":"LunaCorp", "from":"Mars", "logo":"", "pris":"90'000", "to":"Earth", "when":""}
        ];
    response.send(data);
});