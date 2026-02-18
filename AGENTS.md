# AGENTS.md - Coding Guidelines for Almotalem Website

## Project Overview
Flutter web application using Dart SDK ^3.10.8. Deployed to Vercel.

## Build/Lint/Test Commands

```bash
# Install dependencies
flutter pub get

# Build for production
flutter build web --release

# Analyze code
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run tests matching a pattern
flutter test --name "Counter increments"

# Clean build artifacts
flutter clean

# Dev server (custom)
dart bin/dev_server.dart
```

## Code Style Guidelines

### Imports
- Use package imports for internal files: `import 'package:almotalem_website/...'`
- Group imports: Flutter SDK first, then third-party, then internal
- No `dart:` imports for web-specific features (use `dart:html` carefully)

### Formatting
- Use `flutter format` (based on dartfmt)
- Max line length: 80 characters
- Use trailing commas for multi-line parameter lists

### Naming Conventions
- Classes: PascalCase (e.g., `HomePage`, `PrivacyPolicyService`)
- Files: snake_case (e.g., `home_page.dart`, `privacy_policy_service.dart`)
- Variables/functions: camelCase (e.g., `fetchPrivacyPolicy`, `buildToast`)
- Constants: camelCase for local, PascalCase for enum values

### Type Safety
- Prefer `const` constructors where possible
- Use `final` for variables that don't change
- Annotate types explicitly on public APIs
- Use `super.key` in widget constructors

### Widget Structure
- StatelessWidget for static UI, StatefulWidget for stateful UI
- Extract complex widgets into private methods or separate files
- Use `const` widgets where possible for performance

### Error Handling
- Use try/catch for async operations
- Throw descriptive exceptions with context
- Handle errors gracefully in UI with fallback content

### Project Structure
```
lib/
├── main.dart                 # Entry point
├── core/                     # Core utilities, services
│   └── services/
├── presentation/             # UI layer
│   ├── components/          # Reusable widgets
│   │   ├── common/          # Shared components
│   │   └── [feature]/       # Feature-specific components
│   └── screens/             # Page-level widgets
```

### State Management
- Simple state: Use StatefulWidget with setState
- Complex state: Consider lifting state up or using providers
- Services: Use static methods or singletons for data fetching

### UI Patterns
- Uses shadcn_flutter for UI components
- Uses go_router for navigation
- Uses sizer for responsive layouts
- Use `spacing` parameter in Column/Row for consistent gaps
- Use `withPadding()` extension for padding

### Assets
- Images: `assets/images/`
- Documents: `assets/docs/`
- Fonts: `assets/fonts/`
- Reference: `Image.asset('assets/images/icon.png')`

### API/Server
- API endpoints in `api/` directory (Vercel serverless)
- Dev server: `dart bin/dev_server.dart`
- Production: Vercel routes handle API calls

### Lint Rules
- Uses `package:flutter_lints/flutter.yaml`
- Follow all Flutter lint recommendations
- Suppress lints inline with `// ignore: rule_name` if necessary

### Testing
- Test files in `test/` directory
- Naming: `<feature>_test.dart`
- Use WidgetTester for widget tests
- Mock external dependencies

### Deployment
- GitHub Actions workflow: `.github/workflows/deploy-vercel.yml`
- Flutter version: 3.27.1 (stable channel)
- Build output: `build/web/`

### Important Notes
- Web-only project (no mobile support)
- Uses `flutter_web_plugins` for URL strategy
- Production uses relative URLs for API calls
- Development uses localhost with port 5967
