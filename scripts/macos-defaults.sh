#!/bin/bash
# =============================================================================
# macOS Defaults - Developer-Friendly Settings
# =============================================================================
# Run once after fresh macOS install. Some changes require logout/restart.
# Review before running - customize to your preferences!
# =============================================================================

set -e

echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                    🍎 macOS DEFAULTS                              ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "⚠️  This will change system settings. Some require restart."
read -p "Continue? (y/n) " -n 1 -r
echo ""
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 1

# Close System Preferences to prevent overriding
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# =============================================================================
# General UI/UX
# =============================================================================
echo "🎨 Setting General UI preferences..."

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# =============================================================================
# Keyboard
# =============================================================================
echo "⌨️  Setting Keyboard preferences..."

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys (enable key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Full keyboard access for all controls (Tab through dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# =============================================================================
# Trackpad
# =============================================================================
echo "🖱️  Setting Trackpad preferences..."

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# =============================================================================
# Finder
# =============================================================================
echo "📁 Setting Finder preferences..."

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When searching, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

# =============================================================================
# Dock
# =============================================================================
echo "🚀 Setting Dock preferences..."

# Set Dock icon size
defaults write com.apple.dock tilesize -int 48

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Speed up Dock auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.3

# =============================================================================
# Screenshots
# =============================================================================
echo "📸 Setting Screenshot preferences..."

# Create Screenshots folder
mkdir -p "$HOME/Screenshots"

# Save screenshots to ~/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# =============================================================================
# Safari (if used)
# =============================================================================
echo "🌐 Setting Safari preferences..."

# Enable Safari's develop menu and web inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# =============================================================================
# Activity Monitor
# =============================================================================
echo "📊 Setting Activity Monitor preferences..."

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# =============================================================================
# TextEdit
# =============================================================================
echo "📝 Setting TextEdit preferences..."

# Use plain text mode for new documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# =============================================================================
# Apply Changes
# =============================================================================
echo ""
echo "🔄 Restarting affected applications..."

for app in "Activity Monitor" "Dock" "Finder" "Safari" "SystemUIServer"; do
    killall "${app}" &>/dev/null || true
done

echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                     ✅ DEFAULTS APPLIED!                          ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "Note: Some changes require a logout/restart to take effect."
echo ""
