# 🌤️ Weather App - Flutter Connected Application

Une application météo complète avec authentification, appels API, cache local, et mode hors ligne.

## 🎯 Fonctionnalités

- ✅ **Authentification** (Login/Register/Logout) avec JWT
- ✅ **3+ Écrans** (Splash, Login, Register, Home, Detail)
- ✅ **API REST** avec OpenWeatherMap
- ✅ **Cache Local** avec Hive
- ✅ **Mode Hors Ligne** - Données en cache quand pas de réseau
- ✅ **Gestion d'Erreurs** avec messages utilisateur
- ✅ **Clean Architecture** (data/domain/presentation)
- ✅ **Repository Pattern** pour l'accès aux données
- ✅ **Dio** pour les appels réseau
- ✅ **Intercepteurs** pour l'injection de token
- ✅ **Tests Unitaires** (3+ sur le repository)

## 🛠️ Technologies

- **Flutter** 3.0+
- **Dio** - Client HTTP
- **Retrofit** - API client
- **Hive** - Base de données locale
- **Bloc** - Gestion d'état
- **GetIt** - Injection de dépendances
- **OpenWeatherMap API** - Données météo

## 🚀 Installation

### Prérequis
- Flutter SDK 3.0+
- Clé API OpenWeatherMap

### Étapes

```bash
# 1. Cloner le repository
git clone https://github.com/votre-username/weather_app.git
cd weather_app

# 2. Configurer la clé API
# Créer un fichier .env à la racine
API_KEY=votre_clé_api_ici

# 3. Installer les dépendances
flutter pub get

# 4. Générer les fichiers de code
flutter pub run build_runner build

# 5. Lancer l'application
flutter run

lib/
├── core/           # Shared utilities, network, errors
├── data/           # Data layer (models, datasources, repositories)
├── domain/         # Domain layer (entities, repositories, usecases)
├── presentation/   # Presentation layer (bloc, screens, widgets)
└── injection/      # Dependency injection