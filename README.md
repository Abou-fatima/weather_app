# 🌤️ Weather App - Flutter Connected Application

Une application météo moderne et complète construite avec Flutter, démontrant une architecture professionnelle avec authentification JWT, appels API REST, cache local persistant, et support complet du mode hors ligne.

**Statut du projet** : ✅ Production-ready avec tests unitaires complets et validation d'architecture.

---

## 📋 Table des matières

- [🎯 Fonctionnalités](#-fonctionnalités)
- [🛠️ Technologies](#-technologies)
- [📂 Architecture](#-architecture)
- [🚀 Installation](#-installation)
- [⚙️ Configuration](#-configuration)
- [📱 Écrans et Navigation](#-écrans-et-navigation)
- [🔐 Authentification](#-authentification)
- [🌐 API et Appels Réseau](#-api-et-appels-réseau)
- [💾 Cache Local et Mode Hors Ligne](#-cache-local-et-mode-hors-ligne)
- [🧪 Tests](#-tests)
- [📚 Structure du Projet](#-structure-du-projet)
- [🔧 Troubleshooting](#-troubleshooting)
- [🤝 Contribution](#-contribution)
- [📄 License](#-license)

---

## 🎯 Fonctionnalités

### ✅ Authentification et Utilisateurs
- **Inscription (Register)** - Création de compte avec validation d'email
- **Connexion (Login)** - Authentification JWT sécurisée
- **Déconnexion (Logout)** - Destruction propre de la session
- **Stockage de profil** - Données utilisateur en cache local (Hive)
- **Token management** - Injection automatique de tokens dans les requêtes

### ✅ Données Météo
- **Météo en temps réel** - Récupération de la météo actuelle via OpenWeatherMap API
- **Prévisions** - Support des prévisions météo (extensible)
- **Multiple villes** - Possibilité de rechercher la météo de différentes villes
- **Détails complets** - Température, humidité, vitesse du vent, description, icônes

### ✅ Persistance et Synchronisation
- **Cache intelligent** - Hive pour stockage local performant
- **Cache expirant** - Données expirées après 30 minutes (configurable)
- **Synchronisation** - Actualisation intelligente des données
- **Historique** - Accès aux données en cache quand disponible

### ✅ Connectivité Réseau
- **Détection de connexion** - Vérification continue de la connexion internet
- **Mode hors ligne** - Utilisation transparente du cache quand pas de réseau
- **Gestion d'erreurs** - Messages clairs pour erreurs réseau et API
- **Retry automatique** - Configuration pour les tentatives automatiques

### ✅ Architecture et Qualité de Code
- **Clean Architecture** - Séparation data/domain/presentation
- **Injection de dépendances** - GetIt pour une configuration centralisée
- **Repository Pattern** - Abstraction de l'accès aux données
- **Tests unitaires** - 9+ tests couvrant les repositories
- **Gestion d'état** - BLoC pattern pour une UI réactive
- **Code quality** - Linting et analyse statique Flutter

---

## 🛠️ Technologies

### Framework et UI
| Technologie | Version | Rôle |
|-------------|---------|------|
| **Flutter** | 3.0+ | Framework multi-plateforme |
| **Dart** | Récente | Langage de programmation |
| **Material Design 3** | Intégré | Design system |

### Architecture et État
| Technologie | Version | Rôle |
|-------------|---------|------|
| **flutter_bloc** | 8.1.3 | Gestion d'état réactive |
| **get_it** | 7.6.4 | Injection de dépendances (Service Locator) |
| **equatable** | 2.0.5 | Comparaison d'objets Dart |

### Réseau et API
| Technologie | Version | Rôle |
|-------------|---------|------|
| **dio** | 5.4.0 | Client HTTP moderne |
| **retrofit** | 4.0.3+ | Générateur API client (type-safe) |
| **logger** | 2.0.2 | Logging des requêtes réseau |

### Stockage et Persistance
| Technologie | Version | Rôle |
|-------------|---------|------|
| **hive_flutter** | 1.1.0 | NoSQL database locale performante |
| **hive** | 2.2.3 | Core Hive |
| **path_provider** | 2.1.1 | Accès aux répertoires de l'app |

### Connectivité
| Technologie | Version | Rôle |
|-------------|---------|------|
| **connectivity_plus** | 5.0.2 | Vérification de l'état réseau |

### Utilitaires
| Technologie | Version | Rôle |
|-------------|---------|------|
| **dartz** | 0.10.1 | Functional programming (Either, Task) |
| **flutter_dotenv** | 5.1.0 | Gestion des variables d'environnement |
| **flutter_svg** | 2.0.9 | Rendu des images SVG |
| **intl** | 0.18.1 | Internationalization |
| **shimmer** | 3.0.0 | Loading skeletons |
| **pull_to_refresh** | 2.0.0 | Refresh pull-to-refresh |

### Outils de Développement
| Outil | Version | Rôle |
|------|---------|------|
| **build_runner** | 2.4.7 | Générateur de code |
| **retrofit_generator** | 7.0.8 | Génération API |
| **mockito** | 5.4.3 | Mocking pour tests |
| **flutter_lints** | 3.0.0 | Règles linting Flutter |

---

## 📂 Architecture

### Clean Architecture (3 couches)

L'application suit l'architecture propre avec trois couches bien définies :

```
Presentation Layer (BLoC, UI)
         ↓
   Domain Layer (Entities, UseCases)
         ↓
    Data Layer (Repositories, DataSources)
```

### Flux de données

```
User Interaction (Screen)
    ↓
WeatherBLoC (Event)
    ↓
UseCase (GetCurrentWeather)
    ↓
WeatherRepository (Interface)
    ↓
WeatherRepositoryImpl (Implémentation)
    ↓
RemoteDataSource (API Dio) + LocalDataSource (Hive)
    ↓
Weather Entity (Domain)
    ↓
BLoC State (WeatherLoaded)
    ↓
UI Update
```

### Couches de l'architecture

#### 🎨 **Presentation Layer** (`lib/presentation`)
Responsable de l'interface utilisateur et de la gestion d'état.

- **BLoC Pattern** - Gestion centralisée des états
  - `weather_bloc.dart` - Bloc pour la météo
  - `auth_bloc.dart` - Bloc pour l'authentification
- **Screens** - Pages de navigation
  - `splash_screen.dart` - Écran de lancement
  - `login_screen.dart` - Connexion utilisateur
  - `register_screen.dart` - Inscription
  - `home_screen.dart` - Écran principal (météo)
  - `weather_detail_screen.dart` - Détails météo
- **Widgets** - Composants réutilisables
  - `weather_card.dart` - Affichage météo
  - `loading_widget.dart` - Indicateur de chargement
  - `error_widget.dart` - Affichage d'erreurs
  - `custom_text_field.dart` - Champs personnalisés

#### 🧠 **Domain Layer** (`lib/domain`)
Contient la logique métier et les interfaces (contrats).

- **Entities** - Objets de domaine purs
  - `Weather` - Entité météo
  - `Forecast` - Entité prévisions
  - `User` - Entité utilisateur
- **Repositories** - Interfaces (contrats)
  - `WeatherRepository` - Interface des opérations météo
  - `AuthRepository` - Interface authentification
- **UseCases** - Logique métier encapsulée
  - `GetCurrentWeather` - Récupère météo actuelle
  - `GetForecast` - Récupère prévisions
  - `GetCachedWeather` - Charge depuis cache
  - `ClearCache` - Vide le cache
  - `Login`, `Register`, `Logout` - Gestion auth

#### 💾 **Data Layer** (`lib/data`)
Implémente les interfaces de domaine avec vraies sources de données.

- **Models** - Représentation données (JSON)
  - `WeatherModel` - Mappage API → Entity
  - `UserModel` - Mappage auth → Entity
- **DataSources** - Abstraction sources de données
  - `WeatherRemoteDataSource` - Appels API OpenWeatherMap
  - `WeatherLocalDataSource` - Stockage Hive
  - `AuthRemoteDataSource` - API authentification
- **Repositories** - Implémentations des interfaces domaine
  - `WeatherRepositoryImpl` - Logique météo (réseau + cache)
  - `AuthRepositoryImpl` - Logique auth

### Couche Core (`lib/core`)
Utilitaires partagés par toutes les couches.

- **Network** - Configuration réseau
  - `network_info.dart` - Détection connexion
  - `connectivity_service.dart` - Service de connectivité
- **Errors** - Définitions d'erreurs
  - `exceptions.dart` - Exceptions métier
  - `failures.dart` - Failures applicatifs
- **Constants** - Constantes globales
  - `app_constants.dart` - API keys, URLs, configuration

### Injection de Dépendances (`lib/injection`)

Centralisation de la création des instances avec GetIt :

```dart
final sl = GetIt.instance;

void setupDependencyInjection() {
  // BLoCs
  sl.registerSingleton<WeatherBloc>(WeatherBloc(...));
  
  // UseCases
  sl.registerSingleton<GetCurrentWeather>(
    GetCurrentWeather(sl<WeatherRepository>())
  );
  
  // Repositories
  sl.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      remoteDataSource: sl<WeatherRemoteDataSource>(),
      localDataSource: sl<WeatherLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    )
  );
  
  // DataSources
  sl.registerSingleton<Dio>(createDioInstance());
  sl.registerSingleton<WeatherRemoteDataSource>(
    WeatherRemoteDataSourceImpl(sl<Dio>())
  );
}
```

---

## 🚀 Installation

### Prérequis

- **Flutter SDK** : 3.0 ou supérieur
  ```bash
  flutter --version
  # Doit afficher: Flutter 3.x.x
  ```
- **Dart SDK** : Inclus dans Flutter
- **Git** : Pour cloner le repository
- **IDE** : VS Code, Android Studio, ou IntelliJ IDEA
  - Extension Flutter recommandée

### Étapes d'installation

#### 1. Cloner le repository

```bash
git clone https://github.com/Abou-fatima/weather_app.git
cd weather_app
```

#### 2. Configurer l'environnement

Créer le fichier `.env` depuis le template fourni :

```bash
# Depuis le répertoire racine du projet
cp .env.example .env
```

#### 3. Éditer `.env` et ajouter votre clé API

```bash
# Ouvrir le fichier .env
# Windows
notepad .env

# macOS/Linux
nano .env
```

Remplacer `your_api_key_here` par votre vraie clé :

```env
OPENWEATHER_API_KEY=your_actual_api_key_here_12345
```

> ⚠️ **Important** : Ne jamais commiter ce fichier. Il est dans `.gitignore`.

#### 4. Installer les dépendances Flutter

```bash
flutter pub get
```

#### 5. Lancer l'application

```bash
# Sur un device/émulateur connecté
flutter run

# Options utiles :
flutter run -d android          # Spécifier une plateforme
flutter run --release           # Mode release
flutter run --profile           # Mode profiling
flutter run -v                  # Mode verbeux (debug)
```

### Vérification de l'installation

Après le lancement, vérifier que :
- ✅ L'écran de splash s'affiche
- ✅ Navigation vers login/register fonctionne
- ✅ Pas d'erreurs dans la console Flutter
- ✅ L'app accepte les interactions

---

## ⚙️ Configuration

### Variables d'environnement (`.env`)

| Variable | Description | Exemple |
|----------|-------------|---------|
| `OPENWEATHER_API_KEY` | Clé API OpenWeatherMap | `854d7e0b...` |

### Constantes applicatives (`lib/core/constants/app_constants.dart`)

```dart
class AppConstants {
  // API
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String get apiKey => /* charge depuis .env */;
  
  // Cache
  static const Duration cacheDuration = Duration(minutes: 30);
  static const Duration timeoutDuration = Duration(seconds: 30);
  
  // Hive
  static const String hiveBoxName = 'weatherBox';
  static const String hiveUserBox = 'userBox';
}
```

### Dio Configuration

Dio est configuré avec :
- **Base URL** : https://api.openweathermap.org/data/2.5
- **Timeout** : 30 secondes
- **Intercepteurs** : Injection de token JWT
- **Logging** : Logger pour debug

```dart
Dio createDioInstance() {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.timeoutDuration,
      receiveTimeout: AppConstants.timeoutDuration,
    ),
  )..interceptors.addAll([
    AuthInterceptor(sl<AuthRepository>()),
    LoggingInterceptor(),
  ]);
}
```

### Hive Configuration

Hive est initialisé au démarrage de l'app :

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Setup DI
  setupDependencyInjection();
  
  runApp(const MyApp());
}
```

---

## 📱 Écrans et Navigation

### Navigation avec GoRouter

L'app utilise `go_router` pour une navigation déclarative et type-safe.

```
SplashScreen (Démarrage)
    ↓ (basé sur état d'authentification)
    ├→ LoginScreen / RegisterScreen (pas authentifié)
    └→ HomeScreen (authentifié)
         ├→ WeatherDetailScreen
         └→ ProfileScreen
```

### Écrans détaillés

#### 🎬 **SplashScreen** (`splash_screen.dart`)
- **Affichage** : Écran de lancement avec logo
- **Durée** : ~2-3 secondes
- **Action** : Vérifie l'authentification et navigue
- **États** : Initial, Loading, Redirect

#### 🔐 **LoginScreen** (`login_screen.dart`)
- **Champs** : Email + Mot de passe
- **Validation** : Email format, password length
- **Actions** : Login, Register link
- **États** : Initial, Loading, Success, Error
- **Erreurs** : Credentials invalides, network error

#### 📝 **RegisterScreen** (`register_screen.dart`)
- **Champs** : Email, Username, Password, Confirm Password
- **Validation** : Tous les champs validés
- **Actions** : Register, Login link
- **États** : Initial, Loading, Success, Error
- **Erreurs** : User exists, validation failed

#### 🏠 **HomeScreen** (`home_screen.dart`)
- **Affichage** : Météo actuelle + liste villes
- **Fonctionnalités** :
  - Search bar pour chercher villes
  - Pull-to-refresh
  - Mode hors ligne (icône)
  - Bouton logout
- **États** : Initial, Loading, Loaded, Error, Cached

#### 📊 **WeatherDetailScreen** (`weather_detail_screen.dart`)
- **Affichage** : Détails complets de la météo
- **Infos** : Temp, humidity, wind, pressure
- **Graphes** : Température (si prévisions)
- **Actions** : Retour, partage (si API), refresh

---

## 🔐 Authentification

### Flux d'authentification

```
User Input (Email + Password)
    ↓
AuthBLoC.LoginEvent
    ↓
Login UseCase
    ↓
AuthRepository.login()
    ↓
AuthRemoteDataSource.login(credentials)
    ↓ (API Request)
API Response (User + JWT Token)
    ↓
Token stored in Hive
    ↓
BLoC emits AuthAuthenticated
    ↓
Navigation to HomeScreen
```

### JWT Token Management

**Storage** : Tokens stockés dans Hive (encrypted box)

**Injection** : Intercepteur Dio injecte le token automatiquement

```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getTokenFromCache();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

**Refresh** : Token rafraîchi automatiquement si expiré (extensible)

**Logout** : Token supprimé de Hive lors du logout

### Sécurité

- ✅ Tokens jamais loggés ou exposés
- ✅ Stockage sécurisé dans Hive
- ✅ HTTPS obligatoire en production
- ✅ Validation d'email côté serveur

---

## 🌐 API et Appels Réseau

### OpenWeatherMap API

**Base URL** : `https://api.openweathermap.org/data/2.5`

**Endpoints utilisés** :

| Endpoint | Méthode | Paramètres | Retour |
|----------|---------|-----------|--------|
| `/weather` | GET | `q` (city), `appid` (key) | Weather actuelle |
| `/forecast` | GET | `q` (city), `appid` (key) | Prévisions 5 jours |

### Exemple d'appel

```dart
// Interface (domain)
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String city);
}

// UseCase (domain)
class GetCurrentWeather implements UseCase<Weather, GetCurrentWeatherParams> {
  final WeatherRepository repository;
  
  @override
  Future<Either<Failure, Weather>> call(GetCurrentWeatherParams params) async {
    return repository.getCurrentWeather(params.city);
  }
}

// BLoC usage (presentation)
on<GetWeatherEvent>((event, emit) async {
  emit(WeatherLoading());
  
  final result = await getCurrentWeather(
    GetCurrentWeatherParams(city: event.city)
  );
  
  result.fold(
    (failure) => emit(WeatherError(failure.message)),
    (weather) => emit(WeatherLoaded(weather)),
  );
});
```

### Gestion des erreurs

**Exception** → **Failure** mapping :

```dart
try {
  final weatherModel = await remoteDataSource.getCurrentWeather(...);
  return Right(weatherModel.toEntity());
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
} on NetworkException catch (e) {
  return Left(NetworkFailure(e.message));
}
```

**Types de Failures** :

- `ServerFailure` - Erreur API (4xx, 5xx)
- `NetworkFailure` - Pas de connexion
- `CacheFailure` - Erreur cache local
- `AuthFailure` - Erreur authentification

---

## 💾 Cache Local et Mode Hors Ligne

### Hive Database

**Type** : NoSQL key-value store, persiste automatiquement sur disque

**Configuration** :

```dart
await Hive.initFlutter();
final box = await Hive.openBox(AppConstants.hiveBoxName);
await box.put('current_weather', weatherModel);
```

### Stratégie de cache

**TTL (Time-To-Live)** : 30 minutes

```dart
// Lors du cache
await _weatherBox.put('timestamp', DateTime.now().millisecondsSinceEpoch);

// Lors de la lecture
final cached = await _weatherBox.get('current_weather');
final timestamp = await _weatherBox.get('timestamp');
final age = now - timestamp;

if (age > Duration(minutes: 30)) {
  // Cache expiré, retourner null
  return null;
}
return cached;
```

### Mode hors ligne

**Détection réseau** :

```dart
// Check online/offline status
final isConnected = await networkInfo.isConnected;

// Dio retry logic
if (!isConnected) {
  // Use cached data
  return await localDataSource.getCachedWeather();
}
```

**Flux de données** :

1. **Online** → Fetch API → Cache → Return fresh
2. **Offline** → Return cached ou Error

**Transparence** : L'UI affiche clairement si données en cache (icône, badge)

---

## 🧪 Tests

### Tests unitaires

**Couverture** : Repository + DataSources (9+ tests)

**Location** : `test/data/repositories/`

### Structure des tests

```dart
// Test setup avec fakes
class FakeWeatherRemoteDataSource implements WeatherRemoteDataSource {
  // Implémentation mock
}

class FakeWeatherLocalDataSource implements WeatherLocalDataSource {
  // Implémentation mock
}

void main() {
  group('WeatherRepository', () {
    setUp(() {
      // Initialiser les fakes
    });
    
    test('should return weather when connected', () async {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

### Exécuter les tests

```bash
# Tous les tests
flutter test

# Tests spécifiques
flutter test test/data/repositories/weather_repository_test.dart

# Avec couverture
flutter test --coverage

# Afficher les résultats
open coverage/lcov-report/index.html  # macOS
# ou
start coverage/lcov-report/index.html  # Windows
```

### Résultats actuels

✅ **9 tests passants**
- WeatherRepository tests (success, failure, caching)
- Widget tests (smoke tests)

---

## 📚 Structure du Projet

```
weather_app/
├── lib/
│   ├── main.dart                          # Entry point
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart        # Constantes globales, API keys
│   │   ├── errors/
│   │   │   ├── exceptions.dart           # Exceptions métier
│   │   │   └── failures.dart             # Failures applicatifs
│   │   ├── network/
│   │   │   ├── network_info.dart         # Interface détection réseau
│   │   │   └── connectivity_service.dart # Implémentation connectivité
│   │   └── utils/
│   │       └── result.dart               # Utilitaires résultats
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── weather.dart              # Entité Weather (pur)
│   │   │   ├── forecast.dart             # Entité Forecast
│   │   │   └── user.dart                 # Entité User
│   │   ├── repositories/
│   │   │   ├── weather_repository.dart   # Interface WeatherRepository
│   │   │   └── auth_repository.dart      # Interface AuthRepository
│   │   └── usecases/
│   │       ├── get_current_weather.dart  # UC: Récupère météo actuelle
│   │       ├── get_forecast.dart         # UC: Récupère prévisions
│   │       ├── get_cached_weather.dart   # UC: Charge depuis cache
│   │       ├── clear_cache.dart          # UC: Vide le cache
│   │       ├── login.dart                # UC: Authentification
│   │       ├── register.dart             # UC: Inscription
│   │       └── logout.dart               # UC: Déconnexion
│   │
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── remote/
│   │   │   │   ├── weather_remote_datasource.dart  # Interface API météo
│   │   │   │   └── auth_remote_datasource.dart     # Interface API auth
│   │   │   └── local/
│   │   │       └── weather_local_datasource.dart   # Interface Hive cache
│   │   ├── models/
│   │   │   ├── weather_model.dart         # DTO météo (JSON ↔ Entity)
│   │   │   ├── forecast_model.dart        # DTO prévisions
│   │   │   └── user_model.dart            # DTO utilisateur
│   │   └── repositories/
│   │       ├── weather_repository_impl.dart  # Implémentation WeatherRepository
│   │       └── auth_repository_impl.dart     # Implémentation AuthRepository
│   │
│   ├── presentation/
│   │   ├── bloc/
│   │   │   ├── weather/
│   │   │   │   ├── weather_bloc.dart      # BLoC météo
│   │   │   │   ├── weather_event.dart     # Events météo
│   │   │   │   └── weather_state.dart     # States météo
│   │   │   └── auth/
│   │   │       ├── auth_bloc.dart         # BLoC auth
│   │   │       ├── auth_event.dart        # Events auth
│   │   │       └── auth_state.dart        # States auth
│   │   ├── screens/
│   │   │   ├── splash_screen.dart         # Écran lancement
│   │   │   ├── login_screen.dart          # Écran connexion
│   │   │   ├── register_screen.dart       # Écran inscription
│   │   │   ├── home_screen.dart           # Écran accueil
│   │   │   └── weather_detail_screen.dart # Écran détails météo
│   │   └── widgets/
│   │       ├── weather_card.dart          # Widget affichage météo
│   │       ├── loading_widget.dart        # Widget chargement
│   │       ├── error_widget.dart          # Widget erreurs
│   │       └── custom_text_field.dart     # Widget input personnalisé
│   │
│   └── injection/
│       └── dependency_injection.dart      # Configuration GetIt
│
├── test/
│   ├── widget_test.dart                   # Tests smoke
│   └── data/
│       └── repositories/
│           └── weather_repository_test.dart  # Tests repository
│
├── .env                                    # Variables d'environnement (⚠️ .gitignored)
├── .env.example                            # Template .env pour setup
├── pubspec.yaml                            # Dépendances Flutter
├── analysis_options.yaml                   # Configuration linting
└── README.md                               # Ce fichier
```

---

## 🔧 Troubleshooting

### Erreurs courantes

#### ❌ `OPENWEATHER_API_KEY not found`

**Cause** : `.env` non configuré ou fichier manquant

**Solution** :
```bash
cp .env.example .env
# Éditer .env et ajouter votre vraie clé API
```

**Vérification** :
```bash
cat .env
# Doit afficher: OPENWEATHER_API_KEY=<votre_clé>
```

#### ❌ `Connection refused` ou `Failed to fetch weather`

**Cause** : Clé API invalide ou API OpenWeatherMap indisponible

**Solution** :
1. Vérifier que la clé API est valide
2. Tester l'API manuellement : `https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_KEY`
3. Vérifier la connexion internet

#### ❌ Hive database errors

**Cause** : Version Flutter/Dart incompatible ou cache corrompu

**Solution** :
```bash
# Nettoyer build et cache
flutter clean

# Récupérer les dépendances
flutter pub get

# Rebuild
flutter run
```

#### ❌ BLoC events not triggering

**Cause** : BLoC pas enregistré dans GetIt ou événement mal formé

**Solution** :
```dart
// Vérifier injection (lib/injection/dependency_injection.dart)
sl.registerSingleton<WeatherBloc>(WeatherBloc(...));

// Vérifier usage dans la UI
BlocProvider.of<WeatherBloc>(context).add(GetWeatherEvent('Paris'));
```

#### ❌ "A class cannot implement an abstract class"

**Cause** : Méthode abstraite pas implémentée dans la classe concrète

**Solution** : Implémenter toutes les méthodes abstraites, utiliser VS Code ou IDE pour auto-implémenter

#### ❌ `MissingPluginException` pour connectivity_plus

**Cause** : Plugin pas compilé pour la plateforme

**Solution** :
```bash
flutter pub get
flutter run

# Si toujours le problème, forcer la rebuild du plugin
flutter clean
flutter pub get
flutter run --no-build-cache
```

### Logging et Debug

**Activer verbose logging** :
```bash
flutter run -v
```

**Voir les logs Hive** :
```dart
Hive.debugPrint = true;
```

**Voir les logs Dio** :
```dart
dio.interceptors.add(LoggingInterceptor(
  level: Level.body,  // Level.headers, Level.response, Level.body
));
```

### Performance

**Profiling** :
```bash
flutter run --profile

# Puis ouvrir DevTools
flutter pub global activate devtools
dart devtools
```

**Memory leaks** : Vérifier que les BLoCs sont fermés proprement dans la UI

---

## 🤝 Contribution

### Comment contribuer

1. **Fork** le repository
2. **Créer une branche** : `git checkout -b feature/ma-feature`
3. **Faire les changements**
4. **Écrire les tests** : `flutter test`
5. **Linter le code** : `flutter analyze`
6. **Commiter** : `git commit -m "feat: description claire"`
7. **Push** : `git push origin feature/ma-feature`
8. **Créer une Pull Request**

### Conventions de code

- ✅ Format : `dart format .` (Dart formatter)
- ✅ Lint : `flutter analyze` (0 errors/warnings)
- ✅ Nommage : camelCase pour variables/méthodes, PascalCase pour classes
- ✅ Documentation : Commenter le code complexe et les APIs publiques
- ✅ Tests : Minimum 80% de couverture pour new code

### Checklist avant un PR

- [ ] Code formaté (`dart format .`)
- [ ] Tests ajoutés/modifiés
- [ ] `flutter test` passe
- [ ] `flutter analyze` 0 erreurs
- [ ] README mis à jour si changement API
- [ ] Pas de dépendances inutilisées

---

## 📄 License

Ce projet est sous licence **MIT**.

---

## 📞 Support et Questions

- 📧 **Email** : Abou-fatima@example.com
- 🐛 **Issues** : GitHub Issues
- 💬 **Discussions** : GitHub Discussions

---

## 🎓 Ressources d'apprentissage

### Flutter
- [Flutter Official Docs](https://flutter.dev/docs)
- [Flutter Codelabs](https://codelabs.developers.google.com/?product=flutter)

### Architecture
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain-Driven Design](https://www.domainlanguage.com/ddd/)

### BLoC
- [BLoC Library](https://bloclibrary.dev)
- [BLoC Tutorials](https://bloclibrary.dev/#/fluttertodostutorial)

### Testing
- [Flutter Testing](https://flutter.dev/docs/testing)
- [Mockito](https://github.com/dart-lang/mockito)

---

**Last updated**: 2026-08-13
**Version**: 1.0.0
**Status**: ✅ Production-Ready


