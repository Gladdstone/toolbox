# build tools
dnf group install development-tools c-development
dnf install \
    gcc \
    cmake \
    libxcb-devel \
    libxkbcommon-devel \
    libxkbcommon-x11-devel \
    libX11-devel \
    libXcursor-devel \
    libXi-devel \
    libXrandr-devel \
    libXinerama-devel \
    wayland-devel \
    wayland-protocols-devel \
    libdrm-devel \
    libepoxy-devel


# gtk
dnf install pango-devel harfbuzz-devel glib2-devel \
    cairo-devel cairo-gobject-devel glib2-devel gobject-introspection-devel \
    libdbusmenu-devel \
    gdk-pixbuf2-devel \
    gtk3-devel \
    libdbusmenu-gtk3-devel \
    gtk-layer-shell-devel

# rootkit stuff
dnf install \
    rkhunter \
    clamav

# toys
dnf install \
    cowsay \
    fortune \
    sl

dnf copr enable lihaohong/yazi
dnf install yazi

# set screen lock
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 600
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock true

# eww setup
cd ~/code
git clone https://github.com/elkowar/eww
cd ./eww
cargo build --release --no-default-features --features=wayland
cd ~/
mkdir -p ./.config/eww/
touch ./.config/eww/eww.yuck ./.config/eww/eww.scss

cargo install viu

