# Guía de Instalación para Mariposario RA

## 1. Instalar Flutter

Sigue la guía oficial según tu sistema operativo:

- [Instalación Flutter](https://docs.flutter.dev/get-started/install)

### Requisitos mínimos

- macOS (para compilar iOS), Windows o Linux
- Xcode (solo para iOS)
- Android Studio (para Android)
- Git
- Un dispositivo físico compatible con AR (opcional pero recomendado)

---

## 2. Tips de Instalación por Sistema Operativo

### Linux

- Instala dependencias básicas:

  ```bash
  sudo apt update && sudo apt install git curl unzip xz-utils
  ```

- Descarga y descomprime Flutter desde la [página oficial](https://docs.flutter.dev/get-started/install/linux).
- Añade Flutter al PATH en tu `.bashrc` o `.zshrc`.
- Instala Android Studio para emulador y SDK.

### Windows

- Descarga el SDK de Flutter (archivo zip) desde la [página oficial](https://docs.flutter.dev/get-started/install/windows).
- Extrae y añade Flutter al PATH (variables de entorno).
- Instala Android Studio y asegúrate de instalar el Android SDK.
- Usa PowerShell o CMD para comandos.

### macOS

- Instala Xcode desde la App Store.
- Instala Android Studio si quieres compilar para Android.
- Descarga Flutter desde la [página oficial](https://docs.flutter.dev/get-started/install/macos).
- Añade Flutter al PATH en tu shell (`.zshrc` o `.bash_profile`).

---

## 3. Clonar el repositorio

```bash
git clone <URL_DE_TU_REPO>
cd mariposario_ra
```

## 4. Instalar dependencias

```bash
flutter pub get
```

## 5. Ejecutar la app

- **Android:**

  ```bash
  flutter run -d android
  ```

- **iOS (requiere Mac):**

  ```bash
  flutter run -d ios
  ```

---

## 6. Habilitar Realidad Aumentada

- Edita `pubspec.yaml` y descomenta la línea:

  ```yaml
  ar_flutter_plugin: ^0.7.3
  ```

- Ejecuta:

  ```bash
  flutter pub get
  ```

- Sigue las instrucciones en el README para permisos y configuración de AR.

---

## Checklist de problemas comunes

- ¿Flutter está en tu PATH? Prueba `flutter doctor`.
- ¿Tienes permisos de cámara en Android/iOS?
- ¿Tu dispositivo soporta ARCore (Android) o ARKit (iOS)?
- ¿Agregaste los assets de mariposas y modelos correctamente?
- Si usas emulador, la RA **no funcionará**: usa un dispositivo físico.

---

Si tienes dudas, consulta la documentación oficial de Flutter o abre un issue en el repositorio.
