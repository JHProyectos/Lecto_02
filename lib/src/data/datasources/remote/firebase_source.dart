//lib/src/data/datasources/remote/firebase_source.dart
import 'package:firebase_messaging/firebase_messaging.dart';

/// A service class to handle Firebase Cloud Messaging (FCM) functionalities.
///
/// This class provides methods to initialize FCM, manage message handling,
/// retrieve tokens, and subscribe/unsubscribe to topics.
class FirebaseSource {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initializes Firebase Messaging by requesting notification permissions.
  ///
  /// This method ensures the app can receive push notifications.
  Future<void> initialize() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("Push notifications authorized.");
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print("Provisional push notification access granted.");
      } else {
        print("Push notifications not authorized.");
      }
    } catch (e) {
      print("Error initializing Firebase Messaging: $e");
    }
  }

  /// Retrieves the Firebase Cloud Messaging (FCM) token for the current device.
  ///
  /// This token is essential for sending targeted push notifications to the device.
  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error retrieving FCM token: $e");
      return null;
    }
  }

  /// Configures message handling for foreground and background notifications.
  ///
  /// Listens to notifications when the app is running in the foreground or
  /// is opened from a notification.
  void configureMessageHandling() {
    try {
      // Handle foreground messages.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Foreground message received: ${message.notification?.title}");
        // You can add custom logic here to handle the message.
      });

      // Handle messages when the app is opened from a notification.
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("App opened from notification: ${message.notification?.title}");
        // You can navigate to specific screens or handle the notification data.
      });
    } catch (e) {
      print("Error configuring message handling: $e");
    }
  }

  /// Subscribes to a specific topic to receive group notifications.
  ///
  /// [topic] - The name of the topic to subscribe to.
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print("Subscribed to topic: $topic");
    } catch (e) {
      print("Error subscribing to topic $topic: $e");
    }
  }

  /// Unsubscribes from a specific topic to stop receiving group notifications.
  ///
  /// [topic] - The name of the topic to unsubscribe from.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print("Unsubscribed from topic: $topic");
    } catch (e) {
      print("Error unsubscribing from topic $topic: $e");
    }
  }
}
