# Offbeat प्रवासी

A modern Flutter app for community-driven travel, reviews, and social sharing.

## ✨ Features

- Community posts and comments (Firebase Firestore)
- User authentication (Firebase Auth, Google Sign-In)
- Trek reviews and ratings
- Push notifications (Firebase Messaging)
- Profile management
- Image uploads and sharing
- Location features (Geolocator, Geocoding)

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 3.6.0 or higher
- Firebase project (with Android/iOS setup)

### Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/const-nishant/offbeat_pravasi_v2.git
   cd offbeat_pravasi_v2
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective folders.

4. **Run the app**
   ```sh
   flutter run
   ```

## 📁 Project Structure

- `lib/` - Main source code
  - `modules/` - Features (community, home, profile, etc.)
  - `config/` - App configuration
  - `main.dart` - App entry point
- `assets/` - Images and resources

## 🛠️ Useful Commands

- Build APK:  
  `flutter build apk`
- Run tests:  
  `flutter test`

## 📄 License

This project is for educational and demonstration purposes.


**Note:**  
Configure your Firebase credentials before running the app. For issues or suggestions, please open an issue
