# Biomark Mobile Application

## Introduction
The **Biomark mobile application** is designed to collect personal and sensitive health data from volunteers to help build predictive machine learning models. The application ensures robust security and privacy mechanisms for managing user data, including user registration, login, profile management, account recovery, and unsubscription features.

This document explains the technologies used, how the application is implemented, and how data security and privacy are maintained throughout.

---

## Table of Contents

- [Project Structure](#project-structure)
- [Technologies Utilized](#technologies-utilized)
- [Implemented Features](#implemented-features)
    - [Registration](#registration)
    - [Login](#login)
    - [Profile Management](#profile-management)
    - [Account Recovery](#account-recovery)
    - [Unsubscribe](#unsubscribe)
- [Security and Privacy](#security-and-privacy)
    - [Data Encryption](#data-encryption)
    - [Password Hashing](#password-hashing)
    - [Secure Transmission](#secure-transmission)
    - [Local Data Storage Security](#local-data-storage-security)
    - [Account Recovery Security](#account-recovery-security)
    - [Privacy by Design](#privacy-by-design)
- [Screenshots and Visuals](#screenshots-and-visuals)
- [Contribution](#contribution)
- [Conclusion](#conclusion)

---

## Project Structure

The project is organized into the following folders:
- **Screens**: UI elements like registration, login, and profile screens.
- **Models**: Data representations like the volunteer profile.
- **Services**: Logic for Firebase, SQLite, and security-related functions.
- **Providers**: Manage app state related to authentication and profile.
- **Utils**: Utility functions like validation, hashing, and encryption.

---

## Technologies Utilized

- **Flutter SDK**: The framework used to build the cross-platform mobile app.
- **Firebase Authentication**: Used for user authentication (registration, login, and account recovery).
- **Firebase Realtime Database**: Stores user profile data securely.
- **SQLite**: For local storage of sensitive data when offline.
- **Provider**: A state management library in Flutter.
- **AES Encryption**: For encrypting sensitive data before local storage.
- **SHA-256 Hashing**: For secure storage of passwords and security questions.

---

## Implemented Features

### Registration
- Collects user details like **Full Name, Date of Birth, Email, and Password**.
- Passwords are hashed using **SHA-256** before being stored in Firebase.
- Data is validated using custom validators from `validators.dart`.

### Login
- Users log in with their email and password, which are authenticated by Firebase.
- Passwords are never stored in plain text.

### Profile Management
- Users can input sensitive health data like **Date of Birth**, **Blood Group**, and more.
- This data is encrypted using **AES** and stored in Firebase.
- Only hashed and encrypted data is transmitted for security.

### Account Recovery
- Users can reset their password by providing answers to security questions (hashed and stored in Firebase).
- If the answers are verified, the user can reset their password.

### Unsubscribe
- Users can unsubscribe from the program, which deletes their profile data from Firebase.
- Uninstalling the app does not remove their data from the system unless they actively unsubscribe.

---

## Security and Privacy

### Data Encryption
- Sensitive data is encrypted with **AES** before being stored locally in **SQLite**.
- Data stored in Firebase is transmitted securely over **SSL/TLS**.

### Password Hashing
- Passwords and security questions are hashed using **SHA-256** to prevent exposure of sensitive information in case of a breach.

### Secure Transmission
- All data sent between the mobile app and Firebase is encrypted using **SSL/TLS**, protecting it from unauthorized access during transit.

### Local Data Storage Security
- Sensitive personal data stored locally in **SQLite** is encrypted to prevent unauthorized access, especially if the device is lost or stolen.

### Account Recovery Security
- During account recovery, the app uses hashed answers for security questions to verify the user's identity without exposing the raw answers.

### Privacy by Design
- Only necessary personal information is collected, and users have full control over their data, including the ability to delete their profiles via the unsubscribe option.


---

## Contribution

This project was developed as a collaborative effort between the following contributors:

- **R.M.H.H. Rathnayaka** - Student ID: **21001618**
- **R.D.K.J. Wijewardhana** - Student ID: **21002223**

Their contributions include code implementation, design of the security architecture, and ensuring that the app complies with privacy best practices.

---

## Conclusion

The **Biomark mobile application** leverages modern technologies like **Flutter**, **Firebase**, and **SQLite** to provide a secure and user-friendly experience for volunteers. By incorporating **encryption**, **password hashing**, and **secure data transmission**, the app ensures that sensitive information is always protected. The design follows a **Privacy by Design** approach, allowing users full control over their personal data, including the ability to unsubscribe and delete their profile data permanently.

