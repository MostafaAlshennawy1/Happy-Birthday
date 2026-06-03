# 🎉 Happy Birthday Celebration App

A premium, interactive, and beautiful Flutter application designed to celebrate birthdays in style. This app features a modern, frosted glass (glassmorphism) design system, dynamic animations, and interactive elements to create a delightful and personalized birthday experience.

---

## ✨ Features

- 🎨 **Modern Glassmorphism UI**: Beautifully styled frosted glass container for the birthday cake utilizing the `glassmorphism` package.
- 🎉 **Interactive Confetti Blast**: Trigger an explosive confetti celebration with physics-based particle behavior on demand.
- 📝 **Dynamic Celebrant Customization**: Easily update the name of the birthday boy/girl dynamically using an in-app edit dialog.
- 🕯️ **Interactive "Make a Wish" Flow**: 
  - Light the candles on the cake (switching visual assets dynamically).
  - Reveal a magical, glowing blessing: *"Your wish is my command! ✨"*
- 💓 **Pulsing Heart/Name Animation**: Smooth, looping heart-beat scale animations on the celebrant's name.
- 🌈 **Gradient Visual Theme**: A carefully selected soft pastel pink-to-peach gradient that creates a warm, premium celebration atmosphere.

---

## 🛠️ Technology Stack

| Technology / Package | Version | Purpose |
| :--- | :--- | :--- |
| **Flutter SDK** | `^3.10.1` | Core Framework |
| **Dart SDK** | `>=3.0.0 <4.0.0` | Programming Language |
| **glassmorphism** | `^3.0.0` | Frosted Glass UI Effects |
| **confetti** | `^0.7.0` | Celebrate / Particle Effects |
| **animated_text_kit** | `^4.2.2` | Text Animations |

---

## 📁 File Structure

```
lib/
└── main.dart            # Contains MyApp, BirthdayScreen state, and all UI elements
assets/
└── images/              # Birthday assets (cake, lit cake, background, and icons)
test/
└── widget_test.dart     # UI and integration smoke tests
```

---

## 🚀 Getting Started

### Prerequisites
Make sure you have Flutter installed on your machine. You can verify this by running:
```bash
flutter --version
```

### Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/MostafaAlshennawy1/Happy-Birthday.git
   cd Happy-Birthday
   ```

2. **Fetch Dependencies**
   Download and install the required packages:
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   Launch the app on your preferred emulator or connected device:
   ```bash
   flutter run
   ```

---

## 🧪 Running Tests

Verify that widget behaviors and animations are functioning correctly by running:
```bash
flutter test
```
