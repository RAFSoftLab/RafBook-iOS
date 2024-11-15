# RafBook-iOS

# iOS Messaging App

An iOS application that allows students to communicate via text, images, videos, and audio messages. The app includes organized channels for different courses, departments, and academic years, with notifications and optional video/audio calling. This app is built with Swift and uses a Java Spring backend.

---

## Features

- **Real-Time Messaging**: Text, image, and video messaging capabilities.
- **Organized Channels**: Communication channels for specific courses, departments, and academic years.
- **Notifications**: Broadcast notifications for important updates.
- **User Management**: Register and authenticate users with role-based access (admin, professor, student).
- **Optional Video/Audio Calls**: Support for video and audio calls between users.
- **JWT Authentication**: Secure authentication using JSON Web Tokens (JWT).
- **MAC Address Verification**: Required during user registration for device verification.

---

## Technologies

- **Swift** (iOS Development)
- **UIKit / SwiftUI** (for the UI)
- **Firebase** (for push notifications)
- **WebSocket** (for real-time messaging)
- **AVFoundation** (for audio/video capabilities)
- **CoreData** (for local data caching, if needed)

## Requirements

- **iOS 14+**
- **Xcode 13+**

---

# Features and Usage

### 1. **Authentication**
- **Register**: Users register with a username, password, and MAC address (for device-specific verification).
- **Login**: Authenticate using a username and password to obtain a JWT token for secure access.

### 2. **User Interface**
- **Channels Screen**: Displays all channels available to the user, organized based on user roles (e.g., courses, departments).
- **Chat Screen**: Shows real-time messages in the selected channel, with options to send text, images, and videos.
- **Notification Screen**: Lists broadcast notifications sent to the user for important updates.

### 3. **Messaging**
- **Send Messages**: Allows users to send text, image, and video messages in real time to specific channels.
- **Receive Messages**: Provides real-time updates in the active channel via WebSocket.
- **Caching**: Locally caches recent messages for offline viewing, ensuring users can access their conversation history even without an internet connection.

### 4. **Notifications**
- **View Notifications**: Displays all system-wide notifications broadcasted to the user.
- **Push Notifications**: Enables users to receive important updates through push notifications, even when the app is in the background.

### 5. **Optional Video/Audio Communication**
- **Initiate Call**: Allows users to start a video or audio call with other users (if supported).
- **Receive Call**: Accept incoming calls from other users, with options for video and audio interaction.

### 6. **Settings**
- **User Profile**: Allows users to update their profile information.
- **Logout**: Clears the JWT token and logs the user out of the application, ensuring secure access.

---

# Security

- **JWT Authentication**: Ensures secure access to API endpoints, requiring users to authenticate and obtain a JWT token.
- **Role-Based Access Control**: Implements roles such as **admin**, **professor**, and **student**, each with specific permissions:
  - **Admin**: Full access, including managing users and channels.
  - **Professor**: Access to manage channels related to their courses.
  - **Student**: Access to view and interact within allowed channels.
- **MAC Address Verification**: Required during registration to verify the device used, adding an additional layer of security.

# Testing

---

### Unit Tests
- Tests for individual components, such as network requests and data models, to ensure functionality works as expected in isolation.

### UI Tests
- Automated UI testing for essential user flows, including login, sending messages, and receiving notifications, to ensure a smooth user experience.

### Integration Tests
- Tests API calls and WebSocket connections for end-to-end functionality, ensuring seamless interaction across the app's various components.

---

## Using Git with Forks and Creating Pull Requests

### 1. Forking a Repository
1. Go to the repository you want to fork on GitHub.
2. Click the `Fork` button at the top right of the repository page.
3. This will create a copy of the repository under your GitHub account.

### 2. Cloning the Forked Repository
1. Navigate to your forked repository on GitHub.
2. Click the `Code` button and copy the URL.
3. Open your terminal and run the following command to clone the repository:

```bash
git clone <your-forked-repo-url>
```

4. Navigate into the cloned repository:

```bash
cd <repository-name>
```

### 3. Setting Up the Upstream Remote
1. Add the original repository as an upstream remote:

```bash
git remote add upstream <original-repo-url>
```

2. Verify the new upstream remote:

```bash
git remote -v
```

### 4. Creating a New Branch
1. Create a new branch for your changes:

```bash
git checkout -b <new-branch-name>
```

### 5. Making Changes and Committing
1. Make your changes to the code.
2. Stage the changes:

```bash
git add .
```

3. Commit the changes:

```bash
git commit -m "Description of the changes"
```

### 6. Pushing Changes to Your Fork
1. Push the changes to your forked repository:

```bash
git push origin <new-branch-name>
```

### 7. Creating a Pull Request
1. Go to your forked repository on GitHub.
2. Click the `Compare & pull request` button.
3. Ensure the base repository is the original repository and the base branch is the branch you want to merge into.
4. Provide a title and description for your pull request.
5. Click `Create pull request`.

### 8. Keeping Your Fork Updated
1. Fetch the latest changes from the upstream repository:

```bash
git fetch upstream
```

2. Merge the changes into your local branch:

```bash
git checkout <branch-name>
git merge upstream/<branch-name>
```

3. Push the updated branch to your fork:

```bash
git push origin <branch-name>
```

This tutorial covers the basic workflow for using Git with forks and creating pull requests.

---
