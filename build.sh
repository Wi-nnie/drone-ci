#!/bin/bash

# Just a basic script U can improvise lateron asper ur need xD 

# Edited for Tecno spark 5 Pro

MANIFEST="https://github.com/omnirom/android/tree/android-12.0 -b android-12.0"
DEVICE=TECNO_CD8j
DT_LINK="https://github.com/Wi-nnie/TECNO-CD8J-RECOVERY-TREE -b main"
DT_PATH=device/tecno/$DEVICE

echo " ===+++ Setting up Build Environment +++==="
apt install openssh-server -y
apt update --fix-missing
apt install openssh-server -y
apt install openjdk-8-jdk -y
apt-get install software-properties-common
apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
apt-get update
apt-get -qq update \
    && apt-get install -y --no-install-recommends \
    bc \
    bison \
    build-essential \
    ccache \
    curl \
    flex \
    gcc-multilib \
    git \
    g++-multilib \
    gnupg \
    gperf \
    lib32ncurses5-dev \
    lib32z-dev \
    libc6-dev-i386 \
    libgl1-mesa-dev \
    libx11-dev \
    libxml2-utils \
    lzop \
    make \
    maven \
    openjdk-8-jdk \
    python3 \
    rsync \
    schedtool \
    unzip \
    x11proto-core-dev \
    xsltproc \
    zip \
    zlib1g-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo
mkdir ~/twrp && cd ~/twrp

echo " ===+++ Syncing Recovery Sources +++==="
git config --global user.name Wi-nnie
git config --global user.email 94724733+Wi-nnie@users.noreply.github.com
git config --global credential.helper store

repo init --depth=1 -u $MANIFEST
repo sync
echo " ===+++ Cloning Device Tree +++==="
git clone --depth=1 $DT_LINK $DT_PATH

echo " ===+++ Building Recovery +++==="
export ALLOW_MISSING_DEPENDENCIES=true
export TW_THEME=portrait_hdpi
. build/envsetup.sh
echo " source build/envsetup.sh done"
lunch omni_${DEVICE}-eng || abort " lunch failed with exit status $?"
echo " lunch omni_${DEVICE}-eng done"
mka recoveryimage || abort " mka failed with exit status $?"
echo " mka recoveryimage done"

# Upload zips & recovery.img (U can improvise lateron adding telegram support etc etc)
echo " ===+++ Uploading Recovery +++==="
cd /root/twrp/out/target/product/B1p/
curl -sL https://git.io/file-transfer | sh 

./transfer wet *.zip

./transfer wet recovery.img
