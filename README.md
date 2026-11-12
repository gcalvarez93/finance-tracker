# Finance Tracker

A personal finance management app built as part of the CastroDev portfolio. Track your income, expenses, budgets, and categories with a clean and intuitive interface.

---

## 📱 Screenshots

<p align="center">
  <img src="screenshots/login_page.png" alt="Login screen" width="23%" />
  <img src="screenshots/dashboard_page.png" alt="Dashboard with balance and latest transactions" width="23%" />
  <img src="screenshots/transactions_page.png" alt="Transactions list" width="23%" />
  <img src="screenshots/add_transaction_page.png" alt="Add transaction with receipt scan" width="23%" />
</p>
<p align="center">
  <img src="screenshots/categories_page.png" alt="Categories" width="23%" />
  <img src="screenshots/budget_page.png" alt="Monthly budgets" width="23%" />
  <img src="screenshots/profile_page.png" alt="User profile" width="23%" />
</p>

---

## ✨ Features

- 📊 **Dashboard** — Real-time balance, income/expense summary and latest transactions
- 💸 **Transactions** — Create, view and delete transactions with category assignment
- 📁 **Categories** — Custom categories with icons and colors
- 🎯 **Budgets** — Monthly budget tracking with visual progress bars
- 📄 **Export** — Export transactions to PDF or Excel
- 📷 **OCR Scan** — Scan receipts automatically with Google Cloud Vision
- 👤 **Profile** — Edit name, manage notifications and switch language
- 🌍 **Multilingual** — English and Spanish support

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | Riverpod |
| Error Handling | fpdart (Either) |
| Models | Freezed + json_serializable |
| Networking | Dio |
| Authentication | Firebase Auth (Email + Google) |
| Backend | .NET 10 REST API (Clean Architecture) |
| Database | Cloud Firestore |
| Infrastructure | Google Cloud Run |

---

## 🏗️ Architecture

The app follows **Clean Architecture** per feature. Presentation depends on domain abstractions only; data implementations are wired in the Riverpod providers.

```
lib/
├── core/
│   ├── config/          # API and app configuration
│   ├── errors/          # Typed failures + localized user messages
│   ├── logging/         # AppLogger (dart:developer)
│   ├── network/         # Dio client with Firebase auth, DioException → Failure mapper
│   └── widgets/         # Shared widgets (error with retry)
└── features/
    ├── auth/            # Login, register, Google Sign-In
    ├── transactions/    # CRUD, export PDF/Excel, OCR scan
    ├── categories/      # CRUD with icon and color picker
    ├── budgets/         # Monthly budget tracking
    ├── home/            # Dashboard and navigation
    └── profile/         # Settings, notifications, language
```

Each feature follows the pattern:
```
feature/
├── data/
│   ├── datasources/     # Remote API calls
│   ├── models/          # Freezed + JSON models
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Freezed domain entities
│   ├── repositories/    # Abstract repository interfaces
│   └── usecases/        # Use cases (auth, profile, receipt scan, export)
└── presentation/
    ├── pages/           # Screen widgets
    ├── providers/       # Riverpod state notifiers
    └── widgets/         # Reusable UI components
```

---

## 🧭 Technical Decisions

- **Clean Architecture per feature.** Each feature has its own `data / domain / presentation`. The domain layer is plain Dart with no Flutter, Dio or Firebase imports, so business rules can be tested without a device.
- **Riverpod with `StateNotifier` and sealed states.** Each screen state (`Loading`, `Loaded`, `Error`) is an explicit type, so the UI cannot read data that is not there. The providers are the single place where concrete implementations are wired, which also makes them easy to replace in tests.
- **`Either<Failure, T>` instead of exceptions.** Repositories catch infrastructure errors, log the technical detail with `AppLogger` and return a typed `Failure` (`network`, `timeout`, `server`, `auth`, `notFound`, `rejected`, `unknown`) built by one central `DioException` mapper. The notifiers and pages only fold the result.
- **User-facing errors are localized, never technical.** Pages turn a `Failure` into an ARB string (es/en) and never show the raw message. Forms stay open on failure and keep what the user typed; a failed reload with data on screen keeps the list and shows a SnackBar; a failed first load shows the reason with a retry button.
- **Freezed for entities and failures.** Immutable values with equality for free, and a sealed `Failure` that forces exhaustive handling.
- **Use cases only where they add something.** Auth, profile, receipt scan and export have use cases. Plain CRUD (transactions, categories, budgets) goes from the notifier straight to the repository to avoid empty pass-through classes. The trade-off is that the rule is not uniform across features.
- **Shared .NET 10 API.** Business rules and OCR live on the server; the app sends the Firebase ID token through a Dio client. One backend serves all the apps in this portfolio.
- **Tests with hand-written fakes.** The notifiers, use cases and repository mappings are covered with fakes of the domain interfaces, with no mocking library. The Dio-to-`Failure` mapping has its own unit tests. Coverage is focused on the critical transactions and network flow (see limitations).

### Other projects in this portfolio

| Project | Platform | Language |
|---|---|---|
| [finance-tracker](https://github.com/gcalvarez93/finance-tracker) | Flutter (iOS + Android) | Dart |
| [habit-tracker](https://github.com/gcalvarez93/habit-tracker) | Flutter (iOS + Android) | Dart |
| [task-manager](https://github.com/gcalvarez93/task-manager) | iOS | Swift |
| [task-manager-kmp](https://github.com/gcalvarez93/task-manager-kmp) | Android + iOS | Kotlin Multiplatform + Swift |
| [budget-scanner](https://github.com/gcalvarez93/budget-scanner) | iOS | Swift |
| [recipe-manager](https://github.com/gcalvarez93/recipe-manager) | Android | Kotlin |
| [workout-tracker](https://github.com/gcalvarez93/workout-tracker) | Android | Kotlin |
| [castrodev-api](https://github.com/gcalvarez93/castrodev-api) | Shared backend | C# (.NET 10) |

---

## ⚠️ Known limitations

Deliberate trade-offs, not oversights:

- **No session renewal on API 401/403.** The app shows a "session no longer valid" message, but it does not sign the user out or retry. Firebase renews the ID token automatically before each request, so the real case would be a server-side rejection.
- **No `sendTimeout`.** The Dio client sets connect (30 s) and receive (60 s) timeouts only, so a stalled upload (receipt scan) is not cut by a send timeout.
- **Focused test coverage.** Transactions and the Dio error mapping are covered; the budgets, categories and profile notifiers are not.
- **Retry is not everywhere.** Transactions, the dashboard, budgets, categories and notification settings offer "Retry" when the first load fails. Export and receipt scan only show a generic message. A failed pull-to-refresh on the dashboard keeps the previous data without a message.
- **Auth uses Firebase's own messages.** Login and registration errors do not go through the typed mapper.
- **Some UI text is still hardcoded in Spanish** (month names in budgets, default user name).

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Firebase project configured
- API running at `api.castrodev.com` or locally

### Installation

```bash
# Clone the repository
git clone https://github.com/gcalvarez93/finance-tracker.git

# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Run the app
flutter run --dart-define=API_URL=https://api.castrodev.com

# Run the tests
flutter test
```

---

## 🔗 Related

- [CastroDev API](https://github.com/gcalvarez93/castrodev-api) — Shared .NET 10 backend

---

## 📄 License

MIT © Gabriel Castro

---

---

# Finance Tracker

Aplicación de gestión de finanzas personales desarrollada como parte del portfolio de CastroDev. Controla tus ingresos, gastos, presupuestos y categorías con una interfaz limpia e intuitiva.

---

## ✨ Funcionalidades

- 📊 **Dashboard** — Balance en tiempo real, resumen de ingresos/gastos y últimos movimientos
- 💸 **Movimientos** — Crear, ver y eliminar transacciones con asignación de categoría
- 📁 **Categorías** — Categorías personalizadas con iconos y colores
- 🎯 **Presupuestos** — Seguimiento mensual con barras de progreso
- 📄 **Exportación** — Exporta movimientos a PDF o Excel
- 📷 **Escaneo OCR** — Escanea facturas automáticamente con Google Cloud Vision
- 👤 **Perfil** — Edita tu nombre, gestiona notificaciones y cambia el idioma
- 🌍 **Multiidioma** — Soporte para español e inglés

---

## 🛠️ Stack Tecnológico

| Capa | Tecnología |
|---|---|
| Framework | Flutter |
| Estado | Riverpod |
| Manejo de errores | fpdart (Either) |
| Modelos | Freezed + json_serializable |
| Red | Dio |
| Autenticación | Firebase Auth (Email + Google) |
| Backend | API REST .NET 10 (Clean Architecture) |
| Base de datos | Cloud Firestore |
| Infraestructura | Google Cloud Run |

---

## 🧭 Decisiones Técnicas

- **Clean Architecture por feature.** Cada feature tiene su propio `data / domain / presentation`. La capa de dominio es Dart puro, sin imports de Flutter, Dio ni Firebase, así que las reglas de negocio se prueban sin dispositivo.
- **Riverpod con `StateNotifier` y estados sellados.** Cada estado de pantalla (`Loading`, `Loaded`, `Error`) es un tipo explícito, y la UI no puede leer datos que no existen. Los providers son el único sitio donde se enlazan las implementaciones concretas, lo que también facilita sustituirlas en los tests.
- **`Either<Failure, T>` en lugar de excepciones.** Los repositorios capturan los errores de infraestructura, registran el detalle técnico con `AppLogger` y devuelven un `Failure` tipado (`network`, `timeout`, `server`, `auth`, `notFound`, `rejected`, `unknown`) construido por un único mapper de `DioException`. Los notifiers y las páginas solo procesan el resultado.
- **Los errores que ve el usuario están localizados, nunca son técnicos.** Las páginas convierten un `Failure` en un texto ARB (es/en) y no muestran el mensaje en bruto. Los formularios siguen abiertos si falla y conservan lo escrito; si una recarga falla con datos en pantalla, se mantiene la lista y sale un SnackBar; si falla la primera carga, se muestra el motivo con un botón de reintento.
- **Freezed para entidades y fallos.** Valores inmutables con igualdad gratis y un `Failure` sellado que obliga a tratar todos los casos.
- **Casos de uso solo donde aportan.** Auth, perfil, escaneo de tickets y exportación tienen casos de uso. El CRUD simple (movimientos, categorías, presupuestos) va del notifier directo al repositorio, para evitar clases que solo reenvían la llamada. El inconveniente es que la regla no es uniforme entre features.
- **API compartida en .NET 10.** Las reglas de negocio y el OCR viven en el servidor; la app envía el token de Firebase mediante un cliente Dio. Un solo backend sirve a todas las apps de este portfolio.
- **Tests con fakes escritos a mano.** Los notifiers, casos de uso y mapeos de repositorios están cubiertos con fakes de las interfaces del dominio, sin librería de mocks. El mapeo de Dio a `Failure` tiene sus propios tests unitarios. La cobertura se centra en el flujo crítico de movimientos y red (ver limitaciones).

### Otros proyectos del portfolio

| Proyecto | Plataforma | Lenguaje |
|---|---|---|
| [finance-tracker](https://github.com/gcalvarez93/finance-tracker) | Flutter (iOS + Android) | Dart |
| [habit-tracker](https://github.com/gcalvarez93/habit-tracker) | Flutter (iOS + Android) | Dart |
| [task-manager](https://github.com/gcalvarez93/task-manager) | iOS | Swift |
| [task-manager-kmp](https://github.com/gcalvarez93/task-manager-kmp) | Android + iOS | Kotlin Multiplatform + Swift |
| [budget-scanner](https://github.com/gcalvarez93/budget-scanner) | iOS | Swift |
| [recipe-manager](https://github.com/gcalvarez93/recipe-manager) | Android | Kotlin |
| [workout-tracker](https://github.com/gcalvarez93/workout-tracker) | Android | Kotlin |
| [castrodev-api](https://github.com/gcalvarez93/castrodev-api) | Backend compartido | C# (.NET 10) |

---

## ⚠️ Limitaciones conocidas

Decisiones asumidas, no descuidos:

- **Sin renovación de sesión ante 401/403 de la API.** La app muestra "tu sesión no es válida", pero no cierra sesión ni reintenta. Firebase renueva el ID token automáticamente antes de cada petición, así que el caso real sería un rechazo del servidor.
- **Sin `sendTimeout`.** El cliente Dio solo define timeouts de conexión (30 s) y de recepción (60 s), así que una subida atascada (escaneo de ticket) no se corta por envío.
- **Cobertura de tests focalizada.** Están cubiertos los movimientos y el mapeo de errores de Dio; los notifiers de presupuestos, categorías y perfil no.
- **El reintento no está en todas partes.** Movimientos, dashboard, presupuestos, categorías y ajustes de notificaciones ofrecen "Reintentar" si falla la primera carga. Exportación y escaneo de tickets solo muestran un mensaje genérico. Un pull-to-refresh fallido en el dashboard conserva los datos anteriores sin avisar.
- **Auth usa los mensajes propios de Firebase.** Los errores de login y registro no pasan por el mapper tipado.
- **Parte del texto de la interfaz sigue fijo en español** (nombres de los meses en presupuestos, nombre de usuario por defecto).

---

## 🚀 Instalación

```bash
# Clonar el repositorio
git clone https://github.com/gcalvarez93/finance-tracker.git

# Instalar dependencias
flutter pub get

# Generar código
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Ejecutar
flutter run --dart-define=API_URL=https://api.castrodev.com

# Ejecutar los tests
flutter test
```

---

## 🔗 Relacionado

- [CastroDev API](https://github.com/gcalvarez93/castrodev-api) — Backend compartido en .NET 10

---

## 📄 Licencia

MIT © Gabriel Castro