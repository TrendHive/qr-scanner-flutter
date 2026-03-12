![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Architecture](https://img.shields.io/badge/Architecture-DDD-green)
![State Management](https://img.shields.io/badge/State%20Management-Cubit-purple)
![Android](https://img.shields.io/badge/Platform-Android-green)
![iOS](https://img.shields.io/badge/Platform-iOS-black)

# 🔍 QR Scanner Flutter - Advanced QR Solutions

![QR Scanner Banner](qr_scanner_banner.png)

## 🔍 About the Project

**QR Scanner** is a high-performance, modular **Flutter mobile case study project** developed to provide a fast and reliable QR code scanning experience.

The project serves as a technical showcase for **Clean Architecture**, **Domain Driven Design (DDD)**, and **modular UI** components.

It focuses on high performance, scalability, and maintainable code structure using a strictly layered approach.

---

# ✨ Features

### 📸 QR Operations
- Real-time QR code detection and scanning.
- High-speed camera integration.
- Support for multiple QR/Barcode formats.

### 📂 History & Management
- Save and manage scanned code history.
- Category-based organization of results.

### 🎨 Modular UI System
- Centralized design system with `core_ui`.
- Domain-specific UI components with `domain_ui`.

---

# 🏗 Architecture

The project follows **DDD (Domain Driven Design)** and **Clean Architecture** principles to ensure strict separation of concerns.

The architecture is divided into the following layers:

Presentation
Application
Domain
Infrastructure


---

## Presentation Layer
Handles **UI and user interaction**.
- Contains screens, widgets, and routing.
- Uses **Cubit** for reactive state management.

## Application Layer
Coordinates **application use cases and workflows**.
- Business logic orchestration.
- Bridge between presentation and domain layers.

## Domain Layer
The **core of the application**, containing business rules.
- Entities and models.
- Repository interfaces and domain services.
- **Modular extension**: Includes `domain_ui` for domain-specific visual components.

## Infrastructure Layer
Handles **external integrations**.
- Data sources and repository implementations.
- Camera and storage service integrations.

---

# 🧰 Tech Stack
- **Flutter**
- **Dart**
- **DDD (Domain Driven Design)**
- **Cubit (State Management)**
- **Modular UI Packages**

---

# 🚀 Getting Started

Follow these steps to run the project locally.

## 1️⃣ Requirements
- Flutter SDK (**3.x recommended**)
- Dart SDK
- Android Studio or VS Code

---

## 2️⃣ Clone the Repository
```bash
git clone [https://github.com/recepteksi/qr_scanner.git](https://github.com/recepteksi/qr_scanner.git)
cd qr_scanner
3️⃣ Install Dependencies
Bash
flutter pub get
4️⃣ Run the Project
Bash
flutter run
📂 Project Structure
lib/
 ├── application/      # Application services and use cases
 ├── core/             # Shared utilities and themes
 │    └── core_ui/     # Design system and generic UI components
 ├── domain/           # Business logic and entities
 │    └── domain_ui/   # Domain-specific UI modules
 ├── infrastructure/   # Data sources and service implementations
 ├── presentation/     # UI Layer (Screens & Cubits)
 └── main.dart         # Entry point
👨‍💻 Developer
Recep Ekşi

GitHub

https://github.com/recepteksi