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
    wayland-protocols-devel

# rootkit stuff
dnf install \
    rkhunter \
    clamav

# toys
dnf install \
    cowsay \
    fortune \
    sl

