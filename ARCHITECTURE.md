# Arquitectura de DevIconGenerator

Este documento describe la arquitectura y los patrones de diseño utilizados en la aplicación DevIconGenerator.

## Patrón de Arquitectura: MVVM

DevIconGenerator utiliza el patrón de arquitectura Model-View-ViewModel (MVVM), que separa la lógica de presentación de la lógica de negocio y los datos:

### Model (Modelo)
Representa los datos y la lógica de negocio de la aplicación.

### View (Vista)
Representa la interfaz de usuario y es responsable de mostrar los datos al usuario.

### ViewModel (Modelo de Vista)
Actúa como intermediario entre el Modelo y la Vista, gestionando la lógica de presentación y las transformaciones de datos.

## Estructura de Directorios

La aplicación está organizada en una estructura de directorios que refleja la arquitectura MVVM y facilita la navegación y mantenimiento del código:

```
DevIconGenerator/
├── Views/                  # Vistas y componentes de UI
│   ├── ContentView.swift   # Vista principal adaptativa
│   └── Components/         # Componentes reutilizables
│       ├── ImagePickerView.swift
│       ├── IconPreviewView.swift
│       ├── PlatformOptionsView.swift
│       ├── StatusMessageView.swift
│       └── ExportButton.swift
├── ViewModels/             # Modelos de vista
│   └── ViewModel.swift     # ViewModel principal
├── Models/                 # Modelos de datos
│   ├── AppIcon.swift       # Modelo para iconos de aplicación
│   └── Enums.swift         # Enumeraciones para tipos y roles
├── Services/               # Servicios para lógica de negocio
│   ├── IconFileGeneratorService.swift
│   ├── IconResizerService.swift
│   └── FileIconService.swift
├── Utils/                  # Utilidades y extensiones
│   ├── Constants.swift     # Constantes globales
│   └── Extensions.swift    # Extensiones de tipos
└── DevIconGeneratorApp.swift  # Punto de entrada de la aplicación
```

## Componentes Principales

### Vistas

#### ContentView
- Vista principal que se adapta entre modo desktop y móvil
- Utiliza `horizontalSizeClass` para determinar el layout
- Compuesta por componentes reutilizables

#### Componentes Reutilizables
- **IconPreviewView**: Muestra la previsualización del icono seleccionado
- **PlatformOptionsView**: Permite seleccionar las plataformas de destino
- **StatusMessageView**: Muestra mensajes de estado (progreso, éxito, error)
- **ExportButton**: Botón para la exportación de iconos
- **ImagePickerView**: Integra UIKit para seleccionar imágenes

### ViewModel

El ViewModel gestiona:
- La selección y procesamiento de imágenes
- El estado de la exportación
- La comunicación con los servicios
- Las opciones de plataforma seleccionadas

### Servicios

- **IconFileGeneratorService**: Coordina la generación de archivos de iconos
- **IconResizerService**: Redimensiona las imágenes a los tamaños requeridos
- **FileIconService**: Maneja las operaciones de archivos y la exportación

### Utilidades

- **Constants**: Define constantes globales para la aplicación
- **Extensions**: Extensiones para mejorar la funcionalidad de tipos básicos

## Flujo de Datos

1. El usuario interactúa con la Vista (ContentView)
2. La Vista notifica al ViewModel sobre las acciones del usuario
3. El ViewModel procesa las acciones y actualiza su estado
4. El ViewModel utiliza los Servicios para realizar operaciones complejas
5. Los Servicios devuelven resultados al ViewModel
6. El ViewModel actualiza su estado
7. La Vista observa los cambios en el ViewModel y se actualiza

## Patrones de Diseño Adicionales

### Dependency Injection
Los servicios se inyectan en el ViewModel para facilitar las pruebas y la modularidad.

### Observer Pattern
SwiftUI utiliza el patrón Observer a través de `@Published`, `@ObservedObject`, y `@StateObject`.

### Composition over Inheritance
Se prefiere la composición sobre la herencia, utilizando componentes reutilizables.

## Consideraciones de Rendimiento

- Las operaciones intensivas se realizan en hilos en segundo plano
- Las imágenes se procesan de manera eficiente para evitar problemas de memoria
- La interfaz de usuario se mantiene receptiva durante las operaciones largas

## Extensibilidad

La arquitectura está diseñada para ser extensible:
- Nuevas plataformas pueden añadirse fácilmente en el enum `AppIconType`
- Nuevos componentes de UI pueden crearse y reutilizarse
- Nuevos servicios pueden integrarse sin modificar la estructura existente
