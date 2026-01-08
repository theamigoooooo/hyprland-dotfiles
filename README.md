# Dotfiles

Personal configuration files managed with **[GNU Stow](https://www.gnu.org/software/stow/)**.

Each directory (e.g. `nvim/`, `kitty/`, `waybar/`) is a _stow package_ containing config files that will be symlinked to your home directory.

<p align="center">
  <img src="demo.gif" width="600" alt="Demo">
</p>

---

## Structure

```yaml
dotfiles/
├── hypr/ → Hyprland configuration
├── kitty/ → Kitty terminal settings
├── nvim/ → Neovim configuration
├── setwall/ → Wallpaper + color sync script
├── tmux/ → Tmux configuration
├── waybar/ → Waybar status bar
└── wofi/ → Wofi launcher config
```

---

## Setup

### 1. Clone the repo

```bash
git clone https://github.com/rrakesh28/dotfiles.git ~/dotfiles
cd ~/dotfiles
2. Install GNU Stow
bash
Copy code
# Arch / Manjaro
sudo pacman -S stow

# Debian / Ubuntu
sudo apt install stow
3. Stow your configs
From inside ~/dotfiles, run:
stow hypr kitty nvim tmux waybar wofi
This will create symlinks in your home directory pointing to these folders.

To verify:
ls -l ~/.config
4. Unstow (remove symlinks)
stow -D kitty
5. Restow (relink after changes)
stow -R hypr nvim
```

## 🎨 Wallpaper and Color Scheme

The `setwall` folder contains a script to **set your wallpaper** and **update your color scheme** automatically.

### 🧩 Installation

1. Copy the script to your local binaries directory:

```bash
cp ~/dotfiles/setwall/setwall.sh ~/.local/bin/setwall
```

Give it execute permission:

```bash
chmod +x ~/.local/bin/setwall
```

(Optional) Ensure ~/.local/bin is in your PATH:

```bash
echo $PATH
```

If not, add this to your shell config (~/.zshrc or ~/.bashrc):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

#### Usage

Once installed, you can run it globally:

```bash
setwall ~/Pictures/image.jpg
```

This will:
Set the selected image as your wallpaper

Regenerate and apply your terminal, Waybar, and GTK color schemes

Refresh Hyprland or other configured components

This script typically:
Changes the current wallpaper

Regenerates terminal, Waybar, and GTK theme colors

Applies updates across Hyprland and related apps

Tips
Use stow -n <pkg> for a dry run (see what would change)

Commit your changes:

```bash
Copy code
git add .
git commit -m "feat: add shell script to set wallpaper and update color scheme"
git push
```

🧑‍💻 License
Feel free to copy, modify, and reuse any part of this setup.
