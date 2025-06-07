# DevIconGenerator

![DevIconGenerator Logo](https://img.shields.io/badge/DEV-Icon%20Generator-blue?style=for-the-badge)

Una aplicación SwiftUI elegante y fácil de usar para generar iconos de aplicaciones para todas las plataformas de Apple (iOS, iPadOS, macOS y watchOS).

## 📱 Características

- **Soporte multiplataforma**: Genera iconos para iPhone, iPad, Mac y Apple Watch
- **Interfaz intuitiva**: Diseño adaptable para dispositivos móviles y escritorio
- **Drag & Drop**: Arrastra y suelta imágenes directamente en la aplicación
- **Exportación sencilla**: Exporta todos los tamaños de iconos necesarios en un solo archivo ZIP
- **Diseño moderno**: Interfaz de usuario limpia y profesional

## 🖥️ Capturas de pantalla

### Modo Desktop
La aplicación en modo desktop presenta una interfaz con sidebar que facilita la selección de plataformas y la visualización del icono.

### Modo Móvil
En dispositivos móviles, la aplicación se adapta para ofrecer una experiencia optimizada con controles accesibles.

## 🛠️ Requisitos

- iOS 15.0+ / macOS 12.0+
- Xcode 13.0+
- Swift 5.5+

## 📋 Uso

1. **Selecciona una imagen**: Haz clic en el área de imagen o arrastra y suelta una imagen (preferiblemente de 1024x1024 píxeles)
2. **Elige las plataformas**: Selecciona para qué plataformas deseas generar iconos (iPhone, iPad, Mac, Apple Watch)
3. **Exporta**: Haz clic en el botón "Export" para generar y descargar un archivo ZIP con todos los iconos

## 🏗️ Arquitectura

La aplicación está construida siguiendo una arquitectura MVVM (Model-View-ViewModel):

### Modelos
- `AppIcon`: Representa un icono de aplicación con sus propiedades (idioma, tamaño, escala)
- `AppIconType`: Enumera los diferentes tipos de iconos para cada plataforma

### Vistas
- `ContentView`: Vista principal que se adapta según el tamaño de la pantalla
- `ImagePickerView`: Componente para seleccionar imágenes

### ViewModels
- `ViewModel`: Gestiona la lógica de negocio y la comunicación entre la vista y los servicios

### Servicios
- `IconFileGeneratorService`: Coordina la generación de archivos de iconos
- `IconResizerService`: Redimensiona las imágenes a los tamaños requeridos
- `FileIconService`: Maneja las operaciones de archivos y la exportación

## 🚀 Instalación

1. Clona este repositorio
```bash
git clone https://github.com/manuelduarte077/AppIconGenerator.git
```

2. Abre el proyecto en Xcode
```bash
cd AppIconGenerator
open DevIconGenerator.xcodeproj
```

3. Compila y ejecuta la aplicación en el simulador o dispositivo

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para contribuir:

1. Haz un fork del proyecto
2. Crea una rama para tu característica (`git checkout -b feature/amazing-feature`)
3. Haz commit de tus cambios (`git commit -m 'Add some amazing feature'`)
4. Push a la rama (`git push origin feature/amazing-feature`)
5. Abre un Pull Request


## 👨‍💻 Autor

**Manuel Duarte** - [@manuelduarte077](https://github.com/manuelduarte077)

---

Desarrollado con ❤️ usando SwiftUI
