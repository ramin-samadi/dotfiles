```sh
pactl list sinks short
```
```
42      alsa_output.pci-0000_01_00.1.hdmi-stereo        PipeWire        s32le 2ch 48000Hz       SUSPENDED
43      alsa_output.pci-0000_00_1b.0.analog-stereo      PipeWire        s32le 2ch 48000Hz       SUSPENDED
1231    alsa_output.usb-Razer_Razer_Nommo_Chroma-02.analog-stereo       PipeWire        s16le 2ch 48000Hz       SUSPENDED
```

```sh
pactl set-default-sink 1231
```

<hr>

### AMD RADEON
```sh
flatpak search grapejuice
flatpak install net.brinkervii.grapejuice -y
flatpak run net.brinkervii.grapejuice
flatpak run net.brinkervii.grapejuice first-time-setup
flatpak run net.brinkervii.grapejuice app
flatpak uninstall net.brinkervii.grapejuice -y

sudo pacman -S git python-pip cairo gtk3 gobject-introspection desktop-file-utils xdg-utils xdg-user-dirs gtk-update-icon-cache shared-mime-info mesa-utils
sudo pacman -Syu wine gnutls lib32-gnutls libpulse lib32-libpulse

git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice
cd /tmp/grapejuice
./install.py

grapejuice
grapejuice first-time-setup
grapejuice app
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
grapejuice app
```

### NVIDIA
```sh
flatpak search grapejuice
flatpak install net.brinkervii.grapejuice -y
flatpak run net.brinkervii.grapejuice
flatpak run net.brinkervii.grapejuice first-time-setup
flatpak run net.brinkervii.grapejuice app
flatpak uninstall net.brinkervii.grapejuice -y

sudo pacman -S git python-pip cairo gtk3 gobject-introspection desktop-file-utils xdg-utils xdg-user-dirs gtk-update-icon-cache shared-mime-info mesa-utils
sudo pacman -Syu wine gnutls lib32-gnutls libpulse lib32-libpulse

git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice
cd /tmp/grapejuice
./install.py

grapejuice
grapejuice first-time-setup
grapejuice app
sudo pacman -S --needed lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
grapejuice app
```
