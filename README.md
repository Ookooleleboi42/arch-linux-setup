Update?
# 🧠 Arch Linux Setup Backup & Restore

A complete guide to saving your current Arch Linux system setup and restoring it on another machine.

---

## ✅ 1. Backup Your System

### 📜 Save this as `save-arch-setup.sh` and run it:

```bash
#!/bin/bash

set -e
echo "📦 Arch Linux Setup Backup Script"

BACKUP_DIR=~/arch-linux-setup
mkdir -p "$BACKUP_DIR"/{dotfiles,.config}

echo "📁 Created backup folder at $BACKUP_DIR"

# Save official packages
pacman -Qqe > "$BACKUP_DIR/pkglist.txt"

# Save AUR packages
pacman -Qqm > "$BACKUP_DIR/aurlist.txt"

# Common dotfiles
DOTFILES=(.bashrc .zshrc .vimrc .profile .xinitrc .bash_profile)
for file in "${DOTFILES[@]}"; do
  [ -f "$HOME/$file" ] && cp "$HOME/$file" "$BACKUP_DIR/dotfiles/"
done

# Selected .config folders
CONFIG_DIRS=(kitty hypr sway waybar nvim fish starship wofi)
for dir in "${CONFIG_DIRS[@]}"; do
  [ -d "$HOME/.config/$dir" ] && cp -r "$HOME/.config/$dir" "$BACKUP_DIR/.config/"
done

echo "✅ Setup saved to $BACKUP_DIR"
```

---

## 📤 2. Push to GitHub

### 💻 Terminal Steps:

```bash
cd ~/arch-linux-setup

# Start a Git repo
git init
git checkout -b main

# Add and commit files
git add .
git commit -m "Initial commit"

# Set your Git identity (if not set)
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# Connect to GitHub (repo must already exist)
git remote add origin https://github.com/YOUR_USERNAME/arch-linux-setup.git

# Push to GitHub
git push -u origin main
```

> ⚠️ If Git prompts for a password, use a **Personal Access Token (PAT)** instead.

---

## 🛠 If You See Errors, Try This:

* **403 or password error?**
  Use a [GitHub personal access token](https://github.com/settings/tokens) instead of your password.

* **"refspec main does not match any"?**
  You forgot to commit before pushing. Run:

  ```bash
  git add .
  git commit -m "Initial commit"
  ```

* **"Write access not granted"?**
  You’re either pushing to a repo you don’t own or you're not authenticated properly.

* **"Need to specify how to reconcile divergent branches"?**
  Run:

  ```bash
  git pull --rebase
  ```

  Or set a default pull behavior:

  ```bash
  git config --global pull.rebase true
  ```

---

## 🔄 3. Restore on Another Machine

### 📅 Clone and run the install script:

```bash
git clone https://github.com/YOUR_USERNAME/arch-linux-setup.git
cd arch-linux-setup
chmod +x install-arch-setup.sh
./install-arch-setup.sh
```

### 📜 Save this as `install-arch-setup.sh`:

```bash
#!/bin/bash

set -e
echo "🔄 Arch Linux Setup Restore Script"

BACKUP_DIR="$(pwd)"

# Install official packages
[ -f pkglist.txt ] && sudo pacman -Syu --needed - < pkglist.txt

# Install AUR packages
if [ -f aurlist.txt ]; then
  if command -v yay >/dev/null 2>&1; then
    yay -S --needed - < aurlist.txt
  else
    echo "⚠️  AUR helper (yay) not found. Install it manually first."
  fi
fi

# Restore dotfiles
[ -d dotfiles ] && cp -v dotfiles/* ~/

# Restore config folders
[ -d .config ] && cp -r .config/* ~/.config/

echo "✅ Restore complete. You may want to restart your session."
```

---

## 🔐 Optional: .gitignore

Create a `.gitignore` file to exclude sensitive files and clutter:

```
*.swp
*.log
.cache/
.local/
.gnupg/
.ssh/
.aws/
```

---










git clone https://github.com/YOUR_USERNAME/arch-linux-setup.git
cd arch-linux-setup
chmod +x install-arch-setup.sh
./install-arch-setup.sh
