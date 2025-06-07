#!/usr/bin/env bash

# =========================================================
# DevIconGenerator Release Build Script
# Creates a DMG for macOS distribution
# =========================================================

# Strict mode
set -euo pipefail
IFS=$'\n\t'

# =========================================================
# Configuration
# =========================================================
readonly APP_NAME="DevIconGenerator"
readonly APP_BUNDLE="DevIconGenerator"
PROJECT_FILE="DevIconGenerator.xcodeproj" # Eliminado readonly para permitir cambios
SCHEME_NAME="DevIconGenerator" # Eliminado readonly para permitir cambios
readonly BUILD_DIR="build"
readonly DMG_DIR="dmg-temp"
readonly EXPORT_DIR="${BUILD_DIR}/export"
readonly ARTIFACTS_DIR="artifacts"

# =========================================================
# Terminal colors
# =========================================================
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# =========================================================
# Logging functions
# =========================================================
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_section() {
    echo -e "\n${BOLD}=== $1 ===${NC}"
}

# =========================================================
# Error handling
# =========================================================
handle_error() {
    log_error "An error occurred on line $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# =========================================================
# Helper functions
# =========================================================
get_version() {
    if git describe --tags --exact-match HEAD 2>/dev/null; then
        echo "$(git describe --tags --exact-match HEAD | sed 's/^v//')"
    else
        echo "dev-$(date +%Y%m%d-%H%M%S)"
    fi
}

# =========================================================
# Asegurar que estamos en el directorio correcto
# =========================================================
ensure_correct_directory() {
    # Obtener el directorio del script
    local SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    log_info "Script directory: $SCRIPT_DIR"
    
    # Si estamos en un subdirectorio del proyecto, subir al directorio principal
    if [[ "$SCRIPT_DIR" == */DevIconGenerator/* ]]; then
        cd "$(echo "$SCRIPT_DIR" | sed 's|\(.*DevIconGenerator\).*|\1|')"
    # Si estamos en el directorio del proyecto, quedarnos ahí
    elif [[ "$SCRIPT_DIR" == */DevIconGenerator ]]; then
        cd "$SCRIPT_DIR"
    # Si estamos en el directorio padre, entrar al directorio del proyecto
    elif [ -d "$SCRIPT_DIR/DevIconGenerator" ]; then
        cd "$SCRIPT_DIR/DevIconGenerator"
    fi
    
    log_info "Working directory: $(pwd)"
}

# =========================================================
# Main functions
# =========================================================
check_dependencies() {
    log_section "Checking Dependencies"
    
    # Check for create-dmg
    if ! command -v create-dmg &> /dev/null; then
        log_warning "create-dmg not found. Installing via Homebrew..."
        if command -v brew &> /dev/null; then
            brew install create-dmg
        else
            log_error "Homebrew not found. Please install create-dmg manually:"
            log_error "  brew install create-dmg"
            exit 1
        fi
    fi
    
    # Check for xcodebuild
    if ! command -v xcodebuild &> /dev/null; then
        log_error "xcodebuild not found. Please install Xcode command line tools."
        exit 1
    fi
    
    log_success "All dependencies are installed"
}

clean_build() {
    log_section "Cleaning Previous Builds"
    
    # Remove build directories
    rm -rf "${BUILD_DIR}" "${DMG_DIR}" 
    
    # Create artifacts directory if it doesn't exist
    mkdir -p "${ARTIFACTS_DIR}"
    
    log_success "Clean completed"
}

build_app() {
    log_section "Building ${APP_NAME}"
    
    # Mostrar el directorio actual para diagnóstico
    log_info "Current directory: $(pwd)"
    log_info "Directory contents:"
    ls -la
    
    # Check if project file exists
    if [ ! -f "${PROJECT_FILE}" ] && [ ! -d "${PROJECT_FILE}" ]; then
        log_warning "Project file ${PROJECT_FILE} not found, searching for alternatives..."
        
        # Buscar alternativas de proyecto en todo el directorio
        log_info "Searching for .xcodeproj files..."
        local PROJECT_ALTERNATIVES=$(find . -name "*.xcodeproj" -type d)
        log_info "Found projects: $PROJECT_ALTERNATIVES"
        
        if [ -z "$PROJECT_ALTERNATIVES" ]; then
            log_error "No Xcode project files found"
            exit 1
        fi
        
        # Usar el primer proyecto encontrado
        PROJECT_FILE=$(echo "$PROJECT_ALTERNATIVES" | head -1)
        log_info "Using alternative project file: ${PROJECT_FILE}"
    fi
    
    # Check if scheme exists
    log_info "Checking available schemes in ${PROJECT_FILE}"
    
    # Obtener la lista de esquemas directamente del comando xcodebuild -list
    local SCHEMES_OUTPUT=$(xcodebuild -project "${PROJECT_FILE}" -list 2>/dev/null)
    
    # Extraer los esquemas de la salida
    local SCHEMES=$(echo "$SCHEMES_OUTPUT" | grep -A 100 "Schemes:" | grep -v "Schemes:" | grep -v "^$" | sed 's/^[ \t]*//')
    
    log_info "Available schemes: $SCHEMES"
    
    local SCHEME_EXISTS=false
    
    # Verificar si el esquema que queremos existe
    for scheme in $SCHEMES; do
        if [ "$scheme" == "${SCHEME_NAME}" ]; then
            SCHEME_EXISTS=true
            break
        fi
    done
    
    if [ "$SCHEME_EXISTS" == "false" ]; then
        log_warning "Scheme ${SCHEME_NAME} not found, using first available scheme"
        SCHEME_NAME=$(echo "$SCHEMES" | head -1)
        log_info "Using scheme: ${SCHEME_NAME}"
    else
        log_info "Using scheme: ${SCHEME_NAME}"
    fi
    
    log_info "Building with project: ${PROJECT_FILE}, scheme: ${SCHEME_NAME}"
    
    # Build without signing for local development
    xcodebuild -project "${PROJECT_FILE}" \
               -scheme "${SCHEME_NAME}" \
               -configuration Release \
               -derivedDataPath "${BUILD_DIR}/" \
               CODE_SIGN_IDENTITY="" \
               CODE_SIGNING_REQUIRED=NO \
               build || {
        log_error "Build failed"
        exit 1
    }
               
    log_success "Build completed successfully"
}

export_app() {
    log_section "Exporting Application"
    
    # Create export directory
    mkdir -p "${EXPORT_DIR}"
    
    # Buscar la aplicación compilada en diferentes configuraciones posibles
    local APP_PATHS=(
        "${BUILD_DIR}/Build/Products/Release/${APP_BUNDLE}.app"
        "${BUILD_DIR}/Build/Products/Release-maccatalyst/${APP_BUNDLE}.app"
    )
    
    local APP_FOUND=false
    
    # Intentar encontrar la aplicación en las rutas posibles
    for app_path in "${APP_PATHS[@]}"; do
        if [ -d "$app_path" ]; then
            log_info "Found app at: $app_path"
            cp -R "$app_path" "${EXPORT_DIR}/"
            APP_FOUND=true
            break
        fi
    done
    
    if [ "$APP_FOUND" == "false" ]; then
        # Buscar la aplicación en cualquier lugar dentro de la carpeta de compilación
        log_warning "App not found in standard locations, searching in build directory..."
        local FOUND_APP=$(find "${BUILD_DIR}" -name "${APP_BUNDLE}.app" -type d | head -1)
        
        if [ -n "$FOUND_APP" ]; then
            log_info "Found app at: $FOUND_APP"
            cp -R "$FOUND_APP" "${EXPORT_DIR}/"
            APP_FOUND=true
        else
            log_error "Could not find built app in build directory"
            exit 1
        fi
    fi
    
    log_success "App exported to ${EXPORT_DIR}/${APP_BUNDLE}.app"
}

create_dmg() {
    log_section "Creating DMG Package"
    
    # Create a temporary directory for DMG contents
    mkdir -p "${DMG_DIR}"
    
    # Copy the app to the temp directory
    cp -R "${EXPORT_DIR}/${APP_BUNDLE}.app" "${DMG_DIR}/"
    
    # Create Applications symlink for drag-and-drop installation
    ln -s /Applications "${DMG_DIR}/Applications"
    
    # Get version
    local VERSION=$(get_version)
    local DMG_NAME="${APP_NAME// /-}-${VERSION}.dmg"
    local DMG_PATH="${ARTIFACTS_DIR}/${DMG_NAME}"
    
    log_info "Creating DMG: ${DMG_NAME}"
    
    # Buscar el icono para el volumen
    local ICON_PATH=$(find . -name "AppIcon.appiconset" -type d | head -1)
    local ICON_PARAM=""
    
    if [ -n "$ICON_PATH" ]; then
        local VOLUME_ICON=$(find "$ICON_PATH" -name "*1024*.png" | head -1)
        if [ -n "$VOLUME_ICON" ]; then
            log_info "Usando icono: $VOLUME_ICON"
            ICON_PARAM="--volicon \"$VOLUME_ICON\""
        fi
    fi
    
    # Create the DMG
    create-dmg \
        --volname "${APP_NAME}" \
        $ICON_PARAM \
        --window-pos 200 120 \
        --window-size 800 400 \
        --icon-size 100 \
        --icon "${APP_BUNDLE}.app" 165 180 \
        --icon "Applications" 435 180 \
        --hide-extension "${APP_BUNDLE}.app" \
        --text-size 14 \
        --format ULFO \
        --filesystem HFS+ \
        --skip-jenkins \
        "${DMG_PATH}" \
        "${DMG_DIR}/"
      
    # Calculate checksum
    shasum -a 256 "${DMG_PATH}" > "${DMG_PATH}.sha256"
    
    log_success "DMG created: ${DMG_PATH}"
    log_success "Checksum: $(cat ${DMG_PATH}.sha256)"
}

cleanup() {
    log_section "Cleaning Up"
    
    rm -rf "${BUILD_DIR}" "${DMG_DIR}"
    
    log_success "Cleanup completed"
}

show_usage() {
    echo -e "${BOLD}${APP_NAME} Release Build Script${NC}"
    echo
    echo "Usage: $(basename "$0") [options]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -k, --keep     Keep build artifacts (don't cleanup)"
    echo "  -v, --version  Show version and exit"
    echo "  -c, --clean    Only clean previous builds"
    echo
    echo "This script builds ${APP_NAME} and creates a DMG for distribution."
}

# =========================================================
# Command line argument parsing
# =========================================================
KEEP_ARTIFACTS=false
CLEAN_ONLY=false

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -k|--keep)
                KEEP_ARTIFACTS=true
                shift
                ;;
            -c|--clean)
                CLEAN_ONLY=true
                shift
                ;;
            -v|--version)
                echo "$(get_version)"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# =========================================================
# Main execution
# =========================================================
main() {
    log_section "Starting ${APP_NAME} Release Build"
    
    # Asegurar que estamos en el directorio correcto
    ensure_correct_directory
    
    parse_args "$@"
    
    if [[ "${CLEAN_ONLY}" == true ]]; then
        clean_build
        log_success "Clean operation completed"
        exit 0
    fi
    
    check_dependencies
    clean_build
    build_app
    export_app
    create_dmg
    
    if [[ "${KEEP_ARTIFACTS}" == false ]]; then
        cleanup
    else
        log_warning "Keeping build artifacts as requested"
    fi
    
    log_section "Build Process Complete"
    log_success "Release build completed successfully!"
    log_info "DMG file is ready for distribution in the ${ARTIFACTS_DIR} directory."
}

# Run main function with all arguments
main "$@"