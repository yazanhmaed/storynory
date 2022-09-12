package com.example.storynory

import android.os.Bundle
import com.google.firebase.FirebaseApp
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    @Override
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);
        FirebaseApp.initializeApp(this);
    }
}
