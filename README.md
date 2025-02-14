# Shoe Store App

## Overview

The Shoe Store App is a Flutter application that allows users to browse and manage their cart of shoe products. The app integrates with a backend service to fetch cart details, manage cart items, and perform checkout operations.

## Try the app
1. Navigate to the [Releases](https://github.com/Ruchan10/ShoeStore/releases) section of this repository.  
2. Download the latest APK.  
3. Install the APK on your Android device to explore the app.

## Screenshots

| <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_01.png" width="45%"> | <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_02.png" width="45%"> |

| <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_03.png" width="45%"> | <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_04.png" width="45%"> |

| <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_05.png" width="45%"> | <img src="https://raw.githubusercontent.com/Ruchan10/ShoeStore/main/assets/images/screenshots/flutter_06.png" width="45%"> |

## Project Setup Instructions

To set up and run this project on your local machine, follow these instructions:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Ruchan10/ShoeStore.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd ShoeStore
   ```

3. **Install Dependencies**

   Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed. Run the following command to install the required dependencies:

   ```bash
   flutter pub get
   ```

4. **Run the Application**

   You can run the app on an emulator or a physical device using:

   ```bash
   flutter run
   ```

5. **Build the Application**

   To build the application for production, use:

   ```bash
   flutter build apk
   ```

## Assumptions

During development, the following assumptions were made:

- **Backend Integration**: It is assumed that the backend API endpoints are correctly set up and accessible. The application expects responses in a specific format as outlined in the API documentation.
- **Asset Management**: It is assumed that all asset files (images, fonts) are correctly included in the `pubspec.yaml` and available at the specified paths.
- **Device Compatibility**: The application is developed with a focus on Android devices. iOS compatibility has not been extensively tested.

## Challenges and Solutions

1. **Challenge: Asset Loading Issues**

   **Solution**: Ensured that asset paths were correctly registered in `pubspec.yaml` and verified that asset files were present in the specified directories.

2. **Challenge: Overflow Errors in UI**

   **Solution**: Utilized `Expanded` and `Flexible` widgets to manage layout constraints and prevent overflow issues. Adjusted widget sizes and padding to fit within the screen dimensions.

3. **Challenge: State Management with Riverpod**

   **Solution**: Correctly used `StateProvider` and `FutureProvider` to manage and fetch state asynchronously. Managed asynchronous data and UI updates effectively.

## Additional Features and Improvements

- **Cart Management**: Implemented functionality to increment, decrement, and remove cart items dynamically.
- **Total Amount Calculation**: Added a feature to calculate and display the grand total of all items in the cart.
- **Responsive UI**: Ensured that the UI is responsive and adjusts to different screen sizes and orientations.
- **Error Handling**: Added basic error handling for asset loading and asynchronous operations.

## Evaluation Criteria

- **Adherence to Design**: The application follows the provided design and layout specifications.
- **Functionality**: All core features such as cart management, item removal, and checkout operations are fully functional.
- **Code Quality**: The code is well-structured, follows Dart and Flutter best practices, and is maintainable.
- **Backend Integration**: Proper integration with backend services for fetching and managing cart data.
- **Bonus Features**: Added improvements such as responsive UI and enhanced error handling.

