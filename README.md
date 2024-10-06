# Thank You Token App

## Description
This is an app that allows users to record the Thank You Tokens they have made, given, and received. Users can add an image of the token, and write down details such as the date and the recipient, as well as the story behind the gift.

Tokens are stored in the user's Google Drive using the appDataFolder, so they are only accessible to the user. The app uses the Google Drive API to read and write files, and the Google Sign-In API to authenticate users.

For more information about the concept of Thank You Tokens, please visit the [Thank You Token website](https://thank-you-token.nl).

To try out the app, visit the [web version](https://app.thank-you-token.nl).

## Installation

### Prerequisites
- Flutter SDK
- A code editor (e.g. Android Studio, Visual Studio Code)
- A Google account

1. Clone the repository

```bash
git clone https://github.com/WesselvanDam/thank-you-token-app.git
```

2. Open the project in Android Studio or Visual Studio Code

3. Run the app

```bash
flutter run --web-hostname localhost --web-port 56348
```

The port is necessary because this app uses the Google Drive API, and the OAuth Client ID is configured to only authorize requests from specific JavaScript origins.