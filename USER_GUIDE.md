# Guía de Usuario - DevIconGenerator

Esta guía te ayudará a utilizar DevIconGenerator para crear iconos de aplicación para todas las plataformas de Apple.

## Índice

1. [Introducción](#introducción)
2. [Requisitos](#requisitos)
3. [Instalación](#instalación)
4. [Uso Básico](#uso-básico)
5. [Funciones Avanzadas](#funciones-avanzadas)
6. [Solución de Problemas](#solución-de-problemas)

## Introducción

DevIconGenerator es una aplicación SwiftUI que te permite generar fácilmente iconos para aplicaciones iOS, iPadOS, macOS y watchOS a partir de una sola imagen. La aplicación redimensiona automáticamente tu imagen a todos los tamaños requeridos por Apple y crea un archivo ZIP listo para usar en tu proyecto de Xcode.

## Requisitos

- macOS 12.0 o superior
- Imagen de origen preferiblemente de 1024×1024 píxeles (formato PNG o JPG)

## Instalación

1. Descarga la última versión de DevIconGenerator desde [GitHub Releases](https://github.com/manuelduarte077/AppIconGenerator/releases)
2. Arrastra la aplicación a tu carpeta de Aplicaciones
3. Si recibes una advertencia de seguridad al abrir la aplicación por primera vez:
   - Ve a Preferencias del Sistema > Seguridad y Privacidad
   - Haz clic en "Abrir de todos modos" o "Permitir"

## Uso Básico

### Paso 1: Seleccionar una Imagen

Hay dos formas de seleccionar una imagen:

**Método 1: Arrastrar y Soltar**
- Simplemente arrastra una imagen desde el Finder y suéltala en el área designada de la aplicación

**Método 2: Selección Manual**
- Haz clic en el área de imagen
- Navega hasta la ubicación de tu imagen
- Selecciona la imagen y haz clic en "Abrir"

> **Consejo**: Para obtener mejores resultados, utiliza una imagen cuadrada de 1024×1024 píxeles con fondo transparente (PNG) o sólido.

### Paso 2: Seleccionar Plataformas

Marca las casillas de las plataformas para las que deseas generar iconos:
- iPhone
- iPad
- Mac
- Apple Watch

Puedes seleccionar una o varias plataformas según tus necesidades.

### Paso 3: Exportar

1. Haz clic en el botón "Export Icons"
2. Selecciona la ubicación donde deseas guardar el archivo ZIP
3. Haz clic en "Guardar"

La aplicación generará todos los tamaños de iconos necesarios y los empaquetará en un archivo ZIP. Verás un mensaje de éxito cuando se complete el proceso.

### Paso 4: Usar los Iconos en Xcode

1. Descomprime el archivo ZIP descargado
2. En tu proyecto de Xcode, selecciona el archivo Assets.xcassets
3. Arrastra la carpeta AppIcon.appiconset al catálogo de assets
4. ¡Listo! Tus iconos están configurados para tu aplicación

## Funciones Avanzadas

### Modo Desktop vs. Modo Móvil

DevIconGenerator se adapta automáticamente según el tamaño de la ventana:

- **Modo Desktop**: Presenta una interfaz con sidebar que facilita la selección de plataformas y la visualización del icono
- **Modo Móvil**: Ofrece una experiencia optimizada con controles accesibles para dispositivos con pantallas más pequeñas

Para cambiar entre modos, simplemente redimensiona la ventana de la aplicación.

### Mensajes de Estado

La aplicación muestra diferentes mensajes según el estado del proceso:

- **En Progreso**: Indica que la generación de iconos está en curso
- **Éxito**: Confirma que los iconos se han generado correctamente
- **Error**: Proporciona información sobre cualquier problema que haya ocurrido

## Solución de Problemas

### La imagen no se carga correctamente

- Asegúrate de que la imagen esté en un formato compatible (PNG, JPG)
- Verifica que la imagen no esté dañada abriéndola en otra aplicación
- Intenta con una imagen diferente

### El botón de exportación está deshabilitado

- Debes seleccionar una imagen antes de poder exportar
- Asegúrate de haber seleccionado al menos una plataforma

### Error durante la exportación

- Verifica que tengas permisos de escritura en la ubicación seleccionada
- Asegúrate de tener suficiente espacio en disco
- Cierra y vuelve a abrir la aplicación

### La aplicación se cierra inesperadamente

- Actualiza a la última versión de DevIconGenerator
- Reinicia tu Mac y vuelve a intentarlo
- Si el problema persiste, reporta el error en [GitHub Issues](https://github.com/manuelduarte077/AppIconGenerator/issues)

