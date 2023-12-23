#!/bin/bash

trap 'RET=$? ; echo -e >&2 "\n\x1b[31mFailed installing dependencies. Could be a bug in the installer or unsupported platform. Open a bug report over at https://github.com/luxonis/depthai - exited with status $RET at line $LINENO \x1b[0m\n" ;
exit $RET' ERR

readonly linux_pkgs=(
    python3
    python3-pip
    udev
    cmake
    git
    python3-numpy
)

readonly ubuntu_pkgs=(
    ${linux_pkgs[@]}
    build-essential
    libgtk2.0-dev
    pkg-config
    libavcodec-dev
    libavformat-dev
    libswscale-dev
    python3-dev
    libtbb12
    libtbb-dev
    libjpeg-dev
    libpng-dev
    libtiff-dev
    ffmpeg
    libsm6
    libxext6
    libgl1-mesa-dri
    python3-pyqt5
    python3-pyqt5.qtquick
    qml-module-qtquick-controls2
    qml-module-qt-labs-platform
    qtdeclarative5-dev
    qml-module-qtquick2
    qtbase5-dev
    qtchooser
    qt5-qmake
    qtbase5-dev-tools
    qml-module-qtquick-layouts
    qml-module-qtquick-window2
)

readonly ubuntu_pkgs_pre22_04=(
    "${ubuntu_pkgs[@]}"
    libtbb12
    libdc1394-22-dev
)

readonly ubuntu_pkgs_post22_04=(
    "${ubuntu_pkgs[@]}"
    libtbbmalloc2
    # Check if there's a replacement for libdc1394-22-dev or if it's no longer needed
)

readonly ubuntu_arm_pkgs=(
    "${ubuntu_pkgs[@]}"
    libdc1394-22-dev
    libhdf5-dev
    libatlas-base-dev
    libjasper-dev
    libilmbase-dev
    libopenexr-dev
    libgstreamer1.0-dev
)

readonly fedora_pkgs=(
    ${linux_pkgs[@]}
    gtk2-devel
    tbb-devel
    libjpeg-turbo-devel
    libpng-devel
    libtiff-devel
    libdc1394-devel
    # Additional packages for Fedora may be added here
)

print_action () {
    green="\e[0;32m"
    reset="\e[0;0m"
    printf "\n$green >>$reset $*\n"
}
print_and_exec () {
    print_action $*
    $*
}

if [[ $(uname) == "Darwin" ]]; then
    # ... [Remainder of the script for Darwin]
elif [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ "$ID" == "ubuntu" || "$ID" == "debian" || "$ID_LIKE" == "ubuntu" || "$ID_LIKE" == "debian" || "$ID_LIKE" == "ubuntu debian" ]]; then
        # ... [Ubuntu/Debian specific installation commands]
    elif [[ "$ID" == "fedora" ]]; then
        # ... [Fedora specific installation commands]
    else
        echo "ERROR: Distribution not supported"
        exit 99
    fi
    # ... [Post-installation commands]
else
    echo "ERROR: Host not supported"
    exit 99
fi

echo "Finished installing global libraries."
