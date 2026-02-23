# ShopPlus Wallet - Senior Flutter Assessment

This project is a high-performance Wallet & Loyalty mobile application built for the **Loynova Senior Flutter Developer** technical assessment. It demonstrates a scalable architecture, robust state management, and responsive design for Android, iOS, and Web.

## 🏗️ Architecture Overview

The project follows **Clean Architecture** principles with a **Feature-based** structure. This ensures a strict separation of concerns, making the codebase highly testable and maintainable.

### Folder Structure
* **`lib/core/`**: Contains shared logic, theme constants, and central navigation (`GoRouter`).
* **`lib/features/wallet/`**:
    * **`data/`**: Implements the `WalletRepository` using a `MockWalletRepository` with simulated network delays, JSON serialization, and pagination logic.
    * **`domain/`**: Defines the business logic layer, including the abstract repository, entities, and models.
    * **`presentation/`**: Contains the UI layer (Screens/Widgets) and state management logic using `flutter_bloc`.

### State Management
I chose **BLoC (Business Logic Component)** to manage the Wallet's complexity.
* **Predictability**: It provides a clear separation between Events (Load, Filter, Refresh) and States (Initial, Loading, Loaded, Error).
* **Testing**: Highly testable using `bloc_test`.
* **Flow**: `UI Event` → `Bloc` → `Repository` → `New State` → `UI Rebuild`.



---

## 🚀 Key Features Implemented

### 1. Wallet Dashboard
* **Balance Card**: Displays total, pending, and expiring points.
* **Transaction History**: A paginated list with type-based filtering (All, Earn, Redeem, Transfer).
* **Visual Cues**: Type-based icons and color coding (Success for Earn, Error for Redeem).
* **UX Enhancements**: Shimmer loading effects and Pull-to-refresh.

### 2. Points Transfer
* **Navigation**: Implemented using `go_router` with sub-routes (`/wallet/transfer`).
* **Form Validation**: Real-time validation for:
    * Recipient: Egyptian phone number (+20...) or valid email.
    * Points: Minimum 100 and maximum available balance.
* **Security**: Handling sensitive data transitions with secure UI state management.

### 3. Testing Suite
* **Repository Tests**: Validating `getBalance()`, pagination in `getTransactions()`, and error throwing for insufficient balance.
* **BLoC Tests**: Verifying state sequences for `LoadWallet` and filtering logic.

---

## 📝 Task 4: Code Review & Performance

In the code review section, I identified and addressed the following in the provided snippets:

1.  **Snippet 1 (API Service)**: Improved error handling by avoiding generic exceptions and implementing proper response status checking.
2.  **Snippet 2 (WalletScreen)**: Moved logic from `initState` to BLoC to avoid tight coupling and managed the loading state through BLoC instead of local `setState`.
3.  **Snippet 3 (TransactionList)**: Replaced `ListView` with `ListView.builder` to optimize memory for long lists and added `const` constructors.
4.  **Snippet 4 (WalletBloc)**: Fixed state mutation issues to ensure the original transaction data isn't lost when applying filters.

### 💡 Performance Optimization Techniques Used
* **Lazy Loading (Pagination)**: Only fetching and rendering data as needed.
* **Efficient Rebuilds**: Using `BlocBuilder` with `buildWhen` to ensure only the necessary widgets rebuild.
* **Constant Constructors**: Maximizing the use of `const` to reduce widget tree overhead.
* **Image Optimization**: Using width/height constraints for merchant logos to prevent layout shifts.

---

## ⚙️ Setup & Installation

1.  **Clone the repo:**
    ```bash
    git clone [https://github.com/HazemElgohary/loynova_assessment.git](https://github.com/HazemElgohary/loynova_assessment.git)
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run Tests:**
    ```bash
    flutter test
    ```
4.  **Run on Web (Responsive):**
    ```bash
    flutter run -d chrome
    ```

---