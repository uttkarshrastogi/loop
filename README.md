# Loop: AI Journey Planner

Loop is an AI-powered application designed to help users achieve their goals by generating personalized learning plans.

## Purpose

The core purpose of Loop is to provide users with a structured and actionable path towards their objectives. Whether it's learning a new skill, preparing for an exam, or embarking on a personal development journey, Loop leverages the power of AI to create a tailored roadmap.

## Features

Loop offers a range of features to help you achieve your goals effectively:

*   **Personalized Goal Setting:**
    *   Define your primary goal (e.g., "Learn Flutter development", "Prepare for PMP exam").
    *   Set a deadline to create a time-bound plan.
*   **Daily Routine Integration:**
    *   Input your daily routine, including wake-up times, sleep times, work hours, and other fixed activities.
    *   This allows the AI to schedule learning tasks around your existing commitments.
*   **AI-Powered Learning Plan Generation:**
    *   Leverages OpenAI to create a customized, step-by-step learning plan based on your goal, deadline, and routine.
    *   Tasks are broken down into manageable daily activities.
*   **Task Display and Management:**
    *   View your AI-generated tasks grouped by date in an intuitive to-do list format.
    *   Mark tasks as completed or skipped to track your progress.
*   **Google Calendar Integration (Optional):**
    *   Connect your Google Calendar to automatically schedule learning tasks and identify free time slots.
    *   Helps in visualizing your learning schedule alongside other commitments.
*   **Daily Check-ins and Plan Adjustments:**
    *   Engage in daily check-ins to review tasks for the day.
    *   Provide feedback on your progress, which the AI can use to make adjustments to your plan, ensuring it remains relevant and effective.
*   **Resource Curation (Implied):**
    *   While not explicitly detailed as a standalone feature in `docs/documentation.md`, the AI-generated tasks often include suggestions for resources or types of activities, contributing to a curated learning experience.

## Getting Started

This section will guide you through setting up and running the Loop: AI Journey Planner application.

### Prerequisites

Before you begin, ensure you have the following installed and configured:

*   **Flutter SDK:** Make sure you have the latest stable version of Flutter installed. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   **Firebase Account:** You will need a Firebase account to set up the backend services for the app (e.g., authentication, database). If you don't have one, create it at [Firebase console](https://console.firebase.google.com/).
*   **OpenAI API Key:** To enable the AI-powered journey planning features, you'll need an API key from OpenAI. You can obtain one from the [OpenAI platform](https://platform.openai.com/signup).

### Setup Steps

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-username/loop-ai-journey-planner.git # Replace with the actual repository URL
    cd loop-ai-journey-planner
    ```

2.  **Set up Firebase Project:**
    *   Go to the [Firebase console](https://console.firebase.google.com/) and create a new project (or use an existing one).
    *   Add an Android app to your Firebase project:
        *   Follow the instructions to register your app. The package name is typically `com.example.loop_ai_journey_planner` (you can find this in `android/app/build.gradle`).
        *   Download the `google-services.json` file and place it in the `android/app/` directory of your Flutter project.
    *   Add an iOS app to your Firebase project:
        *   Follow the instructions to register your app. The iOS bundle ID is typically `com.example.loopAiJourneyPlanner` (you can find this in Xcode under General > Identity).
        *   Download the `GoogleService-Info.plist` file and place it in the `ios/Runner/` directory of your Flutter project (use Xcode to add this file to the Runner target).
    *   Enable any Firebase services you intend to use (e.g., Firebase Authentication, Firestore).

3.  **Configure OpenAI API Key:**
    *   Currently, the OpenAI API key is hardcoded in `docs/journey_integration.dart`. You will need to replace the placeholder with your actual API key.
        ```dart
        // In docs/journey_integration.dart
        final String apiKey = 'YOUR_OPENAI_API_KEY'; 
        ```
    *   **Important:** For production or any shared environment, it is strongly recommended **not** to hardcode API keys directly in the source code. Consider using environment variables, a configuration file that is not checked into version control (e.g., added to `.gitignore`), or a secure secret management service.

4.  **Install Dependencies:**
    Navigate to the root directory of the project in your terminal and run:
    ```bash
    flutter pub get
    ```

5.  **Run the Application:**
    Make sure you have a device connected or an emulator/simulator running, then execute:
    ```bash
    flutter run
    ```

## Project Structure

Here's a brief overview of the key directories in this Flutter project:

*   `lib/`: This is the heart of your Flutter application. It contains all the Dart code for the application's UI (widgets), business logic (BLocs/Providers, services), core functionalities, and feature modules.
    *   `lib/core/`: Contains shared utilities, configurations, services (like API handling, navigation), and base UI components used across multiple features.
    *   `lib/feature/`: Organizes code by specific features of the application (e.g., `auth`, `journey`, `dashboard`). Each feature folder typically contains its own data, presentation (UI and state management), and domain layers.
    *   `lib/main.dart`: The entry point of the Flutter application.
*   `functions/`: This directory contains backend code, likely for Firebase Cloud Functions. It includes `index.js` and `package.json`, suggesting Node.js-based functions for tasks like custom API endpoints, background processing, or interacting with Firebase services on the server-side.
*   `assets/`: Stores static assets used by the application. This includes:
    *   Images (e.g., `.png`, `.jpg`)
    *   Lottie animations (e.g., `.json`)
    *   Other resources like custom fonts or data files.
*   `android/`: Contains Android-specific project files and code. You'll work in this directory if you need to customize Android-native features, permissions, or build configurations (e.g., `build.gradle`, `AndroidManifest.xml`).
*   `ios/`: Contains iOS-specific project files and code. Similar to the `android/` directory, this is where you'd go for iOS-native customizations (e.g., `Info.plist`, Xcode project settings in `Runner.xcworkspace`).
*   `web/`: Contains files for building the web version of the application, if applicable (e.g., `index.html`, web-specific assets).
*   `test/`: Includes all the automated tests for your application. This typically contains unit tests (for testing individual functions or classes) and widget tests (for testing UI components).
*   `docs/`: Contains project documentation, such as design documents, API specifications, or, in this case, details about the AI Journey feature.
*   `firebase.json`, `firestore.rules`, `database.rules.json`: Configuration files for Firebase services, defining security rules for Firestore, Realtime Database, and other Firebase project settings.
*   `pubspec.yaml`: The project's manifest file. It declares dependencies (packages your project uses), project metadata (name, description, version), and asset declarations.

## Future Enhancements

The following are some of the planned future enhancements for Loop: AI Journey Planner, based on the project documentation:

*   **Advanced Calendar Integration:** Improve the existing Google Calendar integration for more sophisticated identification of available time slots and potentially bi-directional sync improvements.
*   **Learning Analytics:** Implement features to track user progress in more detail, providing insights into learning patterns, time spent, and areas of strength or weakness.
*   **Social Features:** Introduce capabilities for users to share their goals, progress, or even collaborate with friends or study groups.
*   **Adaptive Learning:** Enhance the AI to dynamically adjust the difficulty and content of learning plans based on user performance and feedback, creating a more personalized learning curve.
*   **Offline Support:** Allow users to access their learning plans and mark task progress even when they don't have an active internet connection, syncing data once connectivity is restored.

## Contributing

We welcome contributions to Loop: AI Journey Planner! If you're interested in helping improve the app, please follow these steps:

1.  **Fork the Repository:**
    Start by forking the main repository to your own GitHub account.

2.  **Create a New Branch:**
    Create a new branch in your forked repository for your changes. Choose a descriptive branch name (e.g., `feature/add-new-analytics` or `fix/calendar-sync-issue`).
    ```bash
    git checkout -b your-branch-name
    ```

3.  **Make Your Changes:**
    Implement your feature, bug fix, or improvement. Ensure your code follows the project's coding style and conventions. If you're adding a new feature, consider adding relevant tests.

4.  **Test Your Changes:**
    Run existing tests and, if applicable, add new ones to ensure your changes don't break existing functionality and that your new feature works as expected.

5.  **Commit Your Changes:**
    Commit your changes with a clear and concise commit message.
    ```bash
    git add .
    git commit -m "feat: Describe your feature or fix"
    ```

6.  **Push to Your Fork:**
    Push your changes to your forked repository.
    ```bash
    git push origin your-branch-name
    ```

7.  **Submit a Pull Request (PR):**
    Open a pull request from your branch in your forked repository to the `main` (or `develop`) branch of the original Loop: AI Journey Planner repository.
    *   Provide a clear title and description for your PR, explaining the changes you've made and why.
    *   Reference any relevant issues if applicable.

We'll review your PR as soon as possible. Thank you for your interest in contributing!

## License

This project is licensed under the MIT License.

```
MIT License

Copyright (c) [Year] [FullName]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

**Note:** You should replace `[Year]` and `[FullName]` with the appropriate information. If a `LICENSE` file exists in the repository, you can also link to it here.
