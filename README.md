# Almotalem Website

A modern, responsive Flutter web application for the Almotalem App landing page.

## Features

- ✨ Animated retro grid background
- 📱 Responsive design with sizer
- 🔒 Privacy policy page with markdown support
- 🚀 Optimized for Vercel deployment
- 🎨 Beautiful UI with shadcn_flutter
- 🧪 Comprehensive test coverage

## Project Structure

```
lib/
├── main.dart                           # Application entry point
├── core/
│   └── services/
│       └── privacy_policy_service.dart # API service for privacy policy
└── presentation/
    ├── components/
    │   └── common/
    │       └── animated_background.dart # Animated grid background
    └── screens/
        ├── home/
        │   └── home_page.dart          # Landing page
        └── privacy_policy/
            └── privacy_policy_page.dart # Privacy policy page

api/
└── privacy_policy.dart                 # Vercel serverless API

server/
└── api_server.dart                     # Development server

bin/
└── dev_server.dart                     # Dev server entry point
```

## Getting Started

### Prerequisites

- Flutter SDK 3.16.0 or higher
- Dart SDK ^3.10.8
- Node.js (for Vercel CLI)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd almotalem_website
```

2. Install dependencies:
```bash
flutter pub get
```

### Development

Run the development server:
```bash
dart bin/dev_server.dart
```

Or use Flutter's built-in web server:
```bash
flutter run -d chrome
```

### Building

Build for production:
```bash
flutter build web --release
```

### Testing

Run all tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/widget_test.dart
```

Run tests matching pattern:
```bash
flutter test --name "should render"
```

### Code Quality

Analyze code:
```bash
flutter analyze
```

Format code:
```bash
flutter format lib/ test/
```

## Deployment

### Vercel (Production)

The project is automatically deployed to Vercel on pushes to the main branch via GitHub Actions.

Required secrets:
- `VERCEL_TOKEN`: Your Vercel API token
- `VERCEL_ORG_ID`: Your Vercel organization ID
- `VERCEL_PROJECT_ID`: Your Vercel project ID

### Manual Deployment

1. Install Vercel CLI:
```bash
npm i -g vercel
```

2. Login to Vercel:
```bash
vercel login
```

3. Deploy:
```bash
vercel --prod
```

## Performance Optimizations

- ✅ Const constructors used throughout
- ✅ RepaintBoundary for animated widgets
- ✅ Optimized CustomPainter with minimal rebuilds
- ✅ Lazy loading of markdown content
- ✅ Efficient asset loading
- ✅ Proper widget keys for list items

## Tech Stack

- **Framework**: Flutter 3.16.0
- **UI Library**: shadcn_flutter
- **Routing**: go_router
- **Responsive**: sizer
- **Markdown**: markdown_widget
- **Animation**: Custom painter with AnimationController
- **Deployment**: Vercel

## License

© 2026 XEONSOFT. All rights reserved.
