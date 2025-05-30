# Inventory Tracker

A Flutter-based inventory management application that helps you track inventory across different sites and lots.

## Features

- **Site Management**: Create, edit, and delete site locations
- **Lot Management**: Create, edit, and delete inventory lots
- **Inventory Tracking**: Record inventory counts for specific site/lot combinations
- **Tabbed Interface**: Easy navigation between different views
- **SQLite Database**: Persistent storage with Drift ORM

## Technical Details

This app is built using:

- **Flutter**: Cross-platform UI framework
- **Drift**: SQLite ORM for Flutter/Dart
- **SQLite**: Local database storage

## Database Schema

The app uses the following data model:

1. **Sites**
   - ID (Primary Key)
   - Site Name

2. **Lots**
   - ID (Primary Key)
   - Lot Number

3. **InventorySnapshots**
   - ID (Primary Key)
   - Site ID (Foreign Key)
   - Lot ID (Foreign Key)
   - Count
   - Timestamp

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build` to generate Drift database code
4. **Set up pre-commit hooks** (recommended):
   ```bash
   pip3 install pre-commit
   pre-commit install
   ```
5. Run `flutter run` to start the application

## Development

### Pre-commit Hooks

This project uses pre-commit hooks to ensure code quality and consistency. The hooks run the same checks as our GitHub Actions CI:

- **dart format**: Ensures code is properly formatted
- **flutter analyze**: Runs static analysis to catch potential issues
- **flutter test**: Runs all tests to ensure nothing is broken

To install pre-commit hooks:
```bash
pip3 install pre-commit
pre-commit install
```

To run hooks manually on all files:
```bash
pre-commit run --all-files
```

To skip pre-commit hooks for a specific commit (use sparingly):
```bash
git commit --no-verify -m "commit message"
```

## Usage

1. First, add sites in the "Sites" tab
2. Add lots in the "Lots" tab
3. In the "Inventory" tab, select a site and lot, enter a count, and add inventory data
4. View, edit, or delete your inventory records as needed
