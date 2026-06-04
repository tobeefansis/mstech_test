# MSTech App

Flutter-приложение с чистой архитектурой, Riverpod и Glass Morphism дизайном.

---

## Архитектура

**Feature-First + Clean Architecture**

Каждая функция (feature) разбита на три слоя:

| Слой | Ответственность |
|------|----------------|
| `domain` | Бизнес-логика: абстрактные репозитории, сущности, enum'ы |
| `data` | Реализация репозиториев (SharedPreferences) |
| `presentation` | Экраны, виджеты, Riverpod-провайдеры и состояния |

**State management** — [Riverpod](https://riverpod.dev) с кодогенерацией (`riverpod_generator`).  
**Навигация** — [go_router](https://pub.dev/packages/go_router) с guard-редиректами через `RouterNotifier`.  
**Иммутабельные состояния** — [Freezed](https://pub.dev/packages/freezed).  
**Персистентность** — `SharedPreferences`, инициализируется до старта приложения и пробрасывается через `ProviderScope.overrides`.

---

## Структура проекта

```
lib/
├── main.dart                        # Точка входа, async-инициализация SharedPreferences
├── app.dart                         # Корневой виджет, тема, GlassMorphismThemeProvider
│
├── core/
│   ├── constants/app_constants.dart # Ключи SharedPreferences
│   ├── providers/shared_preferences_provider.dart
│   ├── router/
│   │   ├── app_router.dart          # Маршруты: /onboarding, /subscription, /home, /settings
│   │   └── router_notifier.dart     # Redirect-guards (онбординг → подписка → главная)
│   └── widgets/glass_scaffold.dart  # Общий фон: градиент + цветные блобы
│
└── features/
    ├── onboarding/                  # 2 экрана с Lottie-анимацией
    │   ├── data/                    # OnboardingRepositoryImpl
    │   ├── domain/                  # Абстрактный репозиторий
    │   └── presentation/            # Экраны + OnboardingNotifier + OnboardingState
    │
    ├── subscription/                # Выбор плана: Monthly / Yearly
    │   ├── data/                    # SubscriptionRepositoryImpl
    │   ├── domain/                  # Репозиторий + enum SubscriptionStatus
    │   └── presentation/            # Экран + SubscriptionNotifier + SubscriptionState
    │
    ├── home/                        # Главный экран: сетка эмодзи (4 колонки, 30 штук)
    │   └── presentation/            # HomeScreen + EmojiCell
    │
    └── settings/                    # Настройки: инфо о приложении + Privacy Policy
        └── presentation/            # SettingsScreen
```

---

## Основные зависимости

| Пакет | Назначение |
|-------|-----------|
| `flutter_riverpod` + `riverpod_generator` | State management с кодогенерацией |
| `go_router` | Декларативная навигация |
| `freezed` | Иммутабельные data-классы |
| `shared_preferences` | Локальное хранение состояния |
| `lottie` | JSON-анимации на экранах онбординга |
| `flutter_glass_morphism` | Glass Morphism UI-компоненты |
| `url_launcher` | Открытие Privacy Policy в браузере |

---

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
