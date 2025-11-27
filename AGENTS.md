# Repository Guidelines

## Project Structure & Module Organization
- Flutter app entry is in `lib/main.dart`, with routing, theming, and app shell helpers under `lib/src/scaffold/` (`app_shell.dart`, `router.dart`, `theme_notifier.dart`, drawer, etc.).
- Feature panels live in `lib/src/screens/` (home, inspector, memory, network, timeline, cpu_profiler, etc.). Reusable UI, utils, and widgets are under `lib/src/shared/`.
- Assets (icons, fonts, README copy) sit in `assets/` and are declared in `pubspec.yaml`; update the manifest when adding files.
- Tests reside in `test/` (`*_test.dart`). There is a driver entrypoint at `lib/driver_main.dart` for integration-style runs if needed.

## Build, Test, and Development Commands
- `flutter pub get` — install/refresh dependencies after pulling or editing `pubspec.yaml`.
- `flutter analyze` — static analysis using `analysis_options.yaml` (Flutter lints plus stricter rules).
- `flutter test` — run widget/unit tests; use `--coverage` if you need a report locally.
- `flutter run -d chrome` (or `-d windows/macOS/linux`) — launch the app for manual verification.
- Optional: `flutter driver --target=lib/driver_main.dart` if you add driver tests.

## Coding Style & Naming Conventions
- Follow `analysis_options.yaml`: prefer single quotes, const constructors/literals, final where possible, ordered imports, no `print`, avoid unnecessary containers, and keep return types explicit.
- Use 2-space indentation and Dart file naming with `snake_case.dart`; widget/classes use `PascalCase`, methods/fields `camelCase`.
- Prefer relative imports inside `lib/`, avoid package-relative `lib/` imports, and keep unused code out.

## Testing Guidelines
- Use `flutter_test` for widget coverage; name files `*_test.dart` and describe behavior in the test name. Pump `DevToolsCompanionApp` when exercising navigation.
- Add focused tests when changing screens or shared widgets; mock network/http surfaces rather than reaching out.
- Ensure new tests pass with `flutter test` before opening a PR; run `flutter analyze` alongside.

## Commit & Pull Request Guidelines
- Commit messages use short, imperative summaries (e.g., "Add basic Timeline panel", "Use shadcn icon button...") and may include issue/PR numbers in parentheses.
- Keep lockfiles (`pubspec.lock`) and assets in sync with code changes.
- PRs should include: a concise description of the change, linked DevTools/issue tracker IDs, test evidence (`flutter analyze` + `flutter test` output), and screenshots/GIFs for UI tweaks. Note any platform-specific considerations (desktop vs. web) when relevant.
