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
- Clé API OpenWeatherMap (gratuite sur https://openweathermap.org/api)

### Étapes

```bash
# 1. Cloner le repository
git clone https://github.com/Abou-fatima/weather_app.git
cd weather_app

# 2. Configurer l'environnement
# Copier le fichier .env.example en .env
cp .env.example .env

# 3. Éditer .env et ajouter votre clé API
# OPENWEATHER_API_KEY=votre_vraie_clé_api

# 4. Installer les dépendances
flutter pub get

# 5. Lancer l'application
flutter run
```

### Configuration de la clé API

1. Aller sur https://openweathermap.org/api
2. Créer un compte gratuit
3. Générer une clé API
4. Copier la clé dans le fichier `.env` créé depuis `.env.example`
5. **Ne pas commiter `.env`** — il est dans `.gitignore`

## 📂 Structure du Projet
├── core/           # Shared utilities, network, errors
├── data/           # Data layer (models, datasources, repositories)
├── domain/         # Domain layer (entities, repositories, usecases)
├── presentation/   # Presentation layer (bloc, screens, widgets)
└── injection/      # Dependency injection