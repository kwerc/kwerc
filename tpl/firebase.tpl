<script src="https://www.gstatic.com/firebasejs/7.6.1/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.6.1/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/ui/4.3.0/firebase-ui-auth.js"></script>
<script>
  var firebaseConfig = {
    apiKey: "%($firebase_apiKey%)",
    authDomain: "%($firebase_authDomain%)",
    databaseURL: "%($firebase_databaseURL%)",
    projectId: "%($firebase_projectId%)",
    storageBucket: "%($firebase_storageBucket%)",
    messagingSenderId: "%($firebase_messagingSenderId%)",
    appId: "%($firebase_appId%)"
  };
  firebase.initializeApp(firebaseConfig);
</script>
